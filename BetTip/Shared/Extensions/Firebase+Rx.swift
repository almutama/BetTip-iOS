//
//  Firebase+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 24.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import FirebaseDatabase
import RxSwift
import Result
import Reactant
import ObjectMapper

protocol FirebaseEntity {
    var id: String? { get set }
}

protocol FirebaseValue {
    associatedtype FirebaseRepresentationType
    
    func serialize() -> FirebaseRepresentationType?
    
    static func deserialize(firebaseValue: FirebaseRepresentationType) -> Self?
}

extension String: FirebaseValue {
    typealias FirebaseRepresentationType = String
    
    func serialize() -> FirebaseRepresentationType? {
        return self
    }
    
    static func deserialize(firebaseValue: FirebaseRepresentationType) -> String? {
        return firebaseValue
    }
}

enum FirebaseFetchError: Error {
    case deserializeError(DataSnapshot)
    case readDenied(Error)
}

enum FirebaseStoreError: Error {
    case serializeError
    case writeDenied(Error)
}

extension ServerValue {
    static var swiftTimestamp: [String: String] {
        let timestamp = self.timestamp()
        let key = timestamp.keys.first?.description ?? ".sv"
        let value = timestamp[key] as? String ?? "timestamp"
        return [key: value]
    }
}

extension DatabaseQuery {
    func exists() -> Observable<Bool> {
        return Observable.create { observer in
            let handle = self.observe(.value,
                                      with: { snapshot in
                                        observer.onNext(snapshot.exists())
            },
                                      withCancel: { _ in
                                        observer.onLast(false)
            })
            return Disposables.create {
                self.removeObserver(withHandle: handle)
            }
        }
    }
    
    func fetch<T: FirebaseValue>(_: T.Type = T.self, event: DataEventType = .value)
        -> Observable<Result<T, FirebaseFetchError>> {
            return Observable.create { observer in
                let handle = self.observe(event, with: { snapshot in
                    if let
                        snapshotValue = snapshot.value as? T.FirebaseRepresentationType,
                        let object = T.deserialize(firebaseValue: snapshotValue) {
                        observer.onNext(.success(object))
                    } else {
                        observer.onNext(.failure(.deserializeError(snapshot)))
                    }
                }, withCancel: { error in
                    observer.onLast(.failure(.readDenied(error)))
                })
                return Disposables.create {
                    self.removeObserver(withHandle: handle)
                }
            }
    }
    
    func fetchArray<T: Mappable>(_: T.Type = T.self) -> Observable<Result<[T], FirebaseFetchError>> {
        return Observable.create { observer in
            let handle = self.observe(.value, with: { snapshot in
                let array = snapshot.children.flatMap { child -> T? in
                    guard let childSnapshot = child as? DataSnapshot,
                        let childDictionary = childSnapshot.value as? [String: AnyObject] else { return nil }
                    return  Mapper<T>().map(JSON: childDictionary)
                }
                observer.onNext(.success(array))
            }, withCancel: { error in
                observer.onLast(.failure(.readDenied(error)))
            })
            return Disposables.create {
                self.removeObserver(withHandle: handle)
            }
        }
    }
}

extension DatabaseReference {
    func store<T: Mappable>(_ objects: [T]) -> Observable<[Result<T, FirebaseStoreError>]> where T: FirebaseEntity {
        return Observable.from(objects.map(store)).concat().reduce([]) { accumulator, result in
            accumulator + [result]
        }
    }
    
    func store<T: Mappable>(_ object: T) -> Observable<Result<T, FirebaseStoreError>> where T: FirebaseEntity {
        return Observable.create { observer in
            var mutableObject = object
            let key: String
            if let id = mutableObject.id {
                key = id
            } else {
                key = self.childByAutoId().key
                mutableObject.id = key
            }
            
            let dictionary = Mapper<T>().toJSON(mutableObject)
            
            self.child(key).setValue(dictionary) { error, reference in
                if let error = error {
                    observer.onLast(.failure(.writeDenied(error)))
                } else {
                    observer.onLast(.success(mutableObject))
                }
            }
            return Disposables.create()
        }
    }
    
    func store<T: Mappable>(_ object: T, forKey key: String? = nil) ->
        Observable<Result<(key: String, object: T), FirebaseStoreError>> {
            return Observable.create { observer in
                var dictionary = Mapper<T>().toJSON(object)
                
                let childKey = key ?? self.childByAutoId().key
                
                dictionary["id"] = childKey
                
                self.child(childKey).setValue(dictionary) { error, reference in
                    if let error = error {
                        observer.onLast(.failure(.writeDenied(error)))
                    } else {
                        observer.onLast(.success((key: childKey, object: object)))
                    }
                }
                return Disposables.create()
            }
    }
    
    // TODO: Fix success condition
    func delete<T: Mappable>(_ object: T) -> Observable<Result<Void, FirebaseStoreError>> where T: FirebaseEntity {
        return Observable.create { observer in
            guard let key = object.id else {
                //observer.onLast(.success())
                return Disposables.create()
            }
            
            self.child(key).removeValue { error, reference in
                if let error = error {
                    observer.onLast(.failure(.writeDenied(error)))
                } else {
                    //observer.onLast(.success())
                }
            }
            return Disposables.create()
        }
        
    }
}

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
    
    func fetch<T: Mappable>(_: T.Type = T.self, event: DataEventType = .value)
        -> Observable<Result<T, FirebaseFetchError>> {
            return Observable.create { observer in
                let handle = self.observe(event, with: { snapshot in
                    if let snapshotDictionary = snapshot.value as? [String: AnyObject],
                        let object: T = Mapper<T>().map(JSON: snapshotDictionary) {
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
    func storeWithObjects<T: Mappable>(_ objects: [T]) -> Observable<[Result<T, FirebaseStoreError>]> where T: BaseModel {
        return Observable.from(objects.map(storeObject)).concat().reduce([]) { accumulator, result in
            accumulator + [result]
        }
    }
    
    func storeObject<T: Mappable>(_ object: T) -> Observable<Result<T, FirebaseStoreError>> where T: BaseModel {
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
            
            self.child(key).setValue(dictionary) { error, _ in
                if let error = error {
                    observer.onLast(.failure(.writeDenied(error)))
                } else {
                    observer.onLast(.success(mutableObject))
                }
            }
            return Disposables.create()
        }
    }
    
    func storeWithKey<T: Mappable>(_ object: T, forKey key: String? = nil) ->
        Observable<Result<(key: String, object: T), FirebaseStoreError>> {
            return Observable.create { observer in
                var dictionary = Mapper<T>().toJSON(object)
                
                let childKey = key ?? self.childByAutoId().key
                
                dictionary["id"] = childKey
                
                self.child(childKey).setValue(dictionary) { error, _ in
                    if let error = error {
                        observer.onLast(.failure(.writeDenied(error)))
                    } else {
                        observer.onLast(.success((key: childKey, object: object)))
                    }
                }
                return Disposables.create()
            }
    }
    
    //TODO: .success condition
    func delete<T: Mappable>(_ object: T) -> Observable<Result<Void, FirebaseStoreError>> where T: BaseModel {
        return Observable.create { observer in
            guard let key = object.id else {
                observer.onLast(.success(()))
                return Disposables.create()
            }
            
            self.child(key).removeValue { error, _ in
                if let error = error {
                    observer.onLast(.failure(.writeDenied(error)))
                } else {
                    observer.onLast(.success(()))
                }
            }
            return Disposables.create()
        }
    }
    
    func update<T: Mappable>(_ object: T) -> Observable<Result<T, FirebaseStoreError>> where T: BaseModel {
        return Observable.create { observer in
            guard let key = object.id else {
                observer.onLast(.success((object)))
                return Disposables.create()
            }
            
            let dictionary = Mapper<T>().toJSON(object)
            
            self.child(key).updateChildValues(dictionary) { error, _ in
                if let error = error {
                    observer.onLast(.failure(.writeDenied(error)))
                } else {
                    observer.onLast(.success((object)))
                }
            }
            return Disposables.create()
        }
    }
}

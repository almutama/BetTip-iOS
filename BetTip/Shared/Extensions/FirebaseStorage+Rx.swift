//
//  FirebaseStorage+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import FirebaseStorage
import RxSwift

private let logger = Log.createLogger()

public extension StorageReference {
    // MARK: UPLOAD
    
    /**
     Asynchronously uploads data to the currently specified StorageReference.
     This is not recommended for large files, and one should instead upload a file from disk.
     
     @param uploadData The NSData to upload.
     @param metadata StorageMetaData containing additional information (MIME type, etc.) about the object being uploaded.
     
     */
    func putData(data: NSData, metaData: StorageMetadata? = nil) -> Observable<StorageUploadTask> {
        return Observable.create { observer in
            observer.onNext(self.putData(data as Data, metadata: metaData, completion: { (metadata, error) in
                if error != nil {
                    logger.log(.error, "error when putting data for firebase: \(error?.localizedDescription ?? "")")
                }
                logger.log(.debug, "metadata when putting data for firebase: \(String(describing: metadata))")
            }))
            return Disposables.create()
        }
    }
    
    /**
     Asynchronously upload data to the currently specified StorageReference.
     This is not recommended for large files, and one should instead upload a file from disk.
     This method will output upload progress and success or failure states.
     
     @param uploadData The NSData to upload.
     @param metadata StorageMetaData containing additional information (MIME type, etc.) about the object being uploaded.
     */
    func putDataWithProgress(data: NSData, metaData: StorageMetadata? = nil) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return putData(data: data, metaData: metaData).storageStatus()
    }
    
    /**
     Asynchronously uploads a file to the currently specified StorageReference.
     
     @param fileURL A URL representing the system file path of the object to be uploaded.
     @param metadata StorageMetadata containing additional information (MIME type, etc.) about the object being uploaded.
     */
    func putFile(path: NSURL, metadata: StorageMetadata? = nil) -> Observable<StorageUploadTask> {
        return Observable.create { observer in
            let uploadTask = self.putFile(from: path as URL, metadata: metadata, completion: { (metadata, error) in
                if error != nil {
                    logger.log(.error, "error when putting file for firebase: \(error?.localizedDescription ?? "")")
                }
                logger.log(.debug, "metadata when putting file for firebase: \(String(describing: metadata))")
            })
            observer.onNext(uploadTask)
            return Disposables.create {
                uploadTask.cancel()
            }
        }
    }
    
    /**
     Asynchronously uploads a file to the currently specified StorageReference.
     This method will output upload progress and success or failure states.
     
     @param fileURL A URL representing the system file path of the object to be uploaded.
     @param metadata StorageMetadata containing additional information (MIME type, etc.) about the object being uploaded.
     */
    func putFileWithProgress(path: NSURL, metaData: StorageMetadata? = nil) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return putFile(path: path).storageStatus()
    }
    
    // MARK: DOWNLOAD
    
    /**
     Asynchronously downloads the object at the StorageReference to an NSData Object in memory.
     An NSData of the provided max size will be allocated, so ensure that the device has enough free
     memory to complete the download. For downloading large files, writeToFile may be a better option.
     
     @param size The maximum size in bytes to download.  If the download exceeds this size the task will be cancelled and an error will be returned.
     */
    func dataWithMaxSize(size: Int64) -> Observable<Data?> {
        return Observable.create { observer in
            let download = self.getData(maxSize: size, completion: { (data, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                download.cancel()
            }
        }
    }
    /**
     Asynchronously downloads the object at the StorageReference to an NSData Object in memory.
     An NSData of the provided max size will be allocated, so ensure that the device has enough free
     memory to complete the download. For downloading large files, writeToFile may be a better option.
     
     This method will output upload progress and success states.
     
     @param size The maximum size in bytes to download.  If the download exceeds this size the task will be cancelled and an error will be returned.
     */
    func dataWithMaxSizeProgress(size: Int64) -> Observable<(NSData?, StorageTaskSnapshot?, StorageTaskStatus?)> {
        return Observable.create { observer in
            let download = self.getData(maxSize: size, completion: { (data, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext((data! as NSData, nil, .success))
                    observer.onCompleted()
                }
            })
            
            download.observe(.progress, handler: { (snapshot: StorageTaskSnapshot) in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((nil, snapshot, .progress))
                }
            })
            
            return Disposables.create {
                download.cancel()
            }
        }
    }
    
    /**
     Asynchronously downloads the object at the current path to a specified system filepath.
     
     @param fileURL A file system URL representing the path the object should be downloaded to.
     */
    func writeToFile(localURL: NSURL) -> Observable<NSURL?> {
        return Observable.create { observer in
            let download = self.write(toFile: localURL as URL, completion: { (url, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(url as NSURL?)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                download.cancel()
            }
        }
    }
    
    /**
     Asynchronously downloads the object at the current path to a specified system filepath.
     
     This method will output upload progress and success states.
     
     @param fileURL A file system URL representing the path the object should be downloaded to.
     */
    func writeToFileWithProgress(localURL: NSURL) -> Observable<(NSURL?, StorageTaskSnapshot?, StorageTaskStatus?)> {
        return Observable.create { observer in
            let download = self.write(toFile: localURL as URL, completion: { (url, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext((url! as NSURL, nil, .success))
                    observer.onCompleted()
                }
            })
            
            download.observe(.progress, handler: { (snapshot: StorageTaskSnapshot) in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((nil, snapshot, .progress))
                }
            })
            
            return Disposables.create {
                download.cancel()
            }
        }
    }
    
    /**
     Asynchronously retrieves a long lived download URL with a revokable token.
     This can be used to share the file with others, but can be revoked by a developer
     in the firebase Console if desired.
     */
    func downloadURL() -> Observable<URL?> {
        return Observable.create { observable in
            self.downloadURL(completion: { (url, error) in
                if let error = error {
                    observable.onError(error)
                } else {
                    observable.onNext(url)
                    observable.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    // MARK: DELETE
    /**
     Deletes the object at the current path.
     */
    func delete() -> Observable<Void> {
        return Observable.create { observable in
            self.delete(completion: { error in
                if let error = error {
                    observable.onError(error)
                } else {
                    observable.onNext(())
                    observable.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    // MARK: METADATA
    /**
     Retrieves metadata associated with an object at the current path.
     */
    func metadata() -> Observable<StorageMetadata?> {
        return Observable.create { observer in
            self.getMetadata(completion: { (metadata, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(metadata)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    /**
     Updates the metadata associated with an object at the current path.
     
     @param metadata An StorageMetadata object with the metadata to update.
     */
    func updateMetadata(metadata: StorageMetadata) -> Observable<StorageMetadata?> {
        return Observable.create { observer in
            self.updateMetadata(metadata, completion: { (metadata, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(metadata)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
}

extension StorageUploadTask {
    func observeStatus(status: StorageTaskStatus) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return Observable.create { observer in
            let observeStatus = self.observe(status, handler: { (snapshot: StorageTaskSnapshot) in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((snapshot, status))
                    if status == .success {
                        observer.onCompleted()
                    }
                }
            })
            return Disposables.create {
                self.removeObserver(withHandle: observeStatus)
            }
        }
    }
}

extension StorageDownloadTask {
    func observeStatus(status: StorageTaskStatus) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return Observable.create { observer in
            let observeStatus = self.observe(status, handler: { snapshot in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((snapshot, status))
                    if status == .success {
                        observer.onCompleted()
                    }
                }
            })
            return Disposables.create {
                self.removeObserver(withHandle: observeStatus)
            }
        }
    }
}

extension ObservableType where E: StorageUploadTask {
    func storageStatus() -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return self.flatMap { (uploadTask: StorageUploadTask) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> in
            let progressStatus = uploadTask.observeStatus(status: .progress)
            let successStatus = uploadTask.observeStatus(status: .success)
            let failureStatus = uploadTask.observeStatus(status: .failure)
            
            let merged = Observable.of(progressStatus, successStatus, failureStatus).merge()
            return merged
        }
    }
}

extension ObservableType where E: StorageDownloadTask {
    func storageStatus() -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return self.flatMap { (downloadTask: StorageDownloadTask) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> in
            let progressStatus = downloadTask.observeStatus(status: .progress)
            let successStatus = downloadTask.observeStatus(status: .success)
            let failureStatus = downloadTask.observeStatus(status: .failure)
            
            let merged = Observable.of(progressStatus, successStatus, failureStatus).merge()
            return merged
        }
    }
}

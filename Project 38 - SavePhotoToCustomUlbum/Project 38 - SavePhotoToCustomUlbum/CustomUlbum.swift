//
//  CustomUlbum1.swift
//  Project 38 - SavePhotoToCustomUlbum
//
//  Created by 陈炯 on 16/7/25.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import Photos

class CustomUlbum {
    
    static let sharedInstance = CustomUlbum()
    
    var assetCollection: PHAssetCollection!
    var albumFound : Bool = false
    var photosAsset: PHFetchResult<AnyObject>!
    var collection: PHAssetCollection!
    var assetCollectionPlaceholder: PHObjectPlaceholder!
    
    //MARK: 创建相册
    private func createAlbum(name: String) {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", name)
        let collection : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            
            self.albumFound = true
            assetCollection = collection.firstObject
            
        } else {
            
            PHPhotoLibrary.shared().performChanges({
                
                let createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
                self.assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
                
                }, completionHandler: { success, error in
                    self.albumFound = (success ? true: false)
                    
                    if success {
                        
                        let collectionFetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [self.assetCollectionPlaceholder.localIdentifier], options: nil)
                        print(collectionFetchResult)
                        self.assetCollection = collectionFetchResult.firstObject
                    }
            })
        }
    }
    
    //MARK: 存储图片
    func saveImage(image: UIImage, ulbumName: String) {
        
        self.createAlbum(name: ulbumName)
        
        if self.assetCollection != nil {
            PHPhotoLibrary.shared().performChanges({
                
                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
                albumChangeRequest?.addAssets(assetPlaceholder as! NSFastEnumeration)
                }, completionHandler: nil)
        }
    }
    

    
}


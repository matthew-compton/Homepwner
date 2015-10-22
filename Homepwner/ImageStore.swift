//
//  ImageStore.swift
//  Homepwner
//
//  Created by Matthew Compton on 10/21/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
        
        let imageURL = imageURLforKey(key)
        if let data = UIImagePNGRepresentation(image) {
            data.writeToURL(imageURL, atomically: true)
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.objectForKey(key) as? UIImage {
            return existingImage
        }
        
        let imageURL = imageURLforKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
        
        let imageURL = imageURLforKey(key)
        do {
            try NSFileManager.defaultManager().removeItemAtURL(imageURL)
        } catch let deleteError {
            print("Error deleting images: \(deleteError)")
        }
    }
    
    
    func imageURLforKey(key: String) -> NSURL {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent(key)
    }
    
    
    
}

//
//  GalleryViewController.swift
//  PhotoAmazing
//
//  Created by TRAMS on 9/20/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {

  var allPhotos:NSMutableArray?
  var allAssets:PHFetchResult?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      allPhotos = NSMutableArray()
      allAssets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
      
      for i in 0...allAssets!.count{
        let asset:PHAsset = allAssets!.objectAtIndex(i) as! PHAsset

        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.Default, options: nil, resultHandler:{(image,infor) in
            self.allPhotos!.addObject(image!)
          })
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

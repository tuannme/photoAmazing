//
//  GalleryViewController.swift
//  PhotoAmazing
//
//  Created by TRAMS on 9/20/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit
import Photos

class GalleryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
  @IBOutlet weak var galleryCollectionView: UICollectionView!
  @IBOutlet weak var imageDetailView: UIImageView!
  
  @IBAction func backAction(sender: AnyObject) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  let requestOptions = PHImageRequestOptions()
  let fetchOptions = PHFetchOptions()
  let cachingImageManager = PHCachingImageManager()
  var assets: [PHAsset] = [] {
    willSet {
      cachingImageManager.stopCachingImagesForAllAssets()
    }
    
    didSet {
      cachingImageManager.startCachingImagesForAssets(assets,
                                                      targetSize: PHImageManagerMaximumSize,
                                                      contentMode: .AspectFit,
                                                      options: self.requestOptions
      )
    }
  }
  
  func fetchPhotos() {
    requestOptions.resizeMode = PHImageRequestOptionsResizeMode.Exact
    requestOptions.version = .Current
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
    requestOptions.synchronous = true
    
    fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
    if #available(iOS 9.0, *) {
      fetchOptions.fetchLimit = 50
    } else {
      
      // Fallback on earlier versions
    }
    
    let allAssets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [weak self] in
      allAssets.enumerateObjectsUsingBlock{ object, index, stop in
        let asset = object as! PHAsset
        self?.assets.append(asset)
      }
      dispatch_async(dispatch_get_main_queue()) {
        self?.galleryCollectionView.reloadData()
        //self?.showImageDetailIndex(0)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fetchPhotos()
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = self.galleryCollectionView.dequeueReusableCellWithReuseIdentifier("item", forIndexPath: indexPath)
    let imageView = cell.contentView.viewWithTag(111) as! UIImageView
    imageView.contentMode = .ScaleAspectFill
    let asset = self.assets[indexPath.row]
    let frameW = UIScreen.mainScreen().bounds.size.width
    PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(frameW*120/320, frameW*120/320), contentMode: PHImageContentMode.Default, options: nil, resultHandler:{(image,infor) in
      imageView.image = image
    })
    return cell
  }
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return assets.count
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1;
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let frameW = UIScreen.mainScreen().bounds.size.width
    let size = frameW*120/320
    return CGSize(width: size, height: size)
  }
  
  func collectionView(collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0.0
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.showImageDetailIndex(indexPath.row)
  }
  
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    
    let cell:UICollectionViewCell = self.galleryCollectionView.visibleCells().last!
    let indexPath:NSIndexPath = self.galleryCollectionView.indexPathForCell(cell)!
    self.showImageDetailIndex(indexPath.row)
    
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if(!decelerate){
      let cell:UICollectionViewCell = self.galleryCollectionView.visibleCells().last!
      let indexPath:NSIndexPath = self.galleryCollectionView.indexPathForCell(cell)!
      self.showImageDetailIndex(indexPath.row)
    }
  }
  
  func showImageDetailIndex(index:Int){
    
    let asset = self.assets[index]
    PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.Default, options: nil, resultHandler:{(image,infor) in
      self.imageDetailView.image = image
    })
  }
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let photoAmazingVC:ImageProcessingViewController = segue.destinationViewController as! ImageProcessingViewController
    photoAmazingVC.setPhoto(self.imageDetailView.image!)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
}

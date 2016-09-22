//
//  PhotoAmazingViewController.swift
//  PhotoAmazing
//
//  Created by TRAMS on 9/20/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit


class PhotoAmazingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
  
  @IBOutlet weak var sliderCollectionView: UICollectionView!
  @IBOutlet weak var photoImgView: UIImageView!
  
  
  
  private var photo:UIImage?
  
  func setPhoto(photo:UIImage){
    self.photo = photo
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.photoImgView.image = self.photo
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = self.sliderCollectionView.dequeueReusableCellWithReuseIdentifier("item", forIndexPath: indexPath)
    let button = cell.contentView.viewWithTag(111) as! UIButton
    
    if(DeviceType.IS_IPHONE_6){
      button.contentEdgeInsets = UIEdgeInsets(top: 18, left: 22, bottom: 38, right: 22)
    }else if(DeviceType.IS_IPHONE_6P){
      button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 19, bottom: 35, right: 19)
    }
    return cell
  }
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return 10
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let frameW = UIScreen.mainScreen().bounds.size.width
    return CGSize(width: frameW*60/320, height: frameW*80/320)
  }
  

  func collectionView(collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 1.0
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  @IBAction func backAction(sender: AnyObject) {
    self .dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func acceptAction(sender: AnyObject) {
    
  }

  
}

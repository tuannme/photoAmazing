//
//  ImageProcessingViewController.swift
//  PhotoAmazing
//
//  Created by TRAMS on 9/22/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit
import GPUImage

class ImageProcessingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{

  @IBOutlet weak var sliderCollectionView: UICollectionView!
  @IBOutlet weak var photoImgView: UIImageView!
  
  @IBOutlet weak var magicBtn: UIButton!
  @IBOutlet weak var cropBtn: UIButton!
  @IBOutlet weak var smileBtn: UIButton!
  @IBOutlet weak var retateBtn: UIButton!
  
  let slider:UISlider = UISlider(frame: CGRectMake(30,200,200,5))
  let scene:[String] = ["없음","그겨울","따스한","빛나는","달빛","샴페인"]
  //let filter:GPUImageHighlightShadowFilter = GPUImageHighlightShadowFilter()
    let filter:GPUImageBrightnessFilter = GPUImageBrightnessFilter()
  var source:GPUImagePicture? = nil
    
  private var photo:UIImage?
  
  func setPhoto(photo:UIImage){
    self.photo = photo
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    source = GPUImagePicture(image: photo)

    filter.brightness = 0.5
    source?.addTarget(filter)
    
    filter.useNextFrameForImageCapture()
    source?.processImage()
    self.photoImgView.image = filter.imageFromCurrentFramebuffer()

    
    if(DeviceType.IS_IPHONE_6){
      magicBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
      cropBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
      retateBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
      smileBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
    }
    
    slider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
    slider.addTarget(self, action: #selector(self.changeValue(_:)), forControlEvents:.ValueChanged)
    slider.minimumValue = -1.0
    slider.maximumValue = 1.0
    slider.userInteractionEnabled = true
    slider.value = 0

  
    
    self.view.addSubview(slider)
    
  }
  
    func changeValue(slider:UISlider){
        
        let value:CGFloat  = CGFloat(slider.value)
        self.filter.brightness = value
        
        print("value \(value)")
        
        filter.useNextFrameForImageCapture()
        source?.processImage()
        self.photoImgView.image = filter.imageFromCurrentFramebuffer()
        
    }
    

  func fileterImage(index: Int){
    
    switch index {
    case 0:
      let filter:GPUImageBrightnessFilter = GPUImageBrightnessFilter()
      filter.brightness = 0.5
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 1:
      let filter:GPUImageRGBFilter = GPUImageRGBFilter()
      filter.red = 208/254.0
      filter.blue = 231/254.0
      filter.green = 249/254.0
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 2:
      let filter:GPUImageHighlightShadowFilter = GPUImageHighlightShadowFilter()
      filter.highlights = 0.5
      filter.shadows = 0.5
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 3:
      let filter:GPUImageMonochromeFilter = GPUImageMonochromeFilter()
      filter.setColorRed(199/254.0, green: 133/254.0, blue: 29/254.0)
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 4:
      let filter:GPUImageOpacityFilter = GPUImageOpacityFilter()
      filter.opacity = 0.5
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 5:
      let filter:GPUImageLuminanceThresholdFilter = GPUImageLuminanceThresholdFilter()
      filter.threshold = 0.1
      filter.useNextFrameForImageCapture()
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    default:
      break
    }
  }
  
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = self.sliderCollectionView.dequeueReusableCellWithReuseIdentifier("item", forIndexPath: indexPath)
    return cell
  }
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return 7
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let frameW = UIScreen.mainScreen().bounds.size.width
    return CGSize(width: frameW*60/320, height: frameW*84/320)
  }
  
  
  func collectionView(collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 1.0
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.fileterImage(indexPath.row)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  
  @IBAction func backAction(sender: AnyObject) {
    self .dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func acceptAction(sender: AnyObject) {
    
  }
  
  
  @IBAction func macgicAction(sender: AnyObject) {
    
  }
  
  @IBAction func cropAction(sender: AnyObject) {
  }
  

  @IBAction func roatateAction(sender: AnyObject) {
  }
  
  @IBAction func smileAction(sender: AnyObject) {
  }
  
}
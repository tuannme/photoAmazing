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
  
  
  @IBOutlet weak var sliderBright: UISlider!
  @IBOutlet weak var sliderRed: UISlider!
  @IBOutlet weak var sliderGreen: UISlider!
  @IBOutlet weak var sliderBlue: UISlider!
  @IBOutlet weak var sliderLight: UISlider!
  @IBOutlet weak var sliderShadow: UISlider!
  
  @IBOutlet weak var sliderBlueChrome: UISlider!
  @IBOutlet weak var sliderGreenChrome: UISlider!
  @IBOutlet weak var sliderRedChrome: UISlider!
  
  let scene:[String] = ["없음","그겨울","따스한","빛나는","달빛","샴페인"]
  
  let filterBright:GPUImageBrightnessFilter = GPUImageBrightnessFilter()
  let filterRGB:GPUImageRGBFilter = GPUImageRGBFilter()
  let filterLight:GPUImageHighlightShadowFilter = GPUImageHighlightShadowFilter()
  let filterChrome:GPUImageMonochromeFilter = GPUImageMonochromeFilter()
  
  var source:GPUImagePicture? = nil
  
  private var photo:UIImage?
  var indexSelect:Int = 0
  
  func setPhoto(photo:UIImage){
    self.photo = photo
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    source = GPUImagePicture(image: photo)
    
    source?.addTarget(filterRGB)
    filterRGB.addTarget(filterLight)
    filterLight.addTarget(filterBright)
    //filterChrome.addTarget(filterBright)
    
    if(DeviceType.IS_IPHONE_6){
      magicBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
      cropBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
      retateBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
      smileBtn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
    }
    
    sliderBright.minimumValue = 0.0
    sliderBright.maximumValue = 1.0
    sliderBright.userInteractionEnabled = true
    sliderBright.value = 0
    
    sliderRed.minimumValue = 0.0
    sliderRed.maximumValue = 254.0
    sliderRed.userInteractionEnabled = true
    sliderRed.value = 0
    sliderRed.tintColor = UIColor.redColor()
    
    sliderGreen.minimumValue = 0.0
    sliderGreen.maximumValue = 254.0
    sliderGreen.userInteractionEnabled = true
    sliderGreen.value = 0
    sliderGreen.tintColor = UIColor.greenColor()
    
    sliderBlue.minimumValue = 0.0
    sliderBlue.maximumValue = 254.0
    sliderBlue.userInteractionEnabled = true
    sliderBlue.value = 0
    sliderBlue.tintColor = UIColor.blueColor()

    sliderLight.minimumValue = 0.0
    sliderLight.maximumValue = 1.0
    sliderLight.userInteractionEnabled = true
    sliderLight.value = 0
    sliderLight.tintColor = UIColor.yellowColor()
    
  
    sliderShadow.minimumValue = 0.0
    sliderShadow.maximumValue = 1.0
    sliderShadow.userInteractionEnabled = true
    sliderShadow.value = 0
    sliderShadow.tintColor = UIColor.yellowColor()
    
  }
  
  
  @IBAction func changeValueBright(sender: AnyObject) {
    let slider:UISlider = sender as! UISlider
    let value:CGFloat  = CGFloat(slider.value)
    self.filterBright.brightness = value
    filterBright.useNextFrameForImageCapture()
    source?.processImage()
    self.photoImgView.image = filterBright.imageFromCurrentFramebuffer()
    
    print("value \(value)")
  }
  
  @IBAction func changeValueRed(sender: AnyObject) {
    
    let slider:UISlider = sender as! UISlider
    let value:CGFloat  = CGFloat(slider.value)
    filterRGB.red = value/254.0
    filterBright.useNextFrameForImageCapture()
    source?.processImage()
    self.photoImgView.image = filterBright.imageFromCurrentFramebuffer()
    
    print("value \(value)")
  }
  
  @IBAction func changeValueGreen(sender: AnyObject) {
    let slider:UISlider = sender as! UISlider
    let value:CGFloat  = CGFloat(slider.value)
    filterRGB.green = value/254.0
    filterBright.useNextFrameForImageCapture()
    source?.processImage()
    self.photoImgView.image = filterBright.imageFromCurrentFramebuffer()
    
    print("value \(value)")
  }
  
  @IBAction func changeValueBlue(sender: AnyObject) {
    let slider:UISlider = sender as! UISlider
    let value:CGFloat  = CGFloat(slider.value)
    filterRGB.blue = value/254.0
    filterBright.useNextFrameForImageCapture()
    source?.processImage()
    self.photoImgView.image = filterBright.imageFromCurrentFramebuffer()
    
    print("value \(value)")
  }

  
  @IBAction func changeValueLight(sender: AnyObject) {
    
    let slider:UISlider = sender as! UISlider
    let value:CGFloat  = CGFloat(slider.value)
    filterLight.highlights = value
    filterBright.useNextFrameForImageCapture()
    source?.processImage()
    self.photoImgView.image = filterBright.imageFromCurrentFramebuffer()
    
    print("value \(value)")
    
  }
  

  @IBAction func changeValueShadow(sender: AnyObject) {
    let slider:UISlider = sender as! UISlider
    let value:CGFloat  = CGFloat(slider.value)
    filterLight.shadows = value
    filterBright.useNextFrameForImageCapture()
    source?.processImage()
    self.photoImgView.image = filterBright.imageFromCurrentFramebuffer()
    
    print("value \(value)")
  }
  
  
  @IBAction func changeValueBlueChrome(sender: AnyObject) {
    
  }
  

  @IBAction func changeValueGreenChrome(sender: AnyObject) {
  }
  
  @IBAction func changeValueRedChrome(sender: AnyObject) {
  }
  
  
  func fileterImage(index: Int){
    
    switch index {
    case 0:
      self.photoImgView.image = photo
      break
    case 1:
      let filter:GPUImageBrightnessFilter = GPUImageBrightnessFilter()
      filter.brightness = 0.5
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 2:
      let filter:GPUImageRGBFilter = GPUImageRGBFilter()
      filter.red = 208/254.0
      filter.blue = 231/254.0
      filter.green = 249/254.0
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 3:
      let filter:GPUImageHighlightShadowFilter = GPUImageHighlightShadowFilter()
      filter.highlights = 0.5
      filter.shadows = 0.5
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 4:
      let filter:GPUImageMonochromeFilter = GPUImageMonochromeFilter()
      filter.setColorRed(199/254.0, green: 133/254.0, blue: 29/254.0)
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 5:
      let filter:GPUImageOpacityFilter = GPUImageOpacityFilter()
      filter.opacity = 0.5
      let newPhoto = filter.imageByFilteringImage(photo);
      self.photoImgView.image = newPhoto
      break
    case 6:
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
    indexSelect = indexPath.row
    self.fileterImage(indexSelect)
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
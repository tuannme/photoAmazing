//
//  PhotoAmazingViewController.swift
//  PhotoAmazing
//
//  Created by TRAMS on 9/20/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit

class PhotoAmazingViewController: UIViewController {
  
  
  var fishImgView:UIImageView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fishImgView = UIImageView(image: UIImage(named :"fish.png"))
    self.fishImgView!.frame = CGRectMake(self.view.center.x, self.view.center.y + 100, 200, 200)
    self.view.addSubview(fishImgView!)
    self.goFishGo()
    NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.creatBubble), userInfo: nil, repeats: true)
  }
  
  func goFishGo(){

    UIView.animateWithDuration(5, animations: {
      self.fishImgView!.frame = CGRectMake(self.view.frame.size.width + 200, self.view.center.y + 100, 200, 200);
    },completion: { (finish) in
      self.fishImgView!.frame = CGRectMake(self.view.frame.origin.x - 200, self.view.center.y + 100, 200, 200);
      self.goFishGo()
    })
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
   // self.creatBubble()
    self.fishImgView!.frame = CGRectMake(self.fishImgView!.frame.origin.x + 10, self.view.center.y + 100, 200, 200);
  }
  
  
  func creatBubble(){
    
//    print("BUBBLE")
//    
//    let bubble:UIImageView = UIImageView(image: UIImage(named:"bubble.png"))
//    //
//    bubble.frame = CGRectMake(fishImgView!.frame.origin.x + 5,fishImgView!.frame.origin.y + 80, 10, 10)
//    bubble.alpha = self.randomFloatBetween(1.0, bigNumber: 1.0)
//    self.view.addSubview(bubble)
//    
//    let zigzagPath:UIBezierPath = UIBezierPath()
//    let oX:CGFloat = bubble.frame.origin.x
//    let oY:CGFloat = bubble.frame.origin.y
//    let eX:CGFloat = oX
//    let eY = oY - 350

//    let t:CGFloat = 40
//    
//    let cp1:CGPoint = CGPointMake(oX - t, ((oY + eY) / 2))
//    let cp2:CGPoint = CGPointMake(oX + t, cp1.y)
//    

//    
//    zigzagPath.moveToPoint(CGPointMake(oX, oY))
//    zigzagPath.addCurveToPoint(CGPointMake(eX, eY), controlPoint1: cp1, controlPoint2: cp2)
//    
//    CATransaction.begin()
//    CATransaction.setCompletionBlock({
//      
//      UIView.transitionWithView(bubble, duration: 3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
//        bubble.transform =  CGAffineTransformMakeScale(1.3, 1.3)
//        }, completion: {(finished) in
//          bubble.removeFromSuperview()
//      })
//    })
//    
//    let pathAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
//    pathAnimation.duration = 3
//    pathAnimation.path = zigzagPath.CGPath;
//    pathAnimation.fillMode = kCAFillModeForwards;
//    pathAnimation.removedOnCompletion = false;
//    bubble.layer.addAnimation(pathAnimation, forKey: "movingAnimation")
//    
//    CATransaction.commit()
    
    
    let bubbleImageView = UIImageView.init(image: UIImage.init(named: "bubble.png"))
    let size = self.randomFloatBetween(5, bigNumber: 30)
    bubbleImageView.frame = CGRectMake (self.fishImgView!.layer.presentationLayer()!.frame.origin.x + 5,(self.fishImgView!.layer.presentationLayer()?.frame.origin.y)!+80,size,size)
    
    //bubbleImageView.alpha = [self randomFloatBetween:.1 and:1];
    self.view.addSubview(bubbleImageView)
    
    let zigzagPath = UIBezierPath()

    let oX = bubbleImageView.frame.origin.x
    let oY = bubbleImageView.frame.origin.y
    let eX = oX
    let eY = self.randomFloatBetween(50, bigNumber: 300)
    let t = self.randomFloatBetween(20, bigNumber: 100)
    
    var cp1 = CGPointMake(oX - t, ((oY + eY) / 2));
    var cp2 = CGPointMake(oX + t, cp1.y);

        let r = arc4random() % 2
        if(r == 1){
          let temp = cp1
          cp1 = cp2
          cp2 = temp
        }
  
    zigzagPath.moveToPoint(CGPointMake(oX, oY))
    zigzagPath.addCurveToPoint(CGPointMake(eX, eY), controlPoint1: cp1, controlPoint2: cp2)

    CATransaction.begin()
    CATransaction.setCompletionBlock({
      
      UIView.transitionWithView(bubbleImageView, duration: 0.1, options:.TransitionCrossDissolve, animations: {
        bubbleImageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }, completion: { (finish) in
          bubbleImageView.removeFromSuperview()
      })
 
    })
    
    
    let pathAnimation = CAKeyframeAnimation(keyPath:"position")
    pathAnimation.duration = 2;
    pathAnimation.path = zigzagPath.CGPath;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = false;
    
    bubbleImageView.layer.addAnimation(pathAnimation, forKey: "movingAnimation")
    
    CATransaction.commit()
    
  }
  
  
  func randomFloatBetween(smallNumber:CGFloat,bigNumber:CGFloat)-> CGFloat{
    let diff = bigNumber - smallNumber;
    let temp = (arc4random() % (UInt32(RAND_MAX) + 1)) / UInt32(RAND_MAX)
    return CGFloat(temp) * diff + smallNumber
  }
  

  
}

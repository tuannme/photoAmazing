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
    var timer = NSTimer()
    var count = 0
    var bubbleImage1:UIImageView?
    var bubbleImage2:UIImageView?
    var bubbleImage3:UIImageView?

    var lastLocation:CGPoint = CGPointMake(-1,-1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fishImgView = UIImageView(image: UIImage(named :"fish.png"))
        self.fishImgView!.frame = CGRectMake(0, self.view.center.y + 100, 200, 200)
        self.view.addSubview(fishImgView!)
        self.goFishGo()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.creatBubble), userInfo: nil, repeats: true)

        
        bubbleImage1 = UIImageView.init(image: UIImage.init(named: "bubble.png"))
        bubbleImage1?.tag = 1;
        bubbleImage1?.userInteractionEnabled = true
        
        bubbleImage2 = UIImageView.init(image: UIImage.init(named: "bubble.png"))
        bubbleImage2?.tag = 2;
        bubbleImage2?.userInteractionEnabled = true
        
        bubbleImage3 = UIImageView.init(image: UIImage.init(named: "bubble.png"))
        bubbleImage3?.tag = 3;
        bubbleImage3?.userInteractionEnabled = true
        
        let gesture1 = UIPanGestureRecognizer.init(target: self, action: #selector(self.bubbleTapAction(_:)))
        bubbleImage1?.addGestureRecognizer(gesture1)
        
        let gesture2 = UIPanGestureRecognizer.init(target: self, action: #selector(self.bubbleTapAction(_:)))
        bubbleImage2?.addGestureRecognizer(gesture2)
        
        let gesture3 = UIPanGestureRecognizer.init(target: self, action: #selector(self.bubbleTapAction(_:)))
        bubbleImage3?.addGestureRecognizer(gesture3)
        
    }
    
    
    func bubbleTapAction(gesture:UIPanGestureRecognizer){
        
        if(gesture.state == UIGestureRecognizerState.Began){
            lastLocation = gesture.locationInView(self.view)
        }
        
        if(gesture.state == UIGestureRecognizerState.Changed){
            
            let translation  = gesture.translationInView(self.view!)
            let bubble = gesture.view
            let n = bubble?.tag
            
            switch n {
            case let n where n == 1:
                bubbleImage1?.center = CGPointMake(lastLocation.x + translation.x,lastLocation.y + translation.y)
            case let n where n == 2:
               bubbleImage2?.center = CGPointMake(lastLocation.x + translation.x,lastLocation.y + translation.y)
            case let n where n == 3:
               bubbleImage3?.center = CGPointMake(lastLocation.x + translation.x,lastLocation.y + translation.y)
            default:
                print("")
            }
        }
    }
    
    func goFishGo(){
        
        UIView.animateWithDuration(6, animations: {
            self.fishImgView!.frame = CGRectMake(self.view.frame.size.width + 200, self.view.center.y + 100, 200, 200);
            },completion: { (finish) in
                self.timer.invalidate()
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
    
    
    func creatBubble(){
        
        let bubbleImageView = UIImageView.init(image: UIImage.init(named: "bubble.png"))
        
        var title:String = ""
        count = count + 1
        
        if(count == 1){
            title = "library"
        }else if(count == 10){
            title = "my photo"
        }else if(count == 20){
            title = "cloud"
        }
        var size = self.randomFrom(5, step: 5)
        if(!title.isEmpty){
            size = 100;
        }
        
        let label = UILabel.init(frame: CGRectMake(0, 0, 90, 90))
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.orangeColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = title
        bubbleImageView.addSubview(label)
        
        bubbleImageView.frame = CGRectMake (self.fishImgView!.layer.presentationLayer()!.frame.origin.x + 5,(self.fishImgView!.layer.presentationLayer()?.frame.origin.y)!+80,size,size)
        
        bubbleImageView.alpha = self.randomFrom(0.5, step: 0.05);
        self.view.addSubview(bubbleImageView)
        
        let zigzagPath = UIBezierPath()
        
        let oX = bubbleImageView.frame.origin.x
        let oY = bubbleImageView.frame.origin.y
        var eX = oX
        var eY = self.randomFrom(50, step: 30)
        let t = self.randomFrom(20, step: 10)
        
        var cp1 = CGPointMake(oX - t, ((oY + eY) / 2));
        var cp2 = CGPointMake(oX + t, cp1.y);
        
        let r = arc4random() % 2
        if(r == 1){
            let temp = cp1
            cp1 = cp2
            cp2 = temp
        }
        
        if(count == 1){
            eY  = 180
            eX = 90
            cp1 = CGPointMake(400,10)
            cp2 = CGPointMake(50,10)
            bubbleImageView.tag = 1
        }else if(count == 10){
            eY  = 230
            eX = 280
            cp1 = CGPointMake(100,300)
            cp2 = CGPointMake(200,100)
            bubbleImageView.tag = 2
        }else if(count == 20){
            eY  = 370
            eX = 180
            cp1 = CGPointMake(170,300)
            cp2 = CGPointMake(10,200)
            bubbleImageView.tag = 3
        }
        
        zigzagPath.moveToPoint(CGPointMake(oX, oY))
        zigzagPath.addCurveToPoint(CGPointMake(eX, eY), controlPoint1: cp1, controlPoint2: cp2)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            
            UIView.transitionWithView(bubbleImageView, duration:0.1, options:.TransitionCrossDissolve, animations: {
                bubbleImageView.transform = CGAffineTransformMakeScale(1.4, 1.4);
                }, completion: { (finish) in
                    
                    if(!title.isEmpty){
                       
                        let mLabel = UILabel.init(frame: CGRectMake(0, 0, 140, 140))
                        mLabel.font = UIFont.systemFontOfSize(18)
                        mLabel.textColor = UIColor.orangeColor()
                        mLabel.textAlignment = NSTextAlignment.Center
                        mLabel.text = title

                        if(bubbleImageView.tag == 1){
                            self.bubbleImage1?.frame = CGRectMake(eX - 70, eY - 70, 140, 140)
                            self.bubbleImage1?.addSubview(mLabel)
                            self.view.addSubview(self.bubbleImage1!)
                        }else if(bubbleImageView.tag == 2){
                            self.bubbleImage2?.frame = CGRectMake(eX - 70, eY - 70, 140, 140)
                            self.view.addSubview(self.bubbleImage2!)
                            self.bubbleImage2?.addSubview(mLabel)
                        }else if(bubbleImageView.tag == 3){
                            self.bubbleImage3?.frame = CGRectMake(eX - 70, eY - 70, 140, 140)
                            self.view.addSubview(self.bubbleImage3!)
                            self.bubbleImage3?.addSubview(mLabel)
                        }
                    }
                    
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
    
    
    
    func randomFrom(number:CGFloat,step:CGFloat)-> CGFloat{
        
        let values:NSMutableArray = NSMutableArray()
        
        var newNumber = number;
        
        for _ in 0...9{
            values.addObject(newNumber)
            newNumber = newNumber + step
        }
        let random = Int(arc4random_uniform(UInt32(10)))
        return values[random] as! CGFloat
    }
    
    
    
}

//
//  MainViewController.swift
//  PhotoAmazing
//
//  Created by Nguyen Manh Tuan on 9/18/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        if session!.canAddOutput(stillImageOutput) {
            session!.addOutput(stillImageOutput)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
            self.view.layer.addSublayer(videoPreviewLayer!)
            session!.startRunning()
        }
        
        
        let button = UIButton(type: UIButtonType.System)
        button.setTitle("Snap", forState: UIControlState.Normal)
        button.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 40, UIScreen.mainScreen().bounds.size.height - 100, 80, 80)
        button.backgroundColor = UIColor.whiteColor()
        button.layer.cornerRadius = 40;
        button.clipsToBounds = true
        button.alpha = 0.5
        button.addTarget(self, action: #selector(self.snapPhoto), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
    }
    
    func snapPhoto() {
        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    let imageView = UIImageView(image: image)
                    imageView.frame = self.view.frame;
                    self.view.addSubview(imageView)
                    
                }
            })
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = self.view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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

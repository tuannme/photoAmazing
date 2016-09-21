//
//  LoginViewController.swift
//  PhotoAmazing
//
//  Created by Nguyen Manh Tuan on 9/19/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var signinViewSpaceBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var usernameTf: UITextField!
  @IBOutlet weak var passwordTf: UITextField!
  @IBOutlet weak var signupLb: UILabel!
  
  @IBOutlet weak var facebookBt: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboadWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    
    usernameTf.attributedPlaceholder = NSAttributedString(string:"Username",attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
    passwordTf.attributedPlaceholder = NSAttributedString(string:"Password",attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
    
    let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(self.signupAction))
    signupLb.userInteractionEnabled = true
    signupLb.addGestureRecognizer(tapGesture)
    
  }
  
  func signupAction() {
    
  }
  
  @IBAction func facebookAction(sender: AnyObject) {
    
    let facebookReadPermissions = ["public_profile", "email", "user_friends"]
    let facebookManager:FBSDKLoginManager = FBSDKLoginManager()
    facebookManager.logInWithReadPermissions(facebookReadPermissions, fromViewController: self, handler: { (result, error) -> Void in
      if (error == nil){
        
        let fbloginresult : FBSDKLoginManagerLoginResult = result
        
        if(fbloginresult.isCancelled) {
          //Show Cancel alert
        } else if(fbloginresult.grantedPermissions.contains("email")) {
          self.returnUserData()
          //fbLoginManager.logOut()
        }
      }
      
    })
    
  }
  func returnUserData(){
    if((FBSDKAccessToken.currentAccessToken()) != nil){
      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
        if (error == nil){
          print(result)
          result.valueForKey("email") as! String
          result.valueForKey("id") as! String
          result.valueForKey("name") as! String
          result.valueForKey("first_name") as! String
          result.valueForKey("last_name") as! String
          
          self.performSegueWithIdentifier("facebookSegue", sender: self)
        }
      })
    }
  }
  
  
  func keyboadWillShow(notification:NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
      signinViewSpaceBottomConstraint.constant = keyboardSize.height
    }
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
    UIView.animateWithDuration(1.0, animations: {
      self.signinViewSpaceBottomConstraint.constant = 0
    })
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    
    if(identifier == "signinSegue"){
      return true;
    }
    
    return false;
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
  }
  
  
}

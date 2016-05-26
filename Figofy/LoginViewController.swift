//
//  LoginViewController.swift
//  Figofy
//
//  Created by Tommy on 31/12/2015.
//  Copyright © 2015 Tommy. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var usernameTextField: TextFieldDesign!
    @IBOutlet weak var passwordTextField: TextFieldDesign!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var figofyLogo: UIImageView!
    @IBOutlet weak var fortrydBtn: UIButton!
    @IBOutlet weak var opretBtn: UIButton!
    @IBOutlet weak var createFirstName: TextFieldDesign!
    @IBOutlet weak var createPassword: TextFieldDesign!
    @IBOutlet weak var createEmail: TextFieldDesign!
    @IBOutlet weak var createPhone: TextFieldDesign!
    @IBOutlet weak var opretSV: UIStackView!
    @IBOutlet weak var buttomBarButton: UIButton!
    
    
    
    // MARK: Variables
    let layer = CAGradientLayer()
    let fbPermissions = ["email","user_location","user_birthday"]
    var fbParameters = Dictionary<NSObject, AnyObject>()
    // MARK: View Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        loginbtn.layer.cornerRadius = 50
        opretBtn.layer.cornerRadius = opretBtn.frame.width/2
        fortrydBtn.layer.cornerRadius = fortrydBtn.frame.width/2
        fbParameters.updateValue("email,first_name,middle_name,last_name,gender,location", forKey: "fields")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //grab the key and if it is there, login automatically
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    
    //MARK: IBAction
    //FACEBOOK
    @IBAction func fbLogin(sender: UIButton)
    {
        let facebookLogin = FBSDKLoginManager()
        //let graphConnection = FBSDKGraphRequestConnection()
        facebookLogin.logInWithReadPermissions(self.fbPermissions, fromViewController: self, handler: { facebookResult, facebookError -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
                facebookLogin.logOut()
            } else if facebookResult.isCancelled {
                
                facebookLogin.logOut()
                
            }else {
                //get the access token for Firebase
                let accessToken = FBSDKAccessToken.currentAccessToken()
                
                
                
                
                if accessToken.declinedPermissions.count == 0 {
                    print("No Permissions were declined")
                    // TODO: Some
                } else {
                    let declinedPerms = accessToken.declinedPermissions
                    for perm in declinedPerms {
                        print("__________________________ \(perm.description)")
                    }
                }
                
                print("Successfully logged in with facebook. \(accessToken)")
                
                DataService.dataService.REF_BASE.authWithOAuthProvider("facebook", token: accessToken.tokenString, withCompletionBlock: { error, authData in
                    
                    //store the information in Firebase
                    if error != nil {
                        print("Login Failed. \(error)")
                    } else {
                        print("Getting Data from facebook...")
                        
                        
                        //save it to the device
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        
                        //save to firebase
                        FBSDKGraphRequest(graphPath: "me", parameters: self.fbParameters).startWithCompletionHandler({ connection, result, error in
                            print("RESULT:________\(result)__________")
                            
                            if error != nil {
                                print("couldnt get information about user: \(error)")
                            } else {
                                print("\(result)")
                                
                                if let userInfo = result as? [String:AnyObject] {
                                    
                                    let currentUser = FigofyUser(postKey: authData.uid, dictionary: userInfo)
                                    
                                    DataService.dataService.createFirebaseUser(authData.uid, user: userInfo)
                                    print("......\(currentUser.facebookId)")
                                    //Navigate through
                                    
                                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: currentUser)
                                }
                            }
                            
                            
                            
                        })
                        
                    }
                    
                    
                })//End of authWithOAuthProvider
                
            }
        })//End of FBSDKLoginManger
        
        
    }
    
    @IBAction func registerBtnPressed(sender: AnyObject) {
        usernameTextField.hidden = true
        passwordTextField.hidden = true
        loginbtn.hidden = true
        figofyLogo.hidden = true
        
        buttomBarButton.setTitle("FIGOFY fisketuren begynder her!", forState: UIControlState.Normal)
        opretSV.hidden = false
        
        
    }
    
    @IBAction func createBtnPressed (sender: UIButton) {
        
        if let email = createEmail.text where email != "", let pwd = createPassword.text where pwd != "" {
            
            DataService.dataService.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                
                if error != nil {
                    
                    print(error)
                    
                    if error.code == STATUS_ACCOUNT_NONEXIST {
                        DataService.dataService.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            
                            if error != nil {
                                AlertView().showOkayAlert("Could not create account", message:  "Problem Creating Account. Try something else", style: .Alert, VC: self)
                            } else {
                                //Save user and log in
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                DataService.dataService.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                                    // MARK: TODO The data from the form in to dictionary
                                    let user: [String : AnyObject] = ["provider" : authData.provider!, "email" : self.createEmail.text!, "mobile" : self.createPhone.text!, "firstName" : self.createFirstName.text!]
                                    
                                    DataService.dataService.createFirebaseUser(authData.uid, user: user)
                                    
                                    
                                })
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                            
                        })
                    } else {
                        AlertView().showOkayAlert("Could not login", message:  "Please check your username or password", style: .Alert, VC: self)
                    }
                    
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
                
            })
            
        } else {
            AlertView().showOkayAlert("Email and Password Required", message: "you must enter an email and a password", style: .Alert, VC: self)
        }
        
    }
    
    
    @IBAction func cancelBtnPressed (sender: AnyObject) {
        usernameTextField.hidden = false
        passwordTextField.hidden = false
        loginbtn.hidden = false
        figofyLogo.hidden = false
        
        opretSV.hidden = true
        buttomBarButton.setTitle("Ikke en del af figofy? Opret dig her (Ikke i beta)", forState: UIControlState.Normal)
        createFirstName.text = ""
        createEmail.text = ""
        createPhone.text = ""
        createPassword.text = ""
    }
    
    
    
    // MARK: Delegate Methods
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 1 {
            passwordTextField.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.Go {
            
        }
        
        return true
    }
    
    // MARK: Segue method
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tabBarController = segue.destinationViewController as! UITabBarController
        if segue.identifier == SEGUE_LOGGED_IN {
            if let profileView = tabBarController.viewControllers![0] as? ProfileViewController {
                if let user = sender as? FigofyUser {
                    profileView.user = user
                                        
                }
            }
        }
    }
}


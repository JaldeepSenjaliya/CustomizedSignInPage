//
//  LoginViewController.swift
//  CustomLoginPage
//
//  Created by Jaldeep Patel on 2021-05-04.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var gmailLoginButton: UIButton!
    @IBOutlet var facebookLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
        getNavigationBarGradient()
        
    }
    
    func setUpElement() {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //Set images for textFields
        let email = UIImage(named: "Email")
        let password = UIImage(named: "Password")
        
        //Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleButton(loginButton)
        Utilities.styleButton(facebookLoginButton)
        Utilities.styleButton(gmailLoginButton)
        Utilities.addTextFieldImage(textField: emailTextField, andImage: email!)
        Utilities.addTextFieldImage(textField: passwordTextField, andImage: password!)
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns
    // nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Validate any field is not blank
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Email or password are blank."
        }
        
        //Validate Email format is correct
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(cleanedEmail) == false {
            
            return "Please enter correct email."
        }
        
        //Validate password is correct
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please enter correct password."
        }
        
        return nil
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error != nil {
            
            //There's something wrong
            errorLabel.text = error!
            errorLabel.alpha = 1
            
        } else {
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Sign in the User
            Auth.auth().signIn(withEmail: email, password: password) { result, err in
                
                //There is something wrong
                if err != nil {
                    self.errorLabel.text = err!.localizedDescription
                    self.errorLabel.alpha = 1
                } else {
                    
                    //Everything is fine, redirect to TabBarViewController
                    let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarViewController) as! UITabBarController
                    self.view.window?.rootViewController = tabBarViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: Constants.Storyboard.signUpSegue, sender: nil)
        
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: Constants.Storyboard.forgotPasswordSegue, sender: nil)
    }
    
    
    @IBAction func facebookLoginTapped(_ sender: UIButton) {
    }
    
    
    
    @IBAction func gmailLoginTapped(_ sender: UIButton) {
        
    }
    

    func getNavigationBarGradient() {
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            let gradient = CAGradientLayer()
            
            var bounds = navigationBar.bounds
            
            bounds.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            
            gradient.frame = bounds
            
            gradient.colors = [UIColor.init(red: 78/255, green: 114/255, blue: 186/255, alpha: 1).cgColor, UIColor.init(red: 62/255, green:178/255, blue: 174/255, alpha: 1).cgColor]
            
            gradient.startPoint = CGPoint(x: 0, y: 0)
            
            gradient.endPoint = CGPoint(x: 1, y: 0)
            
            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
                navigationBar.tintColor = UIColor.white
            }
        }
    }
    
    
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
        
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    //Dismiss keyboard when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}





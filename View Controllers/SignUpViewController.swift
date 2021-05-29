//
//  SignUpViewController.swift
//  CustomLoginPage
//
//  Created by Jaldeep Patel on 2021-05-04.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNavigationBarGradient()
        setUpElement()
        
    }
    
    func setUpElement() {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //Set images for textFields
        let userName = UIImage(named: "Profile")
        let email = UIImage(named: "Email")
        let password = UIImage(named: "Password")
        
        //Style the elements
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleButton(signUpButton)
        Utilities.addTextFieldImage(textField: nameTextField, andImage: userName!)
        Utilities.addTextFieldImage(textField: emailTextField, andImage: email!)
        Utilities.addTextFieldImage(textField: passwordTextField, andImage: password!)
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns
    // nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        //Check that all the fields are filled
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill all the fields."
        }
        
        //Check email format is valid
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Please make sure you have entered valid email format."
        }
        
        //Check password is secured
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 charactors, contains a special charactor and a number."
        }
        return nil
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            
            //There's something wrong
            showError(error!)
            
        } else {
            
            let userName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if err != nil {
                    //There was an error creating the user
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("dap_users").addDocument(data: ["username": userName, "uid": result!.user.uid]) { error in
                        if error != nil {
                            self.showError("Error Saving user data.")
                        }
                    }
                    //Trasition to the Home screen
                    self.transitionToLoginScreen()
                }
            }
        }
    }
    
    
    @IBAction func signInTapped(_ sender: UIButton) {
        transitionToLoginScreen()
    }
    
    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToLoginScreen() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! LoginViewController
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    //Dismiss keyboard when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    
}

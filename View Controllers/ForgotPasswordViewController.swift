//
//  ForgotPasswordViewController.swift
//  CustomLoginPage
//
//  Created by Jaldeep Patel on 2021-05-25.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElement()
    }
    
    func setupElement() {
        errorLabel.alpha = 0
        Utilities.styleButton(resetPasswordButton)
    }
    
    @IBAction func resetPasswordTapped(_ sender: UIButton) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let alert = UIAlertController(title: "Hurray!", message: "A password reset request link has been sent on your email. Please check your inbox.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                self.emailTextField.text = ""
            }
        }
    }
    
    //Dismiss keyboard when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

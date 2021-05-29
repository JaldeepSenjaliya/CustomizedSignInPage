//
//  MoreViewController.swift
//  CustomLoginPage
//
//  Created by Jaldeep Patel on 2021-05-22.
//

import UIKit
import Firebase

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        
        let auth = Auth.auth()
        
        do {
            
            //Try signingout and redirect to login screen
            try auth.signOut()
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! LoginViewController
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
            
            //If there is an error, catch the error and show alert
        } catch let signOutError {
            
            let alert = UIAlertController(title: "Error!", message: signOutError.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            //print("Error signing out: %@", signOutError)
            }
        }
    }


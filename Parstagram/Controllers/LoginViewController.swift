//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Marty Nodado on 3/1/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    // Sign In Function
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            
            // user already defined as constant since it assumes it's already regisetered in the database
            if (user != nil) {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error signing in: \(error?.localizedDescription)")
            }
        }
        
    }
    
    // Sign Up/Register Function
    @IBAction func onSignUp(_ sender: Any) {
    
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text

        user.signUpInBackground { (success, error) in
            if (success) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error signing up: \(error?.localizedDescription)")
            }
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

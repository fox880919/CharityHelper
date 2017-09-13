//
//  RegisterViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 26/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,  UITextFieldDelegate {

    @IBOutlet weak var usernameText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var repeatedPassword: UITextField!
    
    
    @IBOutlet weak var NameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameText.delegate = self
        
        passwordText.delegate = self

        repeatedPassword.delegate = self

        NameText.delegate = self

        emailText.delegate = self

        phoneText.delegate = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func register(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Error", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            
            refreshAlert.message = ""
            
        }))
        
        if (usernameText.text!.isEmpty || usernameText.text!.contains(" ")){
            
            refreshAlert.message = "Username can't be empty or contains space"
            
            }
        
        else if (passwordText.text!.isEmpty || passwordText.text!.contains(" ")){
            
            refreshAlert.message = "Password can't be empty or contains space"
            
        }
            
        else if (passwordText.text! != repeatedPassword.text!){
            
            refreshAlert.message = "Repeated password and password don't match"
            
        }
        
        else if (NameText.text!.isEmpty || NameText.text!.contains(" ")){
            
            refreshAlert.message = "name can't be empty or contains space"
            
        }
        
        else if (emailText.text!.isEmpty || emailText.text!.contains(" ")){
            
            refreshAlert.message = "email can't be empty or contains space"
            
        }
            
        else if (validateEmail(enteredEmail: emailText.text!) == false){
            
            refreshAlert.message = "Email isn't valid"
            
        }
        
        else if (phoneText.text!.isEmpty || phoneText.text!.contains(" ")){
            
            refreshAlert.message = "phone can't be empty or contains space"
            
        }
        

        
        else {
            
            let usernameData = (usernameText.text!).data(using: String.Encoding.utf8)
            let usernameEncoded = usernameData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            let passwordData = (passwordText.text!).data(using: String.Encoding.utf8)
            let passwordEncoded = passwordData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))

            
            let userRegisteration = UserRegisteration(username: usernameEncoded, password: passwordEncoded, shopName: NameText.text!, email: emailText.text!, phoneNumber: phoneText.text!)
            
            let registerationViewModel = RegisterationViewModel()
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: true)
            
            registerationViewModel.register(userRegisteration: userRegisteration, success: { (userData) -> Void in
                
                ProgressBar.customActivityIndicatory(self.view, startAnimate: false)

                refreshAlert.message = "Registration was successful"
                
                self.present(refreshAlert, animated: true, completion: nil)
                
                print("Registration was successful")
                
            }, myFailure: {
                
                (description) -> Void in
                
                ProgressBar.customActivityIndicatory(self.view, startAnimate: false)

                
                refreshAlert.message = description
                
                self.present(refreshAlert, animated: true, completion: nil)
                

                
            }){
                
                (error) -> Void in
                
                ProgressBar.customActivityIndicatory(self.view, startAnimate: false)

                
                refreshAlert.message = error.localizedDescription

                self.present(refreshAlert, animated: true, completion: nil)
                                
                
            }
        }
        
        if(refreshAlert.message?.isEmpty == false)
        {
        present(refreshAlert, animated: true, completion: nil)
        }

        
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

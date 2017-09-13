//
//  ViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 21/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameText.delegate = self
        
        passwordText.delegate = self
        
        if let user = MyStorageData.getStoredUser()
        {
            let decodedData = Data(base64Encoded: user.username)!
            
            
            username = String(data: decodedData, encoding: .utf8)!

            self.GoToApp()
            
        }
        
        
        self.title = "Charity Books Recognition App"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func goLogin(_ sender: Any) {
        
   
        let usernameData = (usernameText.text!).data(using: String.Encoding.utf8)
        let usernameEncoded = usernameData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let passwordData = (passwordText.text!).data(using: String.Encoding.utf8)
        let passwordEncoded = passwordData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let userLogin = UserLogin(username: usernameEncoded, password: passwordEncoded)
        
        checkLogin(userLogin: userLogin)
        
    }
    
    func checkLogin(userLogin : UserLogin )
    {
        
        
        let refreshAlert = UIAlertController(title: "Error", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            
        }))
        
        let loginViewModel = LoginViewModel()
        

        
        ProgressBar.customActivityIndicatory(self.view, startAnimate: true)

        
        loginViewModel.login(userLogin: userLogin, success: { (userData) -> Void in
            

            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)


            print("Login was successful")
            
            let userSessionData = UserSessionData(username: userLogin.username, id: userData.id)
            
            MyStorageData.setStoredUser(userSessionData:userSessionData)
            
            let decodedData = Data(base64Encoded: userData.username)!
            
            self.username = String(data: decodedData, encoding: .utf8)!

            self.GoToApp()
            
        }, myFailure: { (description) -> Void in
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)


            
            refreshAlert.message = description
            
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        ){
            
            (error) -> Void in
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)


            refreshAlert.message = error.localizedDescription
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            
        }

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
    
    func GoToApp()
    {
        performSegue(withIdentifier: "GoToApp", sender: self)

    }

    @IBAction func goRegister(_ sender: Any) {
        
        performSegue(withIdentifier: "RegisterSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RegisterSegue" {
            
            if let destination = segue.destination as? RegisterViewController{
                
                destination.title = "Registeration"
                
                
            }
        }
        
        else if (segue.identifier == "GoToApp")
        {
            if let destination = segue.destination as? AppMainPageViewController{
                
                destination.title = "Welcome " + username
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
                
            }

            
        }

    }


}


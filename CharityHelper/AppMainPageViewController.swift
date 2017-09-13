//
//  AppMainPageViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 27/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit

class AppMainPageViewController: UIViewController {

    
    let refreshAlert = UIAlertController(title: "Annoucement", message: "", preferredStyle: UIAlertControllerStyle.alert)

    override func viewDidLoad() {
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            self.refreshAlert .dismiss(animated: true, completion: nil)
            
            self.refreshAlert.message = ""
            
        }))
        


        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GoToBooks(_ sender: Any) {
        
        performSegue(withIdentifier: "GoToBooks", sender: self)

    }

    @IBAction func GoToMovies(_ sender: Any) {
        
        
        refreshAlert.message = "Not available now"
        
        present(refreshAlert, animated: true, completion: nil)
   
    }
    
    @IBAction func GoToGames(_ sender: Any) {
        
        
        refreshAlert.message = "Not available now"
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        

        if parent == nil{
            
            MyStorageData.removeStoredUser()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)

        
        if segue.identifier == "GoToBooks" {
            
            if let destination = segue.destination as? BooksMainViewController{
                
                destination.title = "Books Identifier Section"
                
                
            }
        }
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

//
//  ISBNSearchViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 03/09/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit

class ISBNSearchViewController: UIViewController {

    @IBOutlet weak var ISBNTextField: UITextField!
    
    var books: [Book]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        
        let refreshAlert = UIAlertController(title: "Error", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            
            refreshAlert.message = ""
            
        }))
        
        if let isbn = ISBNTextField.text{
            
            if isbn.isEmpty{
                
                refreshAlert.message = "ISBN field can't be empty"
                
                self.present(refreshAlert, animated: true, completion: nil)

                
            }
            else{
                
                let booksViewModel = BooksViewModel()
                
                ProgressBar.customActivityIndicatory(self.view, startAnimate: true)
                
                booksViewModel.searchBooksByISBN(isbn: isbn, success: { (books) -> Void in
                    
                    self.books = books
                    ProgressBar.customActivityIndicatory(self.view, startAnimate: false)
                    
                    self.goToPop()
                    
                    
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
        }
        else{
            
            refreshAlert.message = "ISBN field can't be empty"
            
            self.present(refreshAlert, animated: true, completion: nil)

        }
    }
    
    
    func goToPop()
    {
        performSegue(withIdentifier: "FromISBNSearchtoPop", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FromISBNSearchtoPop" {
            
            if let destination = segue.destination as? PopupViewController{
                
                destination.title = "Popup"
                
                destination.books = books
                
            }
        }
    }
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)

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

//
//  SearchPopupViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 02/09/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit

class SearchPopupViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    var bookTitle: String!
    
    var bookAuthor: String!
    
    var books: [Book]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let searchTitle = bookTitle{
            
            titleTextField.text! = searchTitle
        }
        else
        {
            bookTitle = ""
        }
        
        if let searchAuthor = bookAuthor{
            
            authorTextField.text! = searchAuthor
        }
        else{
            bookAuthor = ""
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        
        let refreshAlert = UIAlertController(title: "Book", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            
            refreshAlert.message = ""
            
        }))
        
        let booksViewModel = BooksViewModel()
        
        ProgressBar.customActivityIndicatory(self.view, startAnimate: true)

        if let searchTitle = titleTextField.text{
            
           bookTitle = searchTitle
        }
        else
        {
            bookTitle = ""
        }
        
        if let searchAuthor =  authorTextField.text{
            
            bookAuthor = searchAuthor
        }
        else{
            bookAuthor = ""
        }
        
        if(bookTitle == nil && bookAuthor == nil)
        {
            refreshAlert.title = "Error"
            
            refreshAlert.message = "Both fields can't be empty at the same time"
            
            self.present(refreshAlert, animated: true, completion: nil)

        }

        booksViewModel.searchBooks(title: bookTitle, author: bookAuthor, success: { (books) -> Void in
            
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

    
  
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    func goToPop()
    {
        performSegue(withIdentifier: "FromSearchtoPop", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FromSearchtoPop" {
            
            if let destination = segue.destination as? PopupViewController{
                
                destination.title = "Popup"
                
                destination.books = books
                
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

//
//  PopupViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 31/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit
import Alamofire

class PopupViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var authorsTextField: UITextField!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var isbnTextField: UITextField!
    
    @IBOutlet weak var publisherTextField: UITextField!
    
    
    @IBOutlet weak var datePublishedTextField: UITextField!
    
    @IBOutlet weak var pagesCountTextField: UITextField!
    
    @IBOutlet weak var categoriesTextField: UITextField!
    
    var books : [Book]!
    
    var book : Book!
    
    var order = 0
    
    var newImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        loadBook()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let refreshAlert = UIAlertController(title: "Results", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)

            
        }))
        
        if(books.count > 1 && book.exist)
        {
            
            refreshAlert.message = "You have \(books.count) results and the shown book does already exist in database with location: \n \(book.location) and quantity equal to \(book.quantity)"
            

            
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
            
        else if(books.count > 1)
        {
            
            refreshAlert.message = "You have \(books.count) results"
            
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        
        else if(book.exist)
        {
            let refreshAlert = UIAlertController(title: "Book Status", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
                
                refreshAlert.message = ""
                
            }))
            
            refreshAlert.message = "this Book does already exist in database with location: \n \(book.location) and quantity equal to \(book.quantity)"
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            locationTextField.text! = book.location
            
        }

        
    }
    
    func loadBook(){
        
        
        
        book = books[order]
        
        if(book.thumbnailLink.isEmpty || book.thumbnailLink == "")
        {
            imageView.isUserInteractionEnabled = false
        }
        else{
            imageView.isUserInteractionEnabled = true
            
            let barcodeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(PopupViewController.imageTapped))
            
            imageView.addGestureRecognizer(barcodeTapRecognizer)

        }
        
        titleTextField.text! = book.title
        
        var allAuthors = ""
        
        for author in book.author
        {
            allAuthors = allAuthors + author + " / "
        }
        
        allAuthors = String(allAuthors.characters.dropLast(2))
        
        
        authorsTextField.text! = allAuthors
        
        isbnTextField.text! = book.isbn
        
        publisherTextField.text! = book.publisher
        
        datePublishedTextField.text! = book.datePublished
        
        pagesCountTextField.text! = "\(book.pageCount)"
        
        quantityTextField.text! = "\(1)"
        
        
        
        var allCategories = ""
        
        for category in book.categories
        {
            allCategories = allCategories + category + " / "
        }
        
        allCategories = String(allCategories.characters.dropLast(2))
        
        categoriesTextField.text! = allCategories
        
        
        let httpHelper = HttpHelper()
        
        ProgressBar.customActivityIndicatory(self.view, startAnimate: true)

        print(book.smallThumbnailLink)
        
        httpHelper.requestImage(imageUrl: book.smallThumbnailLink, success: { (image) -> Void in
            
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)

            self.imageView.image = image
            
        }, myFailure: { (userData) -> Void in
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)
            
            self.imageView.isUserInteractionEnabled = false

            self.imageView.image = UIImage(named: "No Image")
            
        }, failure: { (userData) -> Void in
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)

            self.imageView.isUserInteractionEnabled = false

            self.imageView.image = UIImage(named: "Error")
            
            
        })
        
        if(book.exist)
        {
            let refreshAlert = UIAlertController(title: "Book Status", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
                
                refreshAlert.message = ""
                
            }))
            
            refreshAlert.message = "Book already exist in database with location: \n \(book.location) and quantity equal to \(book.quantity)"
            
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            locationTextField.text! = book.location
            
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveBook(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Book Status", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            
            refreshAlert.message = ""
            
        }))
        
        let booksViewModel = BooksViewModel()
        
        var newAuthors = [""]
        
        if let temp = authorsTextField.text
        {
         newAuthors = temp.components(separatedBy: " / ")
        }
        
        var newCategories = [""]
        
        if let temp = categoriesTextField.text
        {
        newCategories = temp.components(separatedBy: " / ")
        }

        ProgressBar.customActivityIndicatory(self.view, startAnimate: true)
        
        let newBook = Book(isbn: isbnTextField.text!, title: titleTextField.text!, author: newAuthors, publisher: publisherTextField.text!, datePublished: datePublishedTextField.text!, pageCount: Int(pagesCountTextField.text!)!, categories: newCategories, thumbnailLink: book.thumbnailLink, smallThumbnailLink: book.smallThumbnailLink, exist: book.exist)
        
        newBook.location = locationTextField.text!
        
        newBook.quantity = Int(quantityTextField.text!)!
        
        booksViewModel.addBook(book: newBook, success: {(userData) -> Void in
            
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)
            
            self.bookSuccessfullyExists()
            
            refreshAlert.message = "Book is added successfully"
            
            self.present(refreshAlert, animated: true, completion: nil)
                        
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
    
    func bookSuccessfullyExists()
    {
        
       dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func dismissPopup(_ sender: Any) {
        
      //  dismiss(animated: true, completion: nil)
        
    }
    
    func OnlyOneBookMessage()
    {
        let refreshAlert = UIAlertController(title: "Books Quantity", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            
            refreshAlert.message = ""
            
        }))
        
        refreshAlert.message = "There is only one book in the results"
        
        self.present(refreshAlert, animated: true, completion: nil)


    }
    
    @IBAction func goLeft(_ sender: Any) {
        
        let count = books.count
        
        if(count == 1)
        {
            OnlyOneBookMessage()
            
        }
        else
        {
            if(order + 1 >= books.count)
            {
            order = 0
            book = books[order]
            }
            
            else
            {
                order =  order + 1
                book = books[order]
            }
            
            loadBook()
        }
    }
    
    @IBAction func goRight(_ sender: Any) {
        
        let count = books.count
        
        if(count == 1)
        {
            OnlyOneBookMessage()
            
        }
        else
        {
            if(order  == 0)
            {
                order = count - 1
                book = books[order]
            }
                
            else
            {
                order =  order - 1
                book = books[order]
            }
            
            loadBook()

        }
    }
    
    func imageTapped() {
        
        let httpHelper = HttpHelper()
        
        httpHelper.requestImage(imageUrl: book.thumbnailLink, success: { (image) -> Void in
            
            self.newImageView = UIImageView(image: image)
            self.newImageView.frame = UIScreen.main.bounds
            self.newImageView.backgroundColor = .black
            self.newImageView.contentMode = .scaleAspectFit
            self.newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(PopupViewController.dismissFullscreenImage))
            
            
            self.newImageView.addGestureRecognizer(tap)
            self.view.addSubview(self.newImageView)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)
            
            self.imageView.image = image
            
        }, myFailure: { (userData) -> Void in
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)
            
            self.imageView.image = UIImage(named: "No Image")
            
        }, failure: { (userData) -> Void in
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)
            
            
            self.imageView.image = UIImage(named: "Error")
            
            
        })

        

    }
    
    func dismissFullscreenImage() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        newImageView.removeFromSuperview()
    }
    
}

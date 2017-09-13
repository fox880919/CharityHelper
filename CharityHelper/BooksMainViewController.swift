//
//  BooksMainViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 27/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit

class BooksMainViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    


    @IBOutlet weak var BarcodeImage: UIImageView!
    
    
    @IBOutlet weak var BooksImage: UIImageView!
    
    
    @IBOutlet weak var SearchImage: UIImageView!
    
    var books : [Book]!
    
    var result : String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        
        BarcodeImage.isUserInteractionEnabled = true
        
        BooksImage.isUserInteractionEnabled = true
        
        SearchImage.isUserInteractionEnabled = true
        
        
        
        let barcodeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BooksMainViewController.barcodeImageTapped))
        
        BarcodeImage.addGestureRecognizer(barcodeTapRecognizer)
        
        
        let BooksTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BooksMainViewController.booksImageTapped))
        
        BooksImage.addGestureRecognizer(BooksTapRecognizer)
        
        
        let SearchTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BooksMainViewController.searchImageTapped))
        
        SearchImage.addGestureRecognizer(SearchTapRecognizer)
        
        // Do any additional setup after loading the view.
    }

    
    let picker = UIImagePickerController()
    
    var isBarCodeOption : Bool!

    //MARK: - Delegates
     func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
     {
        
        let refreshAlert = UIAlertController(title: "Book", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
            
            refreshAlert.message = ""
            
        }))

    
    let image  = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
//        let image = UIImage(named: "test3")!
    
    let encodedImage = EncodedImage(encodedIamge: Base64Manager.encodeImage(image: image))
        
        print (encodedImage.encodedString)
    
    let booksViewModel = BooksViewModel()
    
    
    if(isBarCodeOption)
    {
        ProgressBar.customActivityIndicatory(self.view, startAnimate: true)

        booksViewModel.scanBarcode(encodedImage: encodedImage, success: { (books) -> Void in
            
            self.books = books
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)

//            refreshAlert.message = " title: \(book.title) \nAuthor: \(book.author) \nCategory: \(book.categories[0]) \nPublisher: \(book.publisher) \nDate Published: \(book.datePublished)  \nPages: \(book.pageCount)"
//            
//            
//            self.present(refreshAlert, animated: true, completion: nil)
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "popup")
//            vc.modalPresentationStyle = .popover
//            let popover = vc.popoverPresentationController!
//            popover.delegate = self
//            popover.permittedArrowDirections = .up
//            vc.modalPresentationStyle = .overFullScreen
//            vc.modalTransitionStyle = .crossDissolve
//            self.present(vc, animated: true, completion: nil)
            
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
    else{
        
        ProgressBar.customActivityIndicatory(self.view, startAnimate: true)

        
        booksViewModel.identifyBookCover(encodedImage: encodedImage, success: { (coverOCR) -> Void in
            
            ProgressBar.customActivityIndicatory(self.view, startAnimate: false)

            refreshAlert.title = "Result"
            
            self.result = coverOCR.result
            
            self.goToBookCoverPopup()
            
            
            
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
    
    dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated:true, completion: nil)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func barcodeImageTapped() {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        
        
        //let tappedImageView = gestureRecognizer.view!
        
        isBarCodeOption = true
        
        pickPhotoOption()
    }
    
    
    func booksImageTapped() {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        
        isBarCodeOption = false

        pickPhotoOption()
    }
    
    
    func searchImageTapped() {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        
        searchOption()
        
    }
    
    func pickPhotoOption()
    {
        let PhotoAlert = UIAlertController(title: "Options", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        PhotoAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction!) in

            self.useCamera()
            
        }))
        
        PhotoAlert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action: UIAlertAction!) in
            
            self.userPhotoLibrary()
            
        }))
        
        present(PhotoAlert, animated: true, completion: nil)


    }
    
    func searchOption()
    {
        let PhotoAlert = UIAlertController(title: "Options", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        PhotoAlert.addAction(UIAlertAction(title: "ISBN", style: .default, handler: { (action: UIAlertAction!) in
            
            self.goToISBNSearch()
            
        }))
        
        PhotoAlert.addAction(UIAlertAction(title: "Book Details", style: .default, handler: { (action: UIAlertAction!) in
            
            self.goToDetailsSearch()
            
        }))
        
        present(PhotoAlert, animated: true, completion: nil)
        
        
    }
    
    func userPhotoLibrary()
    {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    
    func useCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    

    func goToPop()
    {
        performSegue(withIdentifier: "PopupView", sender: self)

    }
    
    func goToBookCoverPopup(){
        performSegue(withIdentifier: "BookCoverPopupView", sender: self)

    }
    
    
    func goToDetailsSearch()
    {
        performSegue(withIdentifier: "GoToDetailsSearchFromMain", sender: self)
        
    }
    
    func goToISBNSearch()
    {
        performSegue(withIdentifier: "GoToISBNSearchFromMain", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PopupView" {
            
            if let destination = segue.destination as? PopupViewController{
                
                destination.title = "Popup"
                
                destination.books = books
                
            }
        }
        
        else if segue.identifier == "BookCoverPopupView" {
            
            if let destination = segue.destination as? BookCoverPopupViewController{
                
                destination.title = "OCR Result"
                
                destination.result = result
                
            }
            
        }
        
        else if segue.identifier == "GoToDetailsSearchFromMain" {
            
            if let _ = segue.destination as? SearchPopupViewController{
                
                
            }
            
        }
        
        else if segue.identifier == "GoToISBNSearchFromMain" {
            
            if let _ = segue.destination as? SearchPopupViewController{
                
                
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

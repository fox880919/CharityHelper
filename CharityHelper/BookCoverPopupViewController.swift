//
//  BookCoverPopupViewController.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 01/09/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import UIKit

class BookCoverPopupViewController: UIViewController {

    
    @IBOutlet weak var resultTextView: UITextView!
    var result : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultTextView.text! = result
        
        // Do any additional setup after loading the view.
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

    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func searchBooks(_ sender: Any) {
        
        performSegue(withIdentifier: "GoToSearchFromResult", sender: self)

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        result = resultTextView.text!
            
        if segue.identifier == "GoToSearchFromResult" {
            

            let resultsArray = result.components(separatedBy: " ")
            
            let count = resultsArray.count
            
            var title = ""
            
            for i in 0 ..< count - 2 {
                
                title = title + resultsArray[i]
            }
            
            let author = resultsArray[count - 2] + resultsArray[count - 1]
            
           // let count = results
            
            if let destination = segue.destination as? SearchPopupViewController{
                
                
                destination.bookTitle = title
                
                destination.bookAuthor = author

                
            }
            
        }
        
    }

    
}

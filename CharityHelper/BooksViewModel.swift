//
//  BooksViewModel.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 28/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class BooksViewModel : BasicViewModel{
    
    
    private let ISBNURLExtension = "api/googleapis/isbn"
    
    private let SearchURLExtension = "api/googleapis/search"

    
    private let URLOCRExtension = "api/coverocr"
    
    private let postBookExtension = "api/Books"

    func scanBarcode(encodedImage : EncodedImage, success:@escaping ([Book]) -> Void, myFailure:@escaping (String) -> Void ,failure:@escaping (Error) -> Void)   {

        let parameters :  [String : String] =  ["encryptedImage": encodedImage.encodedString]
        
        print(encodedImage.encodedString)
        
        
        let httpHelper = HttpHelper()
        
        httpHelper.requestPOSTURL(URL + ISBNURLExtension + "?userID=\(MyStorageData.getStoredUser()!.id)", params: parameters as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            
            var books = [Book]()
            
            if let jsonArray = JSONResponse.array {
                
                for obj in jsonArray
                {
                    
                    var authors = [String]()
                    
                    for author in obj["Authors"]
                    {
                        authors.append(author.1.stringValue)
                    }
                    
                    var categories = [String]()
                    
                    for obj in obj["Categories"]
                    {
                        categories.append(obj.1.stringValue)
                    }
                    
                    let book = Book(isbn: obj["Isbn"].stringValue, title: obj["Title"].stringValue, author: authors, publisher: obj["Publisher"].stringValue, datePublished: obj["DatePublished"].stringValue, pageCount: obj["PageCount"].intValue, categories: categories, thumbnailLink: obj["Thumbnail"].stringValue , smallThumbnailLink: obj["SmallThumbnail"].stringValue, exist: obj["Exist"].boolValue)
                    
                    
                    if(book.exist)
                    {
                        book.quantity = obj["Quantity"].intValue
                        
                        book.location = obj["ShelfLocation"].stringValue
                        
                    }
                    
                    books.append(book)
                    
                    //print(JSONResponse)
              
                }
                success(books)

                
            }
            
            
        }, myFailure: {
            (description) -> Void in
            
            myFailure(description)
            
            
        }) {
            (error) -> Void in
            
            failure(error)
            
            //print(error)
            
        }

    }
    
    
    
    func identifyBookCover(encodedImage : EncodedImage, success:@escaping (CoverOCR) -> Void, myFailure:@escaping (String) -> Void ,failure:@escaping (Error) -> Void)   {
        
        let parameters : [String : String] =  ["encryptedImage": encodedImage.encodedString]
        
        
        let httpHelper = HttpHelper()
        
        print(encodedImage.encodedString)
        
        httpHelper.requestPOSTURL(URL + URLOCRExtension, params: parameters as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            
            let coverOCR = CoverOCR(result: JSONResponse["Result"].stringValue)
            
            success(coverOCR)
            //print(JSONResponse)
            
            
        }, myFailure: {
            (description) -> Void in
            
            myFailure(description)
            
            
        }) {
            (error) -> Void in
            
            failure(error)
            
            //print(error)
            
        }
        
    }
    
    func addBook(book : Book, success:@escaping (Book) -> Void, myFailure:@escaping (String) -> Void ,failure:@escaping (Error) -> Void)   {
        
        let parameters   =   [
            "Isbn":book.isbn,
            "Title":book.title,
            "Authors":book.author,
            "Publisher":book.publisher,
            "DatePublished": book.datePublished,
            "PageCount": book.pageCount,
            "Categories": book.categories,
            "ShelfLocation": book.location,
            "Quantity": book.quantity,
            "SmallThumbnail": book.smallThumbnailLink,
            "Thumbnail": book.thumbnailLink,
            "Exist":book.exist
            ] as [String : Any]
        
        let httpHelper = HttpHelper()
        
        httpHelper.requestPOSTURL(URL + postBookExtension + "?userID=\(MyStorageData.getStoredUser()!.id)", params: parameters as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            
            var authors = [String]()
            
            for obj in JSONResponse["Authors"]
            {
                authors.append(obj.1.stringValue)
            }
            
            var categories = [String]()
            
            for obj in JSONResponse["Categories"]
            {
                categories.append(obj.1.stringValue)
            }
            
            let book = Book(isbn: JSONResponse["Isbn"].stringValue, title: JSONResponse["Title"].stringValue, author: authors, publisher: JSONResponse["Publisher"].stringValue, datePublished: JSONResponse["DatePublished"].stringValue, pageCount: JSONResponse["PageCount"].intValue, categories: categories, thumbnailLink: JSONResponse["Thumbnail"].stringValue , smallThumbnailLink: JSONResponse["SmallThumbnail"].stringValue, exist: JSONResponse["Exist"].boolValue)
      
            if(book.exist)
            {
                book.quantity = JSONResponse["Quantity"].intValue
                
                book.location = JSONResponse["ShelfLocation"].stringValue
                
            }
            
            success(book)
            //print(JSONResponse)
            
            
        }, myFailure: {
            (description) -> Void in
            
            myFailure(description)
            
            
        }) {
            (error) -> Void in
            
            failure(error)
            
            //print(error)
            
        }
        
    }
    
    func searchBooks(title : String!, author: String!, success:@escaping ([Book]) -> Void, myFailure:@escaping (String) -> Void ,failure:@escaping (Error) -> Void)   {
        
        
        let parameters   =   [
            "Title":title,
            "Author":author
            ] as [String : Any]

        
        let httpHelper = HttpHelper()
        
        httpHelper.requestPOSTURL(URL + SearchURLExtension + "?userID=\(MyStorageData.getStoredUser()!.id)", params: parameters as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            
            var books = [Book]()
            
            if let jsonArray = JSONResponse.array {
                
                for obj in jsonArray
                {
                    
                    var authors = [String]()
                    
                    for author in obj["Authors"]
                    {
                        authors.append(author.1.stringValue)
                    }
                    
                    var categories = [String]()
                    
                    for obj in obj["Categories"]
                    {
                        categories.append(obj.1.stringValue)
                    }
                    
                    let book = Book(isbn: obj["Isbn"].stringValue, title: obj["Title"].stringValue, author: authors, publisher: obj["Publisher"].stringValue, datePublished: obj["DatePublished"].stringValue, pageCount: obj["PageCount"].intValue, categories: categories, thumbnailLink: obj["Thumbnail"].stringValue , smallThumbnailLink: obj["SmallThumbnail"].stringValue, exist: obj["Exist"].boolValue)
                    
                    
                    if(book.exist)
                    {
                        book.quantity = obj["Quantity"].intValue
                        
                        book.location = obj["ShelfLocation"].stringValue
                        
                    }
                    
                    books.append(book)
                    
                    //print(JSONResponse)
                    
                }
                success(books)
                
                
            }
            
            
        }, myFailure: {
            (description) -> Void in
            
            myFailure(description)
            
            
        }) {
            (error) -> Void in
            
            failure(error)
            
            //print(error)
            
        }
        
    }
    
    
    
    func searchBooksByISBN(isbn : String, success:@escaping ([Book]) -> Void, myFailure:@escaping (String) -> Void ,failure:@escaping (Error) -> Void)   {
        
        
        
        
        let httpHelper = HttpHelper()
        
        httpHelper.requestGETURL(URL + ISBNURLExtension + "?userID=\(MyStorageData.getStoredUser()!.id)&isbn=\(isbn)",  success: {
            (JSONResponse) -> Void in
            
            var books = [Book]()
            
            if let jsonArray = JSONResponse.array {
                
                for obj in jsonArray
                {
                    
                    var authors = [String]()
                    
                    for author in obj["Authors"]
                    {
                        authors.append(author.1.stringValue)
                    }
                    
                    var categories = [String]()
                    
                    for obj in obj["Categories"]
                    {
                        categories.append(obj.1.stringValue)
                    }
                    
                    let book = Book(isbn: obj["Isbn"].stringValue, title: obj["Title"].stringValue, author: authors, publisher: obj["Publisher"].stringValue, datePublished: obj["DatePublished"].stringValue, pageCount: obj["PageCount"].intValue, categories: categories, thumbnailLink: obj["Thumbnail"].stringValue , smallThumbnailLink: obj["SmallThumbnail"].stringValue, exist: obj["Exist"].boolValue)
                    
                    
                    if(book.exist)
                    {
                        book.quantity = obj["Quantity"].intValue
                        
                        book.location = obj["ShelfLocation"].stringValue
                        
                    }
                    
                    books.append(book)
                    
                    //print(JSONResponse)
                    
                }
                success(books)
                
                
            }
            
            
        }, myFailure: {
            (description) -> Void in
            
            myFailure(description)
            
            
        }) {
            (error) -> Void in
            
            failure(error)
            
            //print(error)
            
        }
        
    }


    

}

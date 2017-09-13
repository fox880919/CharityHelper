//
//  Books.swift
//  CharityHelper
//
//  Created by Fayez Altamimi on 28/08/2017.
//  Copyright © 2017 Fayez Altamimi. All rights reserved.
//

import Foundation

class Book{
    
    private var _isbn: String!

    private var _title: String!

    private var _author: [String]!

    private var _publisher: String!

    private var _datePublished: String!

    private var _pageCount: Int!
    
    private var _categories:[String]!

    private var _thumbnailLink: String!
    
    private var _smallThumbnailLink:String!
    
    private var _exist:Bool!
    
    private var _quantity:Int!
    
    private var _location:String!

    init(isbn: String!, title: String!, author: [String]!, publisher: String!, datePublished: String!, pageCount: Int!, categories: [String]!, thumbnailLink: String!, smallThumbnailLink: String!, exist: Bool! ) {
        
        _isbn = isbn
        _title = title
        _author = author
        _publisher = publisher
        _datePublished = datePublished
        _pageCount = pageCount
        _categories = categories
        _thumbnailLink = thumbnailLink
        _smallThumbnailLink = smallThumbnailLink
        _exist = exist
        
    }
    
    
    var isbn: String {
        get {
            return self._isbn
        }
    }
    
    var title: String {
        get {
            return self._title
        }
    }
    
    var author: [String] {
        get {
            return self._author
        }
    }
    
    var publisher: String {
        get {
            return self._publisher
        }
    }
    
    var datePublished: String {
        get {
            return self._datePublished
        }
    }
    
    var pageCount: Int {
        get {
            return self._pageCount
        }
    }
    
    var categories: [String] {
        get {
            return self._categories
        }
    }
    
    var thumbnailLink: String {
        get {
            return self._thumbnailLink
        }
    }
    
    var smallThumbnailLink: String {
        get {
            return self._smallThumbnailLink
        }
    }

    var exist: Bool {
        get {
            return self._exist
        }
    }
    
    var quantity : Int{
        get{
            return self._quantity
        }
        set {
            self._quantity = newValue
        }
    }
    
    var location : String{
        get{
           return self._location
        }
        set {
            self._location = newValue
        }
    }
}

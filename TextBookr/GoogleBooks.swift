//
//  GoogleBooks.swift
//  TextBookr
//
//  Created by alec on 10/9/15.
//  Copyright © 2015 skrakattack. All rights reserved.
//

import Foundation
import Alamofire
class GoogleBooks{

    let apikey = "AIzaSyBwwkZnWpnD_wmGGv05HY2F0ITz2sTkiWY"
    


    func isbnRequest(ISBN: String, completion:(result: AnyObject) -> Void) {
        let requestParam = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(ISBN)&key=\(apikey)"
        Alamofire.request(.GET,requestParam)
            .responseJSON { response in
                print(response.request)  // original URL request
                if response.response?.statusCode ===  "200" {
                    completion(result: "FAiled")
                }
                else{
                    
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                    if let JSON = response.result.value {
                        completion(result:JSON )
                    }
                   
                    
                }
        }
        
    }
    func searchRequest(Author: String="",Title: String="", completion:(result: AnyObject) -> Void) {
        var paramters = ""
        
        if (Author != ""){
            let cleanedAuthor = Author.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)

            paramters += "inauthor:\(cleanedAuthor)"
        }
        if (Title != ""){
            let cleanedTitle = Title.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            paramters += "intitle:\(cleanedTitle)"
        }
        let requestParam = "https://www.googleapis.com/books/v1/volumes?q=\(paramters)&key=\(apikey)"
        Alamofire.request(.GET,requestParam)
            .responseJSON { response in
                print(response.request)  // original URL request
                if response.response?.statusCode ===  "200" {
                    completion(result: "FAiled")
                }
                else{
                    
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                    if let JSON = response.result.value {
                        completion(result:JSON )
                    }
                    
                    
                }
        }
        
    }
}
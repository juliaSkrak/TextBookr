//
//  ParseConnection.swift
//  TextBookr
//
//  Created by Julia Skrak on 10/8/15.
//  Copyright © 2015 skrakattack. All rights reserved.
//

import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class ParseConnection: NSObject {
    
    class func saveTextBook(title: NSString, author: NSString, Faculty:NSString, courseNum:NSString) -> Int {
        //test that each of these strings are what they should be
        //the int will refer to different return types so 10 is sucess 0 is problem wiht title 1 is author ect
        let testObject = PFObject(className: "testTextbooks")
        testObject["bookName"] = title
        testObject["authorName"] = author
        testObject["Faculty"] = Faculty
        testObject["courseNum"] = courseNum
        testObject["user"] = PFUser.currentUser()
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
            if((error) != nil){
                print("\(error)")
            }
            print("\(testObject)")
        }
        
      /*  let query = PFQuery(className:"TestObject")
        query.whereKey("bookName", equalTo: "this book")
        query.whereKey("authorName", equalTo: "is really")
        query.whereKey("foo", equalTo:false)
            //come back to this!!!!!
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if !(error != nil) {
                print("found something!! \(objects?.first))")
            } else {
                // Log details of the failure
                print("didnt find something!!")
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
        */
        
        return 10
    }
    
    
    class func searchTextbook(title: NSString, author: NSString, Faculty:NSString, courseNum:NSString) -> PFObject {
        let BookNameQuery = PFQuery(className:"testTextbooks")
        //go through all these and if they arent defined then dont add them to the query
        //go through and first make a query of everything that they input, then do a query based on just course # then an ored query of all of the subcomponents of the query.  Obviously you are gonna get repeats, delete those. we want parse to do most of the work.  so we do all those queries then clean the results of doubles ourselves?
        //query.whereKey("bookName", equalTo: title)
        //query.whereKey("authorName", equalTo: author)
        //query.whereKey("Faculty", equalTo:Faculty)
        //come back to this!!!!!
        
        /*
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if !(error != nil) {
                print("found something!! \(objects?.first))")
            } else {
                // Log details of the failure
                print("didnt find something!!")
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
        
        orQueryWithSubqueries
        */
        
        let query = PFQuery(className:"TestObject")
        query.whereKey("bookName", equalTo: "this book")
        query.whereKey("authorName", equalTo: "is really")
        //query.whereKey("foo", equalTo:"life")
        //come back to this!!!!!
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if !(error != nil) {
                print("found something!! \(objects?.first))")
            } else {
                // Log details of the failure
                print("didnt find something!!")
                NSLog("Error: %@ %@", error!, error!.userInfo)
            }
        }
        
        let testObject = PFObject(className: "testTextbooks")
        return testObject
    }

}

//
//  ViewController.swift
//  TextBookr
//
//  Created by Julia Skrak on 10/2/15.
//  Copyright © 2015 skrakattack. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4
//import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var areYouLooking: UILabel!
    @IBOutlet weak var or: UILabel!
    @IBOutlet weak var questionMark: UILabel!
    @IBOutlet weak var buyButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sellButtonHeightConstraint: NSLayoutConstraint!

    
    var titleField: UITextField
    var courseNumberField:UITextField
    var authorField: UITextField
    var facultyField: UITextField
    var ISBNField: UITextField
    
    var titleLabel: UILabel
    var courseNumberLabel: UILabel
    var facultyLabel: UILabel
    var authorLabel: UILabel
    var ISBNLabel: UILabel
    var orLabel: UILabel
    
    var button: UIButton


/*
 init()
    {
        
        let titleField: UITextField = UITextField (frame:CGRectMake(100, 140, 88, 32));
        //titleField.delegate = self
        titleField.borderStyle = UITextBorderStyle.RoundedRect
        
        let authorField: UITextField = UITextField( frame: CGRectMake(100, 100, 88, 32));
       // authorField.delegate = self
        authorField.borderStyle = UITextBorderStyle.RoundedRect
        
        let courseField: UITextField = UITextField( frame: CGRectMake(100, 180, 88, 32));
      //  courseField.delegate = self
        courseField.borderStyle = UITextBorderStyle.RoundedRect
        print("am i doing antyhing")
        //
        self.init()
    } */
    
    required init?(coder aDecoder: NSCoder) { //for the record, i do not like this.  Not one bit!
        self.titleField = UITextField (frame:CGRectMake(100, 100, 200, 32))// ideally we use autolayout
        self.titleField.borderStyle = UITextBorderStyle.RoundedRect
        
        self.authorField = UITextField( frame: CGRectMake(100, 140, 200, 32))
        self.authorField.borderStyle = UITextBorderStyle.RoundedRect
        
        self.ISBNField = UITextField(frame: CGRectMake(100, 300, 200, 32))
        self.ISBNField.borderStyle = UITextBorderStyle.RoundedRect
        
        
        self.facultyField = UITextField(frame: CGRectMake(100, 180, 200, 32))
        self.facultyField.borderStyle = UITextBorderStyle.RoundedRect
        
        self.courseNumberField = UITextField(frame: CGRectMake(100, 220, 200, 32))
        self.courseNumberField.borderStyle = UITextBorderStyle.RoundedRect
        
        self.titleLabel = UILabel(frame: CGRectMake(16, 100, 84, 32))
        self.authorLabel = UILabel(frame: CGRectMake(16, 140, 84, 32))
        self.courseNumberLabel = UILabel(frame: CGRectMake(16, 220, 84, 32))
        self.facultyLabel = UILabel(frame: CGRectMake(16, 180, 84, 32))
        self.ISBNLabel = UILabel(frame: CGRectMake(16, 300, 84, 32))
        self.orLabel = UILabel(frame: CGRectMake(0, 260, 320, 32))
        
        
        self.button = UIButton(frame: CGRectMake(100, 340, 120, 32))
        //self.user = PFUser.init()
        
        super.init(coder: aDecoder)

    }
    

    func encodeWithCoder(coder aDecoder: NSCoder){
        print("call me maybe?")
    }

    
    override func viewDidLoad() {
        let bookApi = GoogleBooks()
        
        bookApi.isbnRequest("0262032937"){
            (result: AnyObject) in
            let books = result as! NSDictionary
        }
        
        bookApi.searchRequest(Title: "Introduction To Algorithms"){
            (result: AnyObject) in
            let books = result as! NSDictionary
            print("\(books)")
        }
        bookApi.searchRequest("PRAKASH"){
            (result: AnyObject) in
            let books = result as! NSDictionary
            print("\(books)")
        }
        
        
        
        super.viewDidLoad()
        self.titleField.delegate = self
        self.courseNumberField.delegate = self
        self.authorField.delegate = self
        self.facultyField.delegate = self
        
        self.view.addSubview(self.titleField)
        self.view.addSubview(self.authorField)
        self.view.addSubview(self.courseNumberField)
        self.view.addSubview(self.facultyField)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.authorLabel)
        self.view.addSubview(self.courseNumberLabel)
        self.view.addSubview(self.facultyLabel)
        self.view.addSubview(self.ISBNField)
        self.view.addSubview(self.ISBNLabel)
        self.view.addSubview(self.orLabel)
        self.view.addSubview(self.button)
        
        self.button.backgroundColor = self.view.tintColor
        button.layer.cornerRadius = 8
        
        button.clipsToBounds = true
        
        
        self.titleLabel.text = "title:   "
        self.titleLabel.textAlignment = NSTextAlignment.Right
        
        self.authorLabel.text = "author:   "
        self.authorLabel.textAlignment = NSTextAlignment.Right
        
        self.courseNumberLabel.text = "course #:   "
        self.courseNumberLabel.textAlignment = NSTextAlignment.Right
        
        self.facultyLabel.text = "faculty:   "
        self.facultyLabel.textAlignment = NSTextAlignment.Right
        
        self.orLabel.text = "or..."
        self.orLabel.textAlignment = NSTextAlignment.Center
        
        self.ISBNLabel.text = "ISBN: "
        self.ISBNLabel.textAlignment = NSTextAlignment.Right
        
        self.setTextFields(0)

        
        sellButton.addTarget(self, action: "sellButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        buyButton.addTarget(self, action: "buyButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        button.addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        PFFacebookUtils.logInInBackgroundWithPublishPermissions(["publish_actions"], block: {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("i can do stuff wiht ur account!! \(user)")
                PFFacebookUtils.linkUserInBackground(user!, withReadPermissions: ["public_profile"])
                // Your app now has publishing permissions for the user
            } else {
                print("hmm something went terrible wrong")
               
            }
        })
        
        print("current user is \(PFUser.currentUser())")
        
        /*
        // Do any additional setup after loading the view, typically from a nib.
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
     

        content.contentURL = NSURL(string: "https://en.wikipedia.org/wiki/%22Hello,_World!%22_program")
        content.contentTitle = "hello world"
        content.contentDescription = "first fb share"
        content.imageURL = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6d/Listen%2C_do_you_want_to_know_a_secret.jpg")
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
        self.view.addSubview(button)

        let sendButton : FBSDKSendButton = FBSDKSendButton()
        sendButton.shareContent = content
        sendButton.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 150, 100, 25)
        self.view.addSubview(sendButton)
        */
        //UIApplication.sharedApplication().openURL(NSURL(string: "http://www.facebook.com/charlie.beck.9638")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sellButtonTapped(sender:UIButton!){
        self.buyButtonHeightConstraint.constant = 32
        self.sellButtonHeightConstraint.constant = 32
        self.view.setNeedsUpdateConstraints()
        
        self.button.setTitle("sell your book!", forState:(UIControlState.Normal))
        UIView.animateWithDuration(1.5, animations: {
            self.areYouLooking.alpha = 0
            self.or.alpha = 0
            self.questionMark.alpha = 0
            self.buyButton.alpha = 0.25
            self.sellButton.alpha = 1.0
            self.view.layoutIfNeeded()
            }, completion :{
                (value: Bool) -> Void in
                self.setTextFields(1)
        })
    }
    
    
    func buyButtonTapped(sender:UIButton!){
        self.buyButtonHeightConstraint.constant = 32
        self.sellButtonHeightConstraint.constant = 32
        self.view.setNeedsUpdateConstraints()
        self.button.setTitle("find a book!", forState:(UIControlState.Normal))

            
        UIView.animateWithDuration(1.5, animations: {
            self.areYouLooking.alpha = 0
            self.or.alpha = 0
            self.questionMark.alpha = 0
            self.buyButton.alpha = 1.0
            self.sellButton.alpha = 0.25
            self.view.layoutIfNeeded()
            }, completion :{
                (value: Bool) -> Void in
                self.setTextFields(1)
                    
            })
    }
    
   func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.titleField:
            self.authorField.becomeFirstResponder()
        case self.authorField:
            self.facultyField.becomeFirstResponder()
        case self.facultyField:
            self.courseNumberField.becomeFirstResponder()
        case self.courseNumberField:
            print("search stuff")
            buttonPressed()
            //saveString(textfield.text!, author: authorTextField.text!, course: courseTextField.text!)
        default:
            print("error you have a random textfield ew")
        }
        return true;
    }
    
    func buttonPressed(){
        if(sellButton.alpha > 0.5){
        let 🌛 = ParseConnection.saveTextBook(titleField.text!, author: authorField.text!, Faculty: facultyField.text!, courseNum: courseNumberField.text!)  //(title: titleField.text!, author: authorField.text!, Faculty: facultyField.text!, courseNum: courseNumberField.text!)
            if(🌛  == 10){
                setTextFields(1)
            }
        } else {
            let 🌛 = ParseConnection.searchTextbook(titleField.text!, author: authorField.text!, Faculty: facultyField.text!, courseNum: courseNumberField.text!)
            print(🌛)
        }
    }
       
        
    func setTextFields(value: CGFloat){
        self.titleField.alpha = value
        self.courseNumberField.alpha = value
        self.authorField.alpha = value
        self.facultyField.alpha = value
        self.authorLabel.alpha = value
        self.courseNumberLabel.alpha = value
        self.titleLabel.alpha = value
        self.facultyLabel.alpha = value
        self.orLabel.alpha = value
        self.ISBNLabel.alpha = value
        
        self.titleField.text = ""
        self.courseNumberField.text = ""
        self.authorField.text = ""
        self.facultyField.text = ""
        self.ISBNField.alpha = value
        self.button.alpha = value
    }

}


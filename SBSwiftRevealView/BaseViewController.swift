//
//  BaseViewController.swift
//  flicpost
//
//  Created by Stephen Bero on 7/9/14.
//  Copyright (c) 2014 flicpost. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UIViewController{
    var rearNavDelegate : RearNavControllerDelegate!
    var contentScrollHeight : CGFloat!
    var baseScrollView : UIScrollView!
    
    var sizeRect = UIScreen.mainScreen().applicationFrame;
    var screenWidth : CGFloat?
    var screenHeight : CGFloat?
    
    var headerTitle : UILabel?
    
    override init(){
        super.init(nibName: nil, bundle: nil)
        self.initializeView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        self.initializeView(title: title)
        //self.outputAllAppFonts()
    }
    
    init(title: String, makeScrollableView: Bool, contentWithHeight: CGFloat){
        super.init(nibName: nil, bundle: nil)
        self.contentScrollHeight = contentWithHeight
        self.initializeView(title: title, scrollable: makeScrollableView, scrollHeight: contentWithHeight)
    }
    
    func initializeView(title : String = "", scrollable : Bool = false, scrollHeight: CGFloat = 408.0){
        
        self.screenWidth = sizeRect.size.width;
        self.screenHeight = sizeRect.size.height;
        
        NSLog("Screen Height: \(self.screenHeight)")
        
        if(scrollable){
            NSLog("Scroll Height: \(scrollHeight)")
            self.baseScrollView = UIScrollView(frame: CGRectMake(0, 77, 320, scrollHeight))
            //self.baseScrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            self.baseScrollView.contentSize = CGSizeMake(310.0, scrollHeight)
            self.baseScrollView.scrollEnabled = true
            
            self.view.addSubview(self.baseScrollView)
        }
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var headerBar = UIView(frame: CGRectMake(0,0, 320, 72))
        headerBar.backgroundColor = UIColor.grayColor()
        
        self.headerTitle = UILabel(frame: CGRectMake(0, 20, 320, 30))
        
        if(self.headerTitle != nil){
            self.headerTitle!.textAlignment = NSTextAlignment.Center
            self.headerTitle!.text = title
            self.headerTitle!.font = UIFont(name: "ConduitITC", size: 24)
        }
        
        
        var headerButton = UIButton(frame: CGRectMake(10, 10, 40, 40))
        headerButton.setTitle("≡", forState: UIControlState.Normal)
        headerButton.titleLabel?.font = UIFont.systemFontOfSize(36)
        headerButton.setTitleColor(UIColor(red: 251/255, green: 208/255, blue: 43/255, alpha: 1.0), forState: UIControlState.Normal)
        // TODO - Add button TouchUpInside event slide over
        // Need a delegate on the rear nav view controller
        headerButton.addTarget(self, action: "slideOverView:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(headerBar)
        self.view.addSubview(headerTitle!)
        self.view.addSubview(headerButton)
    }
    
    func increaseScrollViewContentSizeByHeight(height: CGFloat){
        self.baseScrollView.contentSize = CGSizeMake(310.0, self.contentScrollHeight + height)
    }
    
    func decreaseScrollViewContentToOriginal(){
        self.baseScrollView.contentSize = CGSizeMake(310.0, self.contentScrollHeight)
    }
    
    func slideOverView(sender: UIButton){
        self.rearNavDelegate.toggleRearNavigationView(self)
    }
}
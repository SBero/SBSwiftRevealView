//
//  RearNavigationViewController.swift
//  flicpost
//
//  Created by Stephen Bero on 7/6/14.
//  Copyright (c) 2014 flicpost. All rights reserved.
//

import Foundation
import UIKit

class RearNavigationViewController : UIViewController, RearNavControllerDelegate {

    var frontViewController: UIViewController?
    var swipeLeftGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    var swipeRightGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    var isFrontViewVisible: Bool!
    var screenHeight: CGFloat!
    var screenWidth: CGFloat!
    var navigationWidth: CGFloat!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
    *   Initialize the Rear Navigation View Controller
    *   with the view to be shown initially.
    *
    *   @var frontViewCtrl: UIViewController
    */

    init(frontViewCtrl: UIViewController, navWidth: CGFloat){
        super.init(nibName: nil, bundle: nil);
        
        self.screenHeight = self.view.frame.height
        self.screenWidth = self.view.frame.width
        self.navigationWidth = navWidth
        
        self.view.backgroundColor = UIColor.darkGrayColor()
        self.view.frame = CGRectMake(0, 0, self.screenWidth, self.screenHeight)
        
        self.frontViewController = frontViewCtrl
        
        self.setupNavigationItems()
        
        NSLog("Initialized Rear View Controller")
    }
    
    override func viewWillAppear(animated: Bool)   {
        self.createNavigationItems()
        self.createGestureRecognition()
        
        let frontViewLoaded:Void? = self.view.addSubview(self.frontViewController!.view)
        
        if (frontViewLoaded != nil) {
            
            self.isFrontViewVisible = true;
        }
        
        NSLog("Rear View Controller Will Appear")
    }
    
    /**
    *   MARK FOR REMOVAL?
    */
    override func viewDidLoad(){

    }
    
    /**
    *   Setup the navigation items for the rear navigation controller
    *
    *   TODO: Add ability to pass another custom view for the navigation
    *         elements.
    */
    func setupNavigationItems(){
        // Setup navigation items here
        
        /* Example

        var settingsBtn = UIButton(frame: CGRectMake(0, 254, self.screenHeight, 50))
        settingsBtn.backgroundColor = UIColor.whiteColor()
        settingsBtn.setTitle("Settings", forState: UIControlState.Normal)
        settingsBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        settingsBtn.addTarget(self, action: "loadSettingsView:", forControlEvents: UIControlEvents.TouchUpInside)
        settingsBtn.titleLabel.font = UIFont(name: "ConduitITC", size: 20)

        */
        var settingsBtn = UIButton(frame: CGRectMake(0, 254, self.navigationWidth, 50))
        settingsBtn.backgroundColor = UIColor.whiteColor()
        settingsBtn.setTitle("Settings", forState: UIControlState.Normal)
        settingsBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        settingsBtn.addTarget(self, action: "loadSettingsView:", forControlEvents: UIControlEvents.TouchUpInside)
        settingsBtn.titleLabel?.font = UIFont(name: "ConduitITC", size: 20)
        self.view.addSubview(settingsBtn)
    }
    
    func loadSettingsView(sender: UIButton){
        NSLog("Clicked Settings Button");
        
        let settingsViewCtrl: ViewController = ViewController()
        settingsViewCtrl.rearNavDelegate = self
        
        self.loadFrontViewWithController(settingsViewCtrl)
    }
    
    
    /**
    *   Loads the users new view upon tap
    */
    func loadFrontViewWithController(frontViewCtrl: UIViewController){
        UIView.animateWithDuration(0.6, animations: {
            self.frontViewController!.view.frame = CGRect(x: self.screenWidth, y: 0, width: self.screenWidth, height: self.screenHeight)
        },
        { (finished: Bool) -> () in
            self.frontViewController!.view.removeFromSuperview()
            self.frontViewController = frontViewCtrl
            
            self.frontViewController!.view.frame = CGRect(x: self.screenWidth, y: 0, width: self.screenWidth, height: self.screenHeight)
            
            var frontViewLoaded : Void? = self.view.addSubview(self.frontViewController!.view)
            
            if((frontViewLoaded) != nil){
                UIView.animateWithDuration(0.6, animations: {
                    self.frontViewController!.view.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
                    })
                
                
                self.isFrontViewVisible = true;
            }
            
        })
    }
    
    /* Toggle Rear Navigation View Section */
    
    func toggleRearNavigationView(currentView: UIViewController){
        
        
        if(!self.isFrontViewVisible){
            self.closeRearNavigationView(currentView)
        }
        else{
            self.openRearNavigationView(currentView)
        }
    }
    
    func closeRearNavigationView(currentView: UIViewController){
        UIView.animateWithDuration(0.6, animations: {
            currentView.view.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
        },
        { (finished: Bool) -> () in
            self.isFrontViewVisible = true;
        })
    }
    
    func openRearNavigationView(currentView: UIViewController){
        UIView.animateWithDuration(0.6, animations: {
        currentView.view.frame = CGRect(x: self.navigationWidth, y: 0, width: self.screenWidth, height: self.screenHeight)
        
        },
        { (finished: Bool) -> () in
            self.isFrontViewVisible = false;
        })
    }
    
    /* Swipe Recognition Section */
    
    func createGestureRecognition(){
        self.swipeLeftGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "processSwipeLeft:")
        self.swipeLeftGestureRecognizer.edges = UIRectEdge.Right
        self.view.addGestureRecognizer(self.swipeLeftGestureRecognizer)
        
        self.swipeRightGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "processSwipeRight:")
        self.swipeRightGestureRecognizer.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(self.swipeRightGestureRecognizer)
    }
    
    func processSwipeLeft(sender: UIScreenEdgePanGestureRecognizer!) -> Void{
        if(!self.isFrontViewVisible){
            self.view.addSubview(self.frontViewController!.view)
            UIView.animateWithDuration(0.6, animations: {
                self.frontViewController!.view.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
                })
            self.isFrontViewVisible = true;
        }
    }
    
    func processSwipeRight(sender: UIScreenEdgePanGestureRecognizer!) -> Void{
        if((self.isFrontViewVisible) != nil){
            // hide the front view.
            UIView.animateWithDuration(0.6, animations: {
                self.frontViewController!.view.frame = CGRect(x: self.navigationWidth, y: 0, width: self.screenWidth, height: self.screenHeight)
                
            },
            { (finished: Bool) -> () in
                //self.frontViewController!.view.removeFromSuperview()
                self.isFrontViewVisible = false;
            })
            
        }
        

    }
    
    func createNavigationItems(){
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /* Add individual navigation functions below */
    
    /*
    func loadSettingsView(sender: UIButton){
        let settingsViewCtrl : SettingsViewController = SettingsViewController()
        settingsViewCtrl.rearNavDelegate = self
        
        self.loadFrontViewWithController(settingsViewCtrl)
    }
    */

}
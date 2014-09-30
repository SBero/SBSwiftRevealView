//
//  ViewController.swift
//  RevealView
//
//  Created by Stephen Bero on 9/12/14.
//  Copyright (c) 2014 qws. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var rearNavDelegate : RearNavControllerDelegate!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button: UIButton = UIButton(frame: CGRectMake(100, 100, 100, 100))
        button.setTitle("Hello World", forState: UIControlState.Normal)
        self.view.addSubview(button)
        self.view.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


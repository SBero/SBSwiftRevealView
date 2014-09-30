//
//  NavControllerDelegate.swift
//  flicpost
//
//  Created by Stephen Bero on 7/14/14.
//  Copyright (c) 2014 flicpost. All rights reserved.
//

import Foundation
import UIKit

protocol RearNavControllerDelegate{
    func toggleRearNavigationView(currentView: UIViewController)
    func loadFrontViewWithController(frontViewCtrl: UIViewController)
}

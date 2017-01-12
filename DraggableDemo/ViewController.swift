//
//  ViewController.swift
//  DraggableTest
//
//  Created by Bay Phillips on 9/24/15.
//  Copyright © 2015 Bay Phillips. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var redBox: DraggableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        redBox = DraggableView(frame: CGRect(x: 150, y: 150, width: 250, height: 250))
        redBox.backgroundColor = UIColor.red
        self.view.addSubview(redBox)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  ViewController.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 18.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dotMatrix = DotMatrixView(frame: NSRect(
            x: 0, y: 0,
            width: 100, height: 100))
       
        view.addSubview(dotMatrix);
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


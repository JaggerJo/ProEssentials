//
//  DotMatrixView.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 19.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation
import Cocoa

public class DotMatrixView : NSView {
    public override func draw(_ dirtyRect: NSRect) {
        NSColor.green.setFill()
        
        let path = NSBezierPath(ovalIn: NSRect(x: 0, y: 0, width: 8, height: 8))
        
        path.fill()
    }
}

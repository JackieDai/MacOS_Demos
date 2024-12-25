//
//  NavigatorCtl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/23.
//

import Cocoa


class NormalCtl: NSViewController {
    
    
    
    deinit {
        print("delloc -- NormalCtl")
    }
    
    override func loadView() {
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))

        self.view = view
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.systemGreen.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

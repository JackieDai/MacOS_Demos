//
//  BaseViewController.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2025/1/4.
//

import Cocoa

class BaseViewController: NSViewController {
    
    override func loadView() {
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        view.wantsLayer = true
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

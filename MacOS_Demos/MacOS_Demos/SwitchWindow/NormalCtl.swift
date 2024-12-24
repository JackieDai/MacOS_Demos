//
//  NavigatorCtl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/23.
//

import Cocoa


class NormalCtl: NSViewController {
    
    static func show(target: NSViewController) {
        let newViewController = NormalCtl()
        
        let newWindow = NSWindow(contentViewController: newViewController)
        newWindow.styleMask = [.titled, .closable, .resizable]
        newWindow.setContentSize(NSSize(width: Helper.ui.app_width, height: Helper.ui.app_height))
        
        let windowController = NSWindowController(window: newWindow)
        windowController.showWindow(target)
    }
    
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

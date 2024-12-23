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
        newWindow.setContentSize(NSSize(width: 800, height: 600))
        
        let windowController = NSWindowController(window: newWindow)
        windowController.showWindow(target)
    }
    
    deinit {
        print("delloc -- NormalCtl")
    }
    
    override func loadView() {
        self.view = NSView.init(frame: CGRect.init(x: 0, y: 0, width: 800, height: 600))
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.systemGreen.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

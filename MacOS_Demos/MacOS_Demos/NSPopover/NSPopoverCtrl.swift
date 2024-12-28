//
//  NSPopoverCtrl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/28.
//

import Cocoa

class NSPopoverCtrl: NSViewController {
    
    let popover = NSPopover()
    
    override func loadView() {
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建 NSPopover 实例
        popover.contentViewController = PopoverContentCtrl()
        popover.behavior = .transient
        
        // 创建一个按钮来显示 NSPopover
        let button = NSButton(title: "Show Popover", target: self, action: #selector(showPopover(_:)))
        button.frame = NSRect(x: 20, y: 20, width: 120, height: 30)
        self.view.addSubview(button)
    }
    
    deinit {
        print("NSPopoverCtrl - Dealloc")
    }
    
    // 显示 NSPopover 的方法
    @objc func showPopover(_ sender: NSButton) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
        }
    }
    
}


class PopoverContentCtrl: NSViewController {
    
    deinit {
        print("PopoverContentCtrl - Dealloc")
    }
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 300))
        let label = NSTextField(labelWithString: "Hello, NSPopover!")
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let button = NSButton(title: "Go to New View", target: self, action: #selector(navigateToNewView))
        self.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(-40)
            make.width.equalTo(160)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        
    }
    // 跳转到新视图的方法
    @objc func navigateToNewView() {
        let ctrl = PopNewViewCtrl()
        self.router.show(ctrl: ctrl, type: .modalWindow)
    }
}


class PopNewViewCtrl: NSViewController {
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: 200))
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        
        let label = NSTextField(labelWithString: "This is a new view!")
        label.frame = NSRect(x: 75, y: 100, width: 150, height: 20)
        self.view.addSubview(label)
    }
    
    deinit {
        print("PopNewViewCtrl - Dealloc")
    }
}

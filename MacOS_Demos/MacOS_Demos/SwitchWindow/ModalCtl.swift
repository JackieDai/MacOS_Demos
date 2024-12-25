//
//  ModalCtl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/23.
//

import Cocoa

class ModalCtl: NSViewController {
    
   
    
    deinit {
        print("delloc -- ModalCtl")
    }
    
    override func loadView() {
        /**
         如果调用了 super.loadView()
         在 loadView 中调用 super.loadView() 并随后覆盖了 self.view，破坏了视图加载流程。
         最佳实践：如果视图是纯代码创建，直接在 loadView 中设置 self.view，不要调用 super.loadView()。
         */
        // super.loadView() 这个方法不要调用，否则会出错
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemBlue.cgColor
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let closeBtn = NSButton.init(title: "Close", target: self, action: #selector(dismiss_action))
        
        self.view.addSubview(closeBtn)
        
        closeBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    @objc func dismiss_action() {
        self.dismiss(self)
    }
    
}

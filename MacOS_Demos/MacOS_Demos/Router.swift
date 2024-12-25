//
//  Router.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/25.
//

import Foundation
import AppKit

protocol RouterCompatible {}

struct Router<T> {
    var base: T
    init(_ base:T) {
        self.base = base
    }
}

extension RouterCompatible {
    var router: Router<Self> {
        get { Router(self) }
        set {} /* 规定: 必须写*/
    }
    static var router:Router<Self>.Type {
        get {Router<Self>.self}
        set {}
    }
}


//===========Above Code Can Do Prefix In Code=============

enum RouterType {
    case normal // via windowCtl
    case modalWindow
    case sheet
}

extension NSViewController: RouterCompatible {}

//extension Router where T == NSViewController {
extension Router where T: NSViewController {
    func show(ctrl: NSViewController, type routerType: RouterType = .normal){
        switch routerType {
        case .normal:
            let vc = ctrl
            let window = NSWindow(contentViewController: vc)
            window.styleMask = [.titled, .closable, .resizable]
            window.setContentSize(.init(width: Helper.ui.app_width, height: Helper.ui.app_height))
    //        window.setFrame(.init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height), display: true)
//            window.title = title
            let windowCtl = NSWindowController(window: window)
            windowCtl.showWindow(self.base)
        case .modalWindow:
//            ctrl.title = "DDDD"
            self.base.presentAsModalWindow(ctrl)
        case .sheet:
            self.base.presentAsSheet(ctrl)
        } 
    }
}

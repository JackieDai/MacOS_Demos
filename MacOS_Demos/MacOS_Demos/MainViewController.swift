//
//  ViewController.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/23.
//

import Cocoa

class MainViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func ctl_transfrom(_ sender: Any) {
        let btn = sender as! NSButton
        
        let tag = btn.tag
        
        switch tag {
        case 0:
            let vc = NormalCtl()
            vc.title = "Normal Ctl"
            self.router.show(ctrl: vc)
            
        case 1:
            let vc = ModalCtl()
            vc.title = "Modal Ctl 1"
            self.router.show(ctrl: vc, type: .modalWindow)
            
        case 2:
            let vc = ModalCtl()
            vc.title = "Modal Ctl 2"
            self.router.show(ctrl: vc, type: .sheet)
            
        case 3:
            let vc = TableViewCtl()
            vc.title = "TableViewCtl"
            self.router.show(ctrl: vc)
            
        case 4:
            let vc = MySplitCtrl()
            vc.title = "MySplitCtrl"
            self.router.show(ctrl: vc)
            
        case 5:
            let vc = SplitViewVC()
            vc.title = "SplitView"
            self.router.show(ctrl: vc)
            
        case 6:
            let vc = CSVTableViewCtrl()
            vc.title = "CSVTableViewCtrl"
            self.router.show(ctrl: vc)
        
        case 7:
            let vc = StackViewCtrl()
            vc.title = "StackViewCtrl"
            self.router.show(ctrl: vc)
            
        case 8:
            let vc = ScrollStackCtrl()
            vc.title = "ScrollStackCtrl"
            self.router.show(ctrl: vc)
            
        case 9:
            let vc = NSPopoverCtrl()
            vc.title = "NSPopoverCtrl"
            self.router.show(ctrl: vc)
            
        case 10:
            let vc = InteractiveWithExCtrl()
            vc.title = "InteractiveWithExCtrl"
            self.router.show(vc)
            
        case 11:
            let vc = HttpCtrlDemo()
            vc.title = "HttpCtrlDemo"
            self.router.show(vc)
            
        default:
            break
        }
    }
}


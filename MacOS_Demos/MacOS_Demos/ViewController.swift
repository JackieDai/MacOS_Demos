//
//  ViewController.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/23.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
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
        default:
            break
        }
    }
}


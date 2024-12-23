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
//        ModalCtl.showAsModalWindow(target: self)
//        ModalCtl.showAsSheet(target: self)
//        NormalCtl.show(target: self)
        
        let tag = 3;
        
        switch tag {
        case 0:
            ModalCtl.showAsModalWindow(target: self)
        case 1:
            ModalCtl.showAsSheet(target: self)
        default:
            NormalCtl.show(target: self)
        }
    }
    
    
}


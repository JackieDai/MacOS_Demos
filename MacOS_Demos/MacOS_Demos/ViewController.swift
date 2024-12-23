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
        ModalCtl.showAsSheet(target: self)
        
        
    }
    
}


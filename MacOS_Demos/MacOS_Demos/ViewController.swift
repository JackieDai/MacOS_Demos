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
        
        let tag = btn.tag;
        
        switch tag {
        case 0:
            NormalCtl.show(target: self)
            
        case 1:
            ModalCtl.showAsModalWindow(target: self)
            
        case 2:
            ModalCtl.showAsSheet(target: self)
           
        default:
            break
        }
    }
    
    
}


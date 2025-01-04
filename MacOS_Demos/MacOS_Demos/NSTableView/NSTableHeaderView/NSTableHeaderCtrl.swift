//
//  NSTableHeaderCtrl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2025/1/4.
//

import Cocoa

class NSTableHeaderCtrl: BaseViewController, NSTableViewDelegate, NSTableViewDataSource {

    let tableView = NSTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = NSScrollView(frame: view.bounds)
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        view.addSubview(scrollView)
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column1"))
        column1.headerCell.stringValue = "Header 1"
        tableView.addTableColumn(column1)
        
        let column2 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column2"))
        column2.headerCell.stringValue = "Header 2"
        tableView.addTableColumn(column2)
        
        let customHeaderView = CustomTableHeaderView(frame: NSRect(x: 0, y: 0, width: 600, height: 50))
        tableView.headerView = customHeaderView
        
        tableView.usesAlternatingRowBackgroundColors = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = NSUserInterfaceItemIdentifier("Cell")
        var cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTextField
        
        if cell == nil {
            cell = NSTextField(labelWithString: "")
            cell?.identifier = cellIdentifier
        }
        
        if tableColumn?.identifier == NSUserInterfaceItemIdentifier("Column1") {
            cell?.stringValue = "Row \(row) - Column 1"
        } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier("Column2") {
            cell?.stringValue = "Row \(row) - Column 2"
        }
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        print("Clicked column: \(tableColumn.identifier.rawValue)")
    }
}

class CustomTableHeaderView: NSTableHeaderView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if #available(macOS 12.0, *) {
            let headerBackgroundColor = NSColor.systemCyan
            headerBackgroundColor.setFill()
            dirtyRect.fill()
        } else {
            // Fallback on earlier versions
        }
    }
}

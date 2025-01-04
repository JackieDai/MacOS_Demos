//
//  EmulateTableViewSectionCtrl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2025/1/4.
//

import Cocoa

class EmulateTableViewSectionCtrl: BaseViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    let tableView = NSTableView()
    let data = [
        ("Section 1", ["Item 1", "Item 2", "Item 3"]),
        ("Section 2", ["Item 4", "Item 5"]),
        ("Section 3", ["Item 6", "Item 7", "Item 8", "Item 9"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let scrollView = NSScrollView(frame: view.bounds)
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        view.addSubview(scrollView)
        
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column"))
        column.headerCell.stringValue = "Header"
        column.maxWidth = view.frame.size.width - 50
        column.minWidth = view.frame.size.width - 50
        tableView.addTableColumn(column)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        // 计算总行数，包括分段标题行
        return data.reduce(0) { $0 + $1.1.count + 1 }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = NSUserInterfaceItemIdentifier("Cell")
        var cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTextField
        
        if cell == nil {
            cell = NSTextField(labelWithString: "")
            cell?.identifier = cellIdentifier
        }
        
        let (section, itemIndex) = indexPath(for: row)
        
        if itemIndex == nil {
            // 分段标题行
            cell?.stringValue = "Section == \(section)"
            cell?.font = NSFont.boldSystemFont(ofSize: 14)
            cell?.backgroundColor = NSColor.lightGray
            cell?.isBordered = false
            cell?.isBezeled = false
            cell?.drawsBackground = true
        } else {
            // 数据行
            cell?.stringValue = data[section].1[itemIndex!]
            cell?.font = NSFont.systemFont(ofSize: 12)
            cell?.backgroundColor = NSColor.clear
            cell?.isBordered = false
            cell?.isBezeled = false
            cell?.drawsBackground = false
        }
        
        return cell
    }
    
    // 根据行号计算分段和数据索引
    func indexPath(for row: Int) -> (Int, Int?) {
        var currentRow = 0
        for (sectionIndex, section) in data.enumerated() {
            if row == currentRow {
                return (sectionIndex, nil)
            }
            currentRow += 1
            if row < currentRow + section.1.count {
                return (sectionIndex, row - currentRow)
            }
            currentRow += section.1.count
        }
        return (0, nil)
    }
}

//
//  TableViewCtl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/25.
//

import Cocoa

class TableViewCtl: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var tableView: NSTableView!
    
    // Sample data for the table view
    let data = [
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Alice", "Age": "30"],
        ["Name": "Bob", "Age": "25"],
        ["Name": "Eve", "Age": "35"]
    ]
    
    
    override func loadView() {
        let v = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        v.wantsLayer = true
        
        v.layer?.backgroundColor = NSColor.cyan.cgColor
        self.view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create NSTableView
        tableView = NSTableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.usesAlternatingRowBackgroundColors = true
        tableView.selectionHighlightStyle = .none
        
        // Create columns
        let nameColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Name"))
        nameColumn.title = "Name"
        tableView.addTableColumn(nameColumn)
        
        let ageColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Age"))
        ageColumn.title = "Age"
        tableView.addTableColumn(ageColumn)
        
        // Create scroll view and add table view to it
        let scrollView = NSScrollView(frame: self.view.bounds)
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        
        // Add scroll view to the main view
        self.view.addSubview(scrollView)
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return data.count
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // Get the data for the current row
        let rowData = data[row]
        
        // Get the cell identifier
        let identifier = tableColumn?.identifier.rawValue ?? ""
        
        print("index == \(row)  identifier == \(identifier)")
        
        // Get the cell view
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(identifier), owner: nil) as? NSTableCellView {
            // Set the cell's text field to display the data
            cell.textField?.stringValue = rowData[identifier] ?? ""
            return cell
        } else {
            // Create a new cell view
            let cell = NSTableCellView()
            
            cell.identifier = NSUserInterfaceItemIdentifier(identifier)
            let field = NSTextField(labelWithString: rowData[identifier] ?? "")
            cell.textField = field
            cell.addSubview(cell.textField!)
            field.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: NSTableView, didAdd rowView: NSTableRowView, forRow row: Int) {
        // Remove any existing divider views
        for subview in rowView.subviews {
            if let isDivider = objc_getAssociatedObject(subview, "isDivider") as? Bool, isDivider {
                subview.removeFromSuperview()
            }
        }
        
        // Add a divider view between each column
        for column in 0..<tableView.numberOfColumns {
            let columnRect = tableView.rect(ofColumn: column)
            let divider = NSView(frame: NSRect(x: columnRect.maxX - 1, y: 10, width: 1, height: rowView.frame.height - 20))
            divider.wantsLayer = true
            divider.layer?.backgroundColor = NSColor.lightGray.cgColor
            // Associate the divider view with a custom property
            objc_setAssociatedObject(divider, "isDivider", true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            rowView.addSubview(divider)
        }
    }
    
}



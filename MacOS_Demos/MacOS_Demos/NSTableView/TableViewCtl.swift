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
        
        
        // below code is to setup seperate line
        /**
         .solidHorizontalGridLineMask：绘制水平网格线。
         .solidVerticalGridLineMask：绘制竖直网格线。
         .dashedHorizontalGridLineMask：绘制水平dash 类型网格线。
         */
        tableView.gridStyleMask = [.solidVerticalGridLineMask, .solidHorizontalGridLineMask, .dashedHorizontalGridLineMask]
        
        tableView.gridColor = .cyan
        
        
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
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false // 启用 Auto Layout,否则在窗口最大化的时候,没法同步
        // 设置滚动视图的约束
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    deinit {
        print("delloc -- TableViewCtl")
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
        
        //        print("index == \(row)  identifier == \(identifier)")
        
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
            
            cell.wantsLayer = true
            cell.layer?.backgroundColor = NSColor.brown.cgColor
            return cell
        }
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
}



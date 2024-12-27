//
//  CSVTableView.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/27.
//

import Cocoa

/// 二维数组，外层表示 column， 内层表示 row
typealias CoverageType = [[String]]

struct CsvTableHepler {
    
    let csvFileName: String
    
    var csvData: CoverageType {
        // 加载csv 数据
        guard let path = Bundle.main.path(forResource: csvFileName, ofType: "csv") else {
            assert(false, "无效path")
        }
        
        var data: CoverageType = .init()
        
        guard let stream = InputStream(fileAtPath: path) else {
            assert(false, "无效")
        }
        
        do {
            let csvData = try CSVReader(stream: stream)
            while let row = csvData.next() {
                data.append(row)
            }
        } catch {
            assert(false, "解析无效")
        }
        
        return data
    }
}

class CSVTableViewCtrl: NSViewController {
    
    let column_id_prefix = "column_id_"
    
//    lazy var csvHelper = CsvTableHepler(csvFileName: "Initial")
    lazy var csvHelper = CsvTableHepler(csvFileName: "PingPongTest_LF")
    
    lazy var columns_header_data = csvHelper.csvData.first!
    
    lazy var columns_body_data: CoverageType = {
        var totalData = csvHelper.csvData
        totalData.removeFirst()
        return totalData
    }()
    
    var tableView: NSTableView!
    
    override func loadView() {
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemBlue.cgColor
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create NSTableView
        tableView = NSTableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.usesAlternatingRowBackgroundColors = true
        tableView.selectionHighlightStyle = .none
        
        tableView.gridStyleMask = [.solidVerticalGridLineMask,
//            .solidHorizontalGridLineMask,
//            .dashedHorizontalGridLineMask
        ]

        tableView.gridColor = .lightGray
        
        
       
        for col_index in (0..<columns_header_data.count) {
//        for col_index in (0..<4) {
            let id = column_id_prefix + "\(col_index)"
            let title = columns_header_data[col_index]
            let column = NSTableColumn(identifier: .init(id))
            column.title = title
//            column.minWidth = 50.0
//            column.maxWidth = 1000.0
            tableView.addTableColumn(column)
        }
        
        /**
         NSTableColumn宽度缩放：方式一:
         添加上这两句代码，可以实现 NSTableColumn 宽度大小任意缩放
         */
//        tableView.enclosingScrollView?.hasHorizontalScroller = true
//        tableView.columnAutoresizingStyle = .noColumnAutoresizing

        // Create scroll view and add table view to it
        let scrollView = NSScrollView(frame: self.view.bounds)
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        /**
         NSTableColumn宽度缩放：方式二:
         添加上这两句代码，可以实现 NSTableColumn 宽度大小任意缩放
         */
        scrollView.hasHorizontalScroller = true
        
        // Add scroll view to the main view
        self.view.addSubview(scrollView)
    }
    
    deinit {
        print("CSVTableViewCtrl -- deinit")
    }
    
}


extension CSVTableViewCtrl: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        columns_body_data.count
    }
}

extension CSVTableViewCtrl: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let rowData = columns_body_data[row]
        
        let col_id = tableColumn?.identifier.rawValue ?? ""
        
        // replace identifier and fetch index
        
        let col_index_str = col_id.replacingOccurrences(of: column_id_prefix, with: "")
        
        let col_index = Int(col_index_str)!
        
        if let cell = tableView.makeView(withIdentifier: .init(col_id), owner: nil) as? NSTableCellView {
            
            cell.textField?.stringValue = rowData[col_index]
            return cell
        } else {
            // Create a new cell view
            let cell = NSTableCellView()
            
            cell.identifier = NSUserInterfaceItemIdentifier(col_id)
            let field = NSTextField(labelWithString: rowData[col_index] )
            cell.textField = field
            cell.addSubview(cell.textField!)
            field.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
            }
            return cell
        }

    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 40
    }
}

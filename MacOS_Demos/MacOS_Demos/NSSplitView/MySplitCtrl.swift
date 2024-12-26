//
//  MySplitCtrl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/26.
//

import Cocoa

class MySplitCtrl: NSSplitViewController {
    // 创建左侧视图控制器
    let sidebarViewController = SidebarViewController()
    // 创建右侧内容视图控制器
    let contentViewController = ContentViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
        //               sidebarItem.minimumThickness = 50
        sidebarItem.minimumThickness = 100
        sidebarItem.maximumThickness = 100
        self.addSplitViewItem(sidebarItem)
        
        contentViewController.items = sidebarViewController.items
        let contentItem = NSSplitViewItem(viewController: contentViewController)
        self.addSplitViewItem(contentItem)

        // 设置默认选中的项目
        sidebarViewController.delegate = contentViewController
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        contentViewController.didSelectItem(at: 0)
    }
    
    
    deinit {
        print("MySplitCtrl - Dealloc")
    }
}
protocol SidebarDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

class SidebarViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    weak var delegate: SidebarDelegate?
    
    let tableView = NSTableView()
    let items = ["Mode", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About", "Wi-Fi", "Bluetooth", "Notifications", "About"]
    
    override func loadView() {
        self.view = NSView(frame: .init(x: 0, y: 0, width: 100, height: 0))
//        self.view.wantsLayer = true
//        self.view.layer?.backgroundColor = NSColor.cyan.cgColor
        
        
        // 创建 Table View
        let scrollView = NSScrollView(frame: self.view.bounds)
        scrollView.hasVerticalScroller = true
        scrollView.documentView = tableView
        self.view.addSubview(scrollView)

        
        // 配置 Table View
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column"))
        column.width = 100
        tableView.addTableColumn(column)
        tableView.headerView = nil
        tableView.dataSource = self
        tableView.delegate = self
        
        // 自动调整大小
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let view = NSView()
//        view.wantsLayer = true
//        view.layer?.backgroundColor = NSColor.systemGreen.cgColor
        
        let field = NSTextField()
        field.stringValue = items[row]
        field.isEditable = false
        field.isBordered = false
        field.backgroundColor = .clear
        
        view.addSubview(field)
        
        field.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return view
        
       
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        delegate?.didSelectItem(at: tableView.selectedRow)
    }
    
    deinit {
        print("SidebarViewController - Dealloc")
    }
}


class ContentViewController: NSViewController, SidebarDelegate {
    
    let label = NSTextField()
    
    var items: [String]?
    
    deinit {
        print("ContentViewController - Dealloc")
    }
    
    override func loadView() {
        self.view = NSView(frame: .zero)
//        self.view.wantsLayer = true

//        self.view.layer?.backgroundColor = NSColor.systemYellow.cgColor

        // 配置 Label
        
        label.isEditable = false
        label.isBordered = false
        label.backgroundColor = .clear
        self.view.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
    
    func didSelectItem(at index: Int) {
        guard let items = items else {
            return
        }
 
        guard index >= 0 && index < items.count else { return }
        label.stringValue = "Selected: \(items[index])"
    }
}

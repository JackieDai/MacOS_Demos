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
    let items = ["Mode", "Wi-Fi", "Bluetooth", "Notifications", "About"]
    
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
    
    let button = NSButton(title: "Go to Detail", target: nil, action: nil) // 添加按钮
    
    
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
        
        // 配置按钮
        button.target = self
        button.action = #selector(buttonClicked) // 设置点击事件
        self.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20) // 位于 Label 下方
        }
    }
    
    
    
    func didSelectItem(at index: Int) {
        guard let items = items else {
            return
        }
        
        guard index >= 0 && index < items.count else { return }
        label.stringValue = "Selected: \(items[index])"
    }
    
    @objc func buttonClicked() {
        // 创建新的视图控制器
        let detailViewController = DetailViewController()
        
        detailViewController.titleLabel.stringValue = "Detail VC " + label.stringValue
        
        // 跳转到新的界面
        self.replaceCurrentView(with: detailViewController)
    }
    
    func replaceCurrentView(with newController: NSViewController) {
        // 移除当前子视图
        self.children.forEach { child in
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        // 添加新的子视图
        self.addChild(newController)
        self.view.addSubview(newController.view)
        
        // 设置布局
        newController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



class DetailViewController: NSViewController {
    
    let titleLabel = NSTextField() // 用于显示标题的控件
    
    override func loadView() {
        self.view = NSView(frame: .zero)
        
        // 配置背景颜色（可选）
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.systemGray.cgColor
        
        // 添加返回按钮
        let backButton = NSButton(title: "<Back", target: self, action: #selector(backButtonClicked))
        self.view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalTo(30)
        }
        
         
        // 配置标题
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        titleLabel.font = NSFont.boldSystemFont(ofSize: 20)
        titleLabel.alignment = .center
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20) // 距离顶部 20 点
        }
    }
    
    @objc func backButtonClicked() {
        // 通知父视图控制器切换回主界面
        if let _ = self.parent as? ContentViewController {
            self.removeFromParent()
            self.view.removeFromSuperview()
        }
    }
    
    
    deinit {
        print("DetailViewController - Dealloc")
    }
}

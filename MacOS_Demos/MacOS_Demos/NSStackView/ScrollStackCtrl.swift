//
//  ScrollStackCtrl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/28.
//

import Cocoa

class ScrollStackCtrl: NSViewController {
    
    // 定义一个布尔变量
    var isVertical: Bool = true {
        didSet {
            // 每次布尔变量变化时更新按钮标题
            updateButtonTitle()
        }
    }
    
    // 创建一个按钮
    let toggleButton: NSButton = {
        let button = NSButton()
        button.title = "当前状态: vertical"
        button.bezelStyle = .rounded
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 创建一个 NSScrollView 并将 stackView 作为其内容视图
    lazy var scrollView = NSScrollView()
    
    override func loadView() {
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        self.view = view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 将 scrollView 添加到视图控制器的视图中
        self.view.addSubview(scrollView)
        
        // 设置 scrollView 的约束
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: 200),
            scrollView.heightAnchor.constraint(equalToConstant: 300),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        updateStackView()
        
        
        // 将按钮添加到视图中
        self.view.addSubview(toggleButton)
        
        toggleButton.snp.makeConstraints { make in
            make.leading.top.equalTo(40)
        }
        
        // 为按钮添加点击事件
        toggleButton.target = self
        toggleButton.action = #selector(toggleButtonClicked)
    }
    
    
    // 按钮点击事件处理函数
    @objc func toggleButtonClicked() {
        // 取反布尔变量
        isVertical.toggle()
    }
    
    // 更新按钮标题
    func updateButtonTitle() {
        toggleButton.title = "当前状态: \(isVertical ? "vertical" : "horizontal")"
        updateStackView()
    }
    
    
    deinit {
        print("ScrollStackCtrl - Dealloc")
    }
}


extension ScrollStackCtrl {
    func updateStackView() {
        // 创建一个垂直排列的 NSStackView
        let stackView = MyStackView()
        
        stackView.orientation = isVertical ? .vertical : .horizontal
        stackView.wantsLayer = true
        stackView.layer?.backgroundColor = NSColor.cyan.cgColor
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        /**
         为了能够确定 stackView 的尺寸，需要将内部的元素宽度或者高度固定，并关联到stackView
         */
        let scroll_width = 200.0
        let scroll_height = 300.0
        
        // 向 stackView 添加一些示例视图
        for i in 1...20 {
            
            
            let subV = NSView()
            subV.wantsLayer = true
            subV.layer?.backgroundColor = NSColor.systemPink.cgColor
            stackView.addArrangedSubview(subV)
            subV.snp.makeConstraints { make in
                if isVertical {
                    make.height.equalTo(44)
                    make.width.equalTo(scroll_width)
                    make.leading.trailing.equalToSuperview()
                } else {
                    make.height.equalTo(scroll_height)
                    make.width.equalTo(100)
                    make.top.bottom.equalToSuperview()
                }
                
            }
            //
            let label = NSTextField(labelWithString: "Item \(i)")
            subV.addSubview(label)
            
            label.wantsLayer = true
            label.layer?.backgroundColor = NSColor.brown.cgColor
            
            label.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        if isVertical {
            scrollView.hasVerticalScroller = true
        } else {
            scrollView.hasHorizontalScroller = true
        }
        scrollView.documentView = stackView
    }
}


class MyStackView: NSStackView {
    deinit {
        print("MyStackView -- dealloc")
    }
}

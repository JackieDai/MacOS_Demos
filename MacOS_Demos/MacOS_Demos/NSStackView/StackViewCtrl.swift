//
//  StackViewCtrl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/27.
//

import Cocoa

class StackViewCtrl: NSViewController {
    
    // 定义一个标签和一个文本框
    let label = NSTextField(labelWithString: "Enter your name:")
    let textField = NSTextField()
    
    // 定义一个按钮
    let button = NSButton(title: "Submit", target: nil, action: #selector(buttonClicked))
    override func loadView() {
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建一个垂直的 NSStackView
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.wantsLayer = true
        stackView.layer?.backgroundColor = NSColor.red.cgColor
        
        // 创建一个水平的 NSStackView 来包含标签和文本框
        let horizontalStackView = NSStackView()
        horizontalStackView.orientation = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 10
        horizontalStackView.addArrangedSubview(label)
        label.wantsLayer = true
        label.layer?.backgroundColor = NSColor.cyan.cgColor
        horizontalStackView.addArrangedSubview(textField)
        textField.wantsLayer = true
        textField.layer?.backgroundColor = NSColor.systemPink.cgColor
        horizontalStackView.layer?.backgroundColor = NSColor.green.cgColor
        
        // 添加子视图到垂直的 stackView 中
        stackView.addArrangedSubview(horizontalStackView)
        
        stackView.addArrangedSubview(button)
        
        let ttV = NSView(frame: .init(x: 0, y: 0, width: 50, height: 50))
        ttV.wantsLayer = true
        ttV.layer?.backgroundColor = NSColor.purple.cgColor

        stackView.addArrangedSubview(ttV)
        
        /**
         此处必须使用约束才能看到View，否则看不到
         */
        ttV.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
//        self.view.addSubview(ttV)
        
//        button.isHidden = true
        
        // 将 stackView 添加到主视图中
        view.addSubview(stackView)
        
        // 设置 stackView 的布局约束
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // 按钮点击事件处理
    @objc func buttonClicked() {
        let name = textField.stringValue
        let alert = NSAlert()
        alert.messageText = "Hello, \(name)!"
        alert.runModal()
    }
    
    deinit {
        print("StackViewCtrl - Dealloc")
    }
    
}

//
//  SplitViewVC.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/26.
//

import Cocoa



class SplitViewVC: NSViewController, NSSplitViewDelegate {
    
    var splitView: NSSplitView!
    
    /**
     注意：!!!
     1. 如果通过Xib 创建的控制器,其view 的尺寸是Xib上的尺寸
     */
    
    override func loadView() {
        let view = NSView(frame: .init(x: 0, y: 0, width: Helper.ui.app_width, height: Helper.ui.app_height))
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       print("viewDidLoad")
        // 初始化 NSSplitView
        splitView = NSSplitView(frame: self.view.bounds)
        splitView.autoresizingMask = [.width, .height]
        splitView.dividerStyle = .thin
        splitView.wantsLayer = true
        splitView.layer?.backgroundColor = NSColor.systemRed.cgColor
        
        splitView.isVertical = true
//        splitView.
        splitView.delegate = self
        
        let subV_width = self.splitView.bounds.width / 3.0
        let subV_height = self.splitView.bounds.height
        
        // 创建左侧视图
        let leftView = NSView(frame: NSMakeRect(0, 0, subV_width, subV_height))
        leftView.wantsLayer = true
        leftView.layer?.backgroundColor = NSColor.red.cgColor
        
        // 创建中间视图
        let middleView = NSView(frame: NSMakeRect(0, 0, subV_width, subV_height))
        middleView.wantsLayer = true
        middleView.layer?.backgroundColor = NSColor.yellow.cgColor
        
        // 创建右侧视图
        let rightView = NSView(frame: NSMakeRect(0, 0, subV_width, subV_height))
        rightView.wantsLayer = true
        rightView.layer?.backgroundColor = NSColor.blue.cgColor
        
        // 将视图添加到 NSSplitView
        splitView.addSubview(leftView)
        splitView.addSubview(middleView)
        splitView.addSubview(rightView)
        
        // 将 NSSplitView 添加到主视图
        self.view.addSubview(splitView)
    }
    
    // 实现 NSSplitViewDelegate 方法（可选）
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        // 不允许任何视图折叠
        return false
    }
    
    func splitView(_ splitView: NSSplitView, shouldAdjustSizeOfSubview subview: NSView) -> Bool {
        // 允许调整所有视图的大小
        return true
    }
}

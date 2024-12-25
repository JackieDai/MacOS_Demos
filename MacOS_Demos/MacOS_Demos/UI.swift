//
//  UI.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/24.
//

import Foundation
import Cocoa

struct UI {
}


extension UI {
    
    var app_width: CGFloat {
        screen_visiable_width * 0.618
    }
    
    var app_height: CGFloat {
        screen_visiable_height * 0.618
    }
    
    var screen_visiable_height: CGFloat {
        screenVisibleSize.height
    }
    var screen_visiable_width: CGFloat {
        screenVisibleSize.width
    }
    
    var screenSize: CGSize {
        if let screen = NSScreen.main {
            let screenFrame = screen.frame  // 完整屏幕尺寸：包含顶部菜单和底部Dock
            return screenFrame.size
        } else {
            assert(false, "Sth Err")
        }
    }
    
    var screenVisibleSize: CGSize {
        if let screen = NSScreen.main {
            let visibleFrame = screen.visibleFrame // exclude menu and dock bar height
            return visibleFrame.size
        } else {
            assert(false, "Sth Err")
        }
    }
}


extension UI {
    // modify the window default size
    func modifyWindowSize() {
        
        guard let screen = NSScreen.main else {
            print("screen is unavailable")
            return
        }
        
        /**
         NSApplication.shared.mainWindow 只有在窗口被激活时才会返回正确的值。如果窗口还没有成为主窗口，mainWindow 的值将为 nil。
         */
        //        guard let mainWindow = NSApplication.shared.mainWindow else {
        //            print("mainWindow is unavailable")
        //            return
        //        }
        
        guard let mainWindow = NSApp.windows.first else {
            print("mainWindow is unavailable")
            return
        }
        
        let screenFrame = screen.visibleFrame
        
        let width = app_width
        let height = app_height
        
        let x = NSMidX(screenFrame) - width * 0.5
        let y = NSMidY(screenFrame) - height * 0.5
        
        // 创建窗口尺寸相对屏幕中心的位置
        
        let frame = NSMakeRect(x, y, width, height)
        
        mainWindow.setFrame(frame, display: true)
        
    }
}

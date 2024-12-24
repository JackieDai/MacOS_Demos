//
//  AppDelegate.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        modifyWindowSize()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}


extension AppDelegate {
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
        
        let width = 800.0
        let height = 600.0
        
        let x = NSMidX(screenFrame) - width * 0.5
        let y = NSMidY(screenFrame) - height * 0.5

        // 创建窗口尺寸相对屏幕中心的位置
        
        let frame = NSMakeRect(x, y, width, height)

        mainWindow.setFrame(frame, display: true)

    }
}

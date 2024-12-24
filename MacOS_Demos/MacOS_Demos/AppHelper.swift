//
//  AppHelper.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/24.
//

import Foundation
import Cocoa

public let Helper = AppHelper.shared

public class AppHelper {
    // 静态实例，确保全局唯一
    public static let shared = AppHelper()

    // 私有化构造函数，防止外部初始化
    private init() {}
    
    
    /// UI Config
    var ui: UI {
        UI()
    }
}


extension AppHelper {
    
}

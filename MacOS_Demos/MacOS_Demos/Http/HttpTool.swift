//
//  HttpTool.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2025/1/3.
//

import Foundation

/**
 注意，当网络请求时，报如下错误:
 Error: The operation couldn’t be completed. Operation not permitted
 
 
 1. App Sandbox 限制
 如果你的项目启用了 App Sandbox（常见于 macOS 应用开发），默认情况下，网络访问是被禁止的。

 解决方法：
 打开你的 Xcode 项目。
 在项目导航栏中，选择你的项目目标（Target）。
 转到 Signing & Capabilities 选项卡。
 如果启用了 App Sandbox，展开它并勾选 Outgoing Connections (Client)。
 这样可以允许应用程序发起网络请求。
 
 
 2. ATS（App Transport Security）限制
 macOS 和 iOS 的 App Transport Security (ATS) 默认禁止不安全的 HTTP 请求。如果你使用的是非 HTTPS 的 URL，就可能触发此错误。

 解决方法：
 打开 Info.plist 文件。
 添加以下键值对以临时允许非 HTTPS 请求（仅适用于开发阶段）：
 
 <key>NSAppTransportSecurity</key>
 <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
 </dict>
 
 ⚠️ 注意： 在生产环境中，尽量使用 HTTPS 来保障数据安全。
 */

struct HttpTool {
    
    static func getRequest(urlString: String, parameters: [String: String]? = nil, sync: Bool = true) {
        // 构建 URL
        var urlComponents = URLComponents(string: urlString)
        
        // 将参数拼接到URL中
        if let parameters = parameters {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents?.url else {
            print("Invalid URL with parameters")
            return
        }
        
        // 创建 URL 请求
        let request = URLRequest(url: url)
        
        var semaphore: DispatchSemaphore?
        
        if sync {
            // 创建信号量
            semaphore = DispatchSemaphore(value: 0) //创建一个初始值为 0 的信号量通常用于同步操作，使得后续的代码等待信号量被释放后才能继续执行。
        }
        
        // 创建 URLSession 并发起请求
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("--Get---begin-----\(url.absoluteString)----")
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // 释放信号量
                semaphore?.signal()
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("HTTP Status Code: \(response.statusCode)")
            }
            
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(responseString)")
                }
            }
            print("--Get---end----------\n\n\n")
            // 释放信号量
            semaphore?.signal()
        }
        
        task.resume()
        // 等待信号量
        semaphore?.wait()
    }
    
    
    static func postRequest(urlString: String, parameters: [String: Any], sync: Bool = true) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // 创建 URLRequest 对象
        var request = URLRequest(url: url)
        request.httpMethod = "POST"  // 设置 HTTP 方法为 POST
        // 设置请求头（如果需要，例如 JSON 格式）
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 将参数转换为 JSON 数据
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData  // 设置请求体为 JSON 数据
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
            return
        }
        
        var semaphore: DispatchSemaphore?
        
        if sync {
            // 创建信号量
            semaphore = DispatchSemaphore(value: 0)
        }
        
        // 创建 URLSession 并发起请求
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 处理错误
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // 释放信号量
                semaphore?.signal()
                return
            }
            
            // 处理响应
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            // 处理返回数据
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response Data: \(responseString)")
                }
            }
            // 释放信号量
            semaphore?.signal()
        }
        task.resume()
        
        // 等待信号量
        semaphore?.wait()
    }
}

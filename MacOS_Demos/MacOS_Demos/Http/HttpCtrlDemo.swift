//
//  HttpCtrlDemo.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2025/1/3.
//

import Cocoa

class HttpCtrlDemo: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func get(_ sender: Any) {
        print("1-----------------------------");
        HttpTool.getRequest(urlString: "https://jsonplaceholder.typicode.com/posts/1")
        print("2-----------------------------");
        HttpTool.getRequest(urlString: "https://jsonplaceholder.typicode.com/comments", parameters: ["postId": "1"])
        print("3-----------------------------");
    }
    
    @IBAction func post(_ sender: Any) {
        
        let baseUrl = "https://jsonplaceholder.typicode.com/posts"
        print("1-----------------------------");
        HttpTool.postRequest(urlString: baseUrl, parameters: ["title":"sunt1","body":"bar1","userId":1])
        
        print("2-----------------------------");
        HttpTool.postRequest(urlString: baseUrl, parameters: ["title":"sunt2","body":"bar2","userId":2])
        
        print("3-----------------------------");
        HttpTool.postRequest(urlString: baseUrl, parameters: ["title":"sunt3","body":"bar3","userId":3], sync: false)
        print("4-----------------------------");
        
    }
    
}

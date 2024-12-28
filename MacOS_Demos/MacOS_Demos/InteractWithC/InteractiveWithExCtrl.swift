//
//  InteractiveWithExCtrl.swift
//  MacOS_Demos
//
//  Created by lingxiao on 2024/12/28.
//

import Cocoa

class InteractiveWithExCtrl: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
}

extension InteractiveWithExCtrl {
    @IBAction func interactWithC(_ sender: Any) {
        
        callMathOperation(operation: "add", num1: 10, num2: 5)
        callMathOperation(operation: "mod", num1: 10, num2: 3)
    }
    
    func callMathOperation(operation: String, num1: Int, num2: Int) {
        let task = Process() // 通过 Process 类创建一个新的进程
        
        // 获取可执行文件的路径。
        task.executableURL = URL(fileURLWithPath: Bundle.main.path(forResource: "math_operations", ofType: nil)!)

        // 将操作类型和数字作为参数传递给可执行文件。
        task.arguments = [operation, "\(num1)", "\(num2)"]

        // 使用 Pipe 类捕获可执行文件的输出。
        let pipe = Pipe()
        task.standardOutput = pipe

        do {
            // 使用 run() 方法启动进程，并使用 waitUntilExit() 方法等待进程完成。
            try task.run()
            task.waitUntilExit()

            // 读取管道中的数据并将其转换为字符串，然后打印结果。
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                print("Result: \(output.trimmingCharacters(in: .whitespacesAndNewlines))")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

//
//  ViewController.swift
//  INI Creator
//
//  Created by aelarassi on 3/6/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let folderName = "MyFolder"
    let extention = ".ini"
    let fileName = "example"
    private let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionCreateFile(_ sender: Any) {
        createFile()
    }
    
    @IBAction func actionReadFile(_ sender: Any) {
        readFile()
    }
    
    func readFile() {
                
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Unable to access document directory.")
            return
        }
        
        let fileURL = directoryURL.appendingPathComponent(folderName).appendingPathComponent("\(fileName)\(extention)")
        
        do {
            let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = fileContent.components(separatedBy: .newlines)
            
            var valueForKey3: String?
            
            for line in lines {
                let keyValue = line.components(separatedBy: "=")
                if keyValue.count == 2 && keyValue[0] == "key3" {
                    valueForKey3 = keyValue[1]
                    break
                }
            }
            
            if let value = valueForKey3 {
                print("Value for key3: \(value)")
            } else {
                print("Key3 not found in the \(extention) file.")
            }
        } catch {
            print("Error while reading file: \(error)")
        }
    }
    
    func createFile() {
        let fileContent = """
                key1=value1
                key2=value2
                key3=value3
                key4=value4
                """
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Unable to access document directory.")
            return
        }
        
        let folderURL = documentDirectory.appendingPathComponent(folderName, isDirectory: true)
        
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            
            let fileURL = folderURL.appendingPathComponent("\(fileName)\(extention)")
            
            try fileContent.write(to: fileURL, atomically: true, encoding: .utf8)
            print("File created successfully at path: \(fileURL.path)")
        } catch {
            print("Error while creating file: \(error)")
        }
    }
}


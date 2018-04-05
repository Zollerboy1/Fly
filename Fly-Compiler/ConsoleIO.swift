//
//  ConsoleIO.swift
//  Create October Pages
//
//  Created by Josef Zoller on 06.02.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation


class ConsoleIO {
    static func write(message: String, terminator: String = "\n", withType type: ConsoleIO.OutputType = .normal) {
        switch type {
        case .normal:
            print("\(message)", terminator: terminator)
        case .error:
            print("fly: \(message)", terminator: terminator)
            exit(1)
        }
    }
    
    static func printUsage() {
        self.write(message: "usage:", terminator: " ")
        self.write(message: "fly filename")
        self.write(message: "or:", terminator: " ")
        self.write(message: "fly -h to show usage information", terminator: "\n\n")
    }
    
    
    static func errorMissingFileName() {
        self.write(message: "Missing argument with filename", withType: .error)
    }
    
    static func errorNoSuchFile(_ fileName: String) {
        self.write(message: "\(fileName): No such file", withType: .error)
    }
    
    static func errorUnrecognizedCharacter(_ character: Character, atLine line: Int, column: Int) {
        self.write(message: "Unrecognized character '\(character)' at line \(line), column \(column)", withType: .error)
    }
    
    static func unexpectedError() {
        self.write(message: "An unexpected error uccured", withType: .error)
    }
    
    
    enum OutputType {
        case normal
        case error
    }
}

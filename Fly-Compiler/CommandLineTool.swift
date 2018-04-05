//
//  CommandLineTool.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 05.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

public final class CommandLineTool {
    private let arguments:[String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard self.arguments.count == 2 else { throw Error.missingFileName }
        
        let fileName = arguments[1]
        
        guard let input = try? String(contentsOf: URL(fileURLWithPath: fileName)) else { throw Error.failedToGetFileData(fileName: fileName) }
            
        let lexer = Lexer(input)
        let tokens = try lexer.tokenizeInput()
            
        for (index, token) in tokens.enumerated() {
            ConsoleIO.write(message: "\(index).: \(token)")
        }
    }
}

public extension CommandLineTool {
    enum Error: Swift.Error {
        case missingFileName
        case failedToGetFileData(fileName: String)
    }
}

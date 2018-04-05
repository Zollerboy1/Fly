//
//  main.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

let tool = CommandLineTool()

do {
    try tool.run()
    
} catch CommandLineTool.Error.missingFileName {
    ConsoleIO.printUsage()
    ConsoleIO.errorMissingFileName()
    
} catch let CommandLineTool.Error.failedToGetFileData(fileName) {
    ConsoleIO.errorNoSuchFile(fileName)
    
} catch let Lexer.Error.unrecognizedCharacter(character, line, column) {
    ConsoleIO.errorUnrecognizedCharacter(character, atLine: line, column: column)
    
} catch {
    ConsoleIO.unexpectedError()
}

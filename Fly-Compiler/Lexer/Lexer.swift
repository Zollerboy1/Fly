//
//  Lexer.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

class Lexer {
    let input:String
    var position = 0
    var line = 0
    var column = 0
    
    init(_ input: String) {
        self.input = input
    }
    
    func tokenizeInput() throws -> [LexerToken] {
        var tokens = [LexerToken]()
        
        ConsoleIO.write(message: "Tokenizing Input")
        
        var token = try self.nextToken()
            
        while token.type != LexerTokenType.endOfInput {
            tokens.append(token)
            token = try self.nextToken()
        }
            
        return tokens
    }
    
    var currentState:(Int, Int, Int) {
        return (self.position, self.line, self.column)
    }
    
    func updateState(_ lineOffset: Int, _ columnOffset:Int, _ positionOffset: Int) {
        self.line += lineOffset
        self.column = columnOffset < 0 ? 0 : self.column + columnOffset
        self.position += positionOffset
    }
    
    var lookAhead:Character? {
        if (self.input.count - self.position) >= 2 {
            return self.input[self.position + 1]
        } else {
            return nil
        }
    }
    
    var lookTwoAhead:Character? {
        if (self.input.count - self.position) >= 3 {
            return self.input[self.position + 2]
        } else {
            return nil
        }
    }
    
    var nextCharacter:Character {
        return self.input[self.position]
    }
    
    func ignoreSpaces() -> Character {
        var character = self.nextCharacter
        while character == " " || character == "\t" {
            self.updateState(0, 1, 1)
            character = self.nextCharacter
        }
        return character
    }
    
    
    func recognizeNewLine() -> LexerToken {
        let (_, line, column) = self.currentState
        self.updateState(1, -1, 1)
        return LexerToken(type: LexerTokenType(delimiterType: .newline), value: "\n", line: line, column: column)
    }
    
    func recognizeIdentifier() -> LexerToken {
        let (_, line, column) = self.currentState
        var value = ""
        var character = self.input[position + value.count]
        
        while character.isValidInIdentifier || character.isDigit {
            value.append(character)
            if self.input.count > (position + value.count) {
                character = self.input[position + value.count]
            } else {
                break
            }
        }
        
        self.updateState(0, value.count, value.count)
        
        if let type = LexerKeywordTokenType(rawValue: value) {
            return LexerToken(type: LexerTokenType(keywordType: type), value: value, line: line, column: column)
        } else {
            return LexerToken(type: LexerTokenType(.identifier), value: value, line: line, column: column)
        }
    }
    
    func recognizeString() -> LexerToken {
        let (position, line, column) = self.currentState
        let fsm = FSM.string
        let (_, value, _) = fsm.run(String(self.input.suffix(from: position)))
        self.updateState(0, value.count, value.count)
        return LexerToken(type: .string, value: value, line: line, column: column)
    }
    
    func recognizeNumber() -> LexerToken? {
        let (position, line, column) = self.currentState
        let fsm = FSM.number
        let (recognized, value, state) = fsm.run(String(self.input.suffix(from: position)))
        
        self.updateState(0, value.count, value.count)
        
        if recognized {
            return LexerToken(type: state == FSM.NumberStates.integer ? .integer : .decimal, value: value, line: line, column: column)
        } else {
            return nil
        }
    }
    
    func nextToken() throws -> LexerToken {
        if self.position >= self.input.count {
            return LexerToken(type: .endOfInput, value: "", line: self.line, column: self.column)
        }
        
        let character = self.ignoreSpaces()
        
        if character.isValidInIdentifier {
            return self.recognizeIdentifier()
        }
        
        if character.isDigit {
            if let token = self.recognizeNumber() {
                return token
            }
        }
        
        if character == "\"" {
            return self.recognizeString()
        }
        
        if character.isNewline {
            return self.recognizeNewLine()
        }
        
        if let lookTwoAhead = self.lookTwoAhead, let type = LexerOperatorTokenType(rawValue: "\(character + self.lookAhead!)\(lookTwoAhead)") {
            let token = LexerToken(type: LexerTokenType(operatorType: type), value: "\(character + self.lookAhead!)\(lookTwoAhead)", line: self.line, column: self.column)
            self.updateState(0, 3, 3)
            return token
        }
        
        if let lookAhead = self.lookAhead, let type = LexerOperatorTokenType(rawValue: character + lookAhead) {
            let token = LexerToken(type: LexerTokenType(operatorType: type), value: character + lookAhead, line: self.line, column: self.column)
            self.updateState(0, 2, 2)
            return token
        }
        
        if let type = LexerOperatorTokenType(rawValue: "\(character)") {
            let token = LexerToken(type: LexerTokenType(operatorType: type), value: "\(character)", line: self.line, column: self.column)
            self.updateState(0, 1, 1)
            return token
        }
        
        if let type = LexerDelimiterTokenType(rawValue: "\(character)") {
            let token = LexerToken(type: LexerTokenType(delimiterType: type), value: "\(character)", line: self.line, column: self.column)
            self.updateState(0, 1, 1)
            return token
        }
        
        throw Lexer.Error.unrecognizedCharacter(character: character, line: self.line, column: self.column)
    }
}

extension Lexer {
    enum Error: Swift.Error {
        case unrecognizedCharacter(character: Character, line: Int, column: Int)
    }
}


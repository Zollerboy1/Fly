//
//  LexerToken.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

enum LexerBaseTokenType {
    case `operator`(LexerOperatorTokenType)
    case delimiter(LexerDelimiterTokenType)
    case keyword(LexerKeywordTokenType)
    case identifier, integer, decimal, string, endOfInput, unrecognized
}

extension LexerBaseTokenType: Equatable {
    static func ==(lhs: LexerBaseTokenType, rhs: LexerBaseTokenType) -> Bool {
        switch (lhs, rhs) {
        case let (.operator(lhsType), .operator(rhsType)):
            return lhsType == rhsType
        case let (.delimiter(lhsType), .delimiter(rhsType)):
            return lhsType == rhsType
        case let (.keyword(lhsType), .keyword(rhsType)):
            return lhsType == rhsType
        case (.identifier, .identifier):
            return true
        case (.integer, .integer):
            return true
        case (.decimal, .decimal):
            return true
        case (.string, .string):
            return true
        case (.endOfInput, .endOfInput):
            return true
        case (.unrecognized, .unrecognized):
            return true
        default:
            return false
        }
    }
}

enum LexerOperatorTokenType:String {
    //Dispatch operators
    case dot = "."
    
    //Assignment operators
    case assign = "="
    case divAssign = "/="
    case minusAssign = "-="
    case moduloAssign = "%="
    case plusAssign = "+="
    case timesAssign = "*="
    
    //Arithmetic operators
    case div = "/"
    case minus = "-"
    case modulo = "%"
    case plus = "+"
    case times = "*"
    
    //Comparison operators
    case equal = "=="
    case greater = ">"
    case greaterOrEqual = ">="
    case lower = "<"
    case lowerOrEqual = "<="
    case notEqual = "!="
    
    //Boolean operators
    case and = "&&"
    case not = "!"
    case or = "||"
    
    //Range operators
    case closedRange = "..."
    case halfOpenRange = "..<"
    
    //Optional operators
    case forceUnwrap = "^"
    case optional = "?"
    
    // //For future use:
    // //Other operators
    // static var tilde:TokenType              { return TokenType("~") }
    // static var tildeEqual:TokenType         { return TokenType("~=") }
    // static var dollar:TokenType             { return TokenType("$") }
    // static var dollarEqual:TokenType        { return TokenType("$=") }
}

extension LexerOperatorTokenType {
    var description:String {
        return "\(self)"
    }
}

enum LexerDelimiterTokenType:String {
    case at = "@"
    case colon = ":"
    case comma = ","
    case leftCurlyBracket = "{"
    case leftParenthesis = "("
    case leftSquareBracket = "["
    case newline = "\n"
    case rightCurlyBracket = "}"
    case rightParenthesis = ")"
    case rightSquareBracket = "]"
}

extension LexerDelimiterTokenType {
    var description:String {
        return "\(self)"
    }
}

enum LexerKeywordTokenType:String {
    //Declaration keywords
    // case abstractKeyword = "abstract"
    case binaryKeyword = "binary"
    case classKeyword = "class"
    case compoundKeyword = "compound"
    case failableKeyword = "failable"
    // case finalKeyword = "final"
    case funcKeyword = "func"
    case initKeyword = "init"
    // case lazyKeyword = "lazy"
    case letKeyword = "let"
    case newKeyword = "new"
    case overrideKeyword = "override"
    case privateKeyword = "private"
    case unaryKeyword = "unary"
    case underscoreKeyword = "_"
    case varKeyword = "var"
    
    //Statement keywords
    case breakKeyword = "break"
    case caseKeyword = "case"
    case continueKeyword = "continue"
    case elifKeyword = "elif"
    case elseKeyword = "else"
    case forKeyword = "for"
    case ifKeyword = "if"
    case inKeyword = "in"
    case returnKeyword = "return"
    case switchKeyword = "switch"
    case whileKeyword = "while"
    
    //Expression keywords
    case asKeyword = "as"
    case falseKeyword = "false"
    case isKeyword = "is"
    case nilKeyword = "nil"
    case selfKeyword = "self"
    case superKeyword = "super"
    case trueKeyword = "true"
}

extension LexerKeywordTokenType {
    var description:String {
        let description = "\(self)"
        return String(description.dropLast(7))
    }
}

struct LexerTokenType {
    
    let baseType:LexerBaseTokenType
    
    init(_ baseType: LexerBaseTokenType) {
        self.baseType = baseType
    }
    
    init(operatorType: LexerOperatorTokenType) {
        self.baseType = .operator(operatorType)
    }
    
    init(delimiterType: LexerDelimiterTokenType) {
        self.baseType = .delimiter(delimiterType)
    }
    
    init(keywordType: LexerKeywordTokenType) {
        self.baseType = .keyword(keywordType)
    }
    
    
//Identifiers and literals
    static var identifier:LexerTokenType         { return LexerTokenType(.identifier) }
    static var integer:LexerTokenType            { return LexerTokenType(.integer) }
    static var decimal:LexerTokenType            { return LexerTokenType(.decimal) }
    static var string:LexerTokenType             { return LexerTokenType(.string) }
    
    
//special tokens
    static var endOfInput:LexerTokenType         { return LexerTokenType(.endOfInput) }
    static var unrecognized:LexerTokenType       { return LexerTokenType(.unrecognized) }
    
}

extension LexerTokenType: CustomStringConvertible {
    var description:String {
        switch self.baseType {
        case let .operator(type):
            return "operator_\(type.description)"
        case let .delimiter(type):
            return "delimiter_\(type.description)"
        case let .keyword(type):
            return "keyword_\(type.description)"
        case .identifier:
            return "identifier"
        case .integer:
            return "integer"
        case .decimal:
            return "decimal"
        case .string:
            return "string"
        case .endOfInput:
            return "endOfInput"
        case .unrecognized:
            return "unrecognized"
        }
    }
}

extension LexerTokenType: Equatable {
    static func ==(lhs: LexerTokenType, rhs: LexerTokenType) -> Bool {
        return lhs.baseType == rhs.baseType
    }
}


struct LexerToken: CustomStringConvertible {
    let type:LexerTokenType
    let value:String
    let line:Int
    let column:Int
    
    var description: String {
        let value = self.value == "\n" ? "<newline>" : self.value
        return "<\(self.type), \(value), \(self.line):\(self.column)>"
    }
}

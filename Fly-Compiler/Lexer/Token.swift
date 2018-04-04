//
//  Token.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

enum TokenType: String {
    case string, number, identifier // ...
}

struct Token {
    let type:TokenType
    let value:String
    let line:Int
    let column:Int
}

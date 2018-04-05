//
//  Character+Extension.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

extension Character {
    var unicodeScalar:UnicodeScalar {
        let scalars = self.unicodeScalars
        return scalars[scalars.startIndex]
    }
    
    var lowercased:Character {
        return String(self).lowercased().first!
    }
    
    var uppercased:Character {
        return String(self).uppercased().first!
    }
    
    var isLetter:Bool {
        return CharacterSet.uppercaseLetters.contains(self.unicodeScalar) || CharacterSet.lowercaseLetters.contains(self.unicodeScalar)
    }
    
    var isDigit:Bool {
        return CharacterSet.arabicNumbers.contains(self.unicodeScalar)
    }
    
    var isValidInIdentifier:Bool {
        return self.isLetter || self.isUnderscore
    }
    
    var isNewline:Bool {
        return self == "\n"
    }
    var isUnderscore:Bool {
        return self == "_"
    }
    
    static func +(lhs: Character, rhs: Character) -> String {
        return "\(lhs)\(rhs)"
    }
}

extension CharacterSet {
    static var uppercaseLetters:CharacterSet {
        return CharacterSet(charactersIn: "A"..."Z")
    }
    
    static var lowercaseLetters:CharacterSet {
        return CharacterSet(charactersIn: "a"..."z")
    }
    
    static var arabicNumbers:CharacterSet {
        return CharacterSet(charactersIn: "0"..."9")
    }
}

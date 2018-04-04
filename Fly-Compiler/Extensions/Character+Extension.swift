//
//  Character+Extension.swift
//  Fly
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

enum CharacterType {
    case letter, digit, other // ...
}

extension Character {
    var unicodeScalar:UnicodeScalar {
        let scalars = self.unicodeScalars
        return scalars[scalars.startIndex]
    }
    
    var type:CharacterType {
        let scalar = self.unicodeScalar
        if CharacterSet.letters.contains(scalar) {
            return .letter
        } else if CharacterSet.decimalDigits.contains(scalar) {
            return .digit
        }
        
        return .other
    }
}

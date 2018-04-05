//
//  String+Extension.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

extension String {
    func suffix(from i: Int) -> Substring {
        let start = self.index(self.startIndex, offsetBy: i)
        return self.suffix(from: start)
    }
    
    subscript(i: Int) -> Character {
        return self[index(self.startIndex, offsetBy: i)]
    }
    
    subscript(bounds: CountableRange<Int>) -> Substring {
        let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        return self[start..<end]
    }
    
    subscript(bounds: CountableClosedRange<Int>) -> Substring {
        let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        return self[start...end]
    }
    
    subscript(bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = self.index(endIndex, offsetBy: -1)
        return self[start...end]
    }
    
    subscript(bounds: PartialRangeThrough<Int>) -> Substring {
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        return self[self.startIndex...end]
    }
    
    subscript(bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        return self[self.startIndex..<end]
    }
}

extension Substring {
    subscript(i: Int) -> Character {
        return self[index(self.startIndex, offsetBy: i)]
    }
    
    subscript(bounds: CountableRange<Int>) -> Substring {
        let start = index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = index(self.startIndex, offsetBy: bounds.upperBound)
        return self[start..<end]
    }
    
    subscript(bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = index(self.startIndex, offsetBy: bounds.upperBound)
        return self[start...end]
    }
    
    subscript(bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start...end]
    }
    
    subscript(bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(self.startIndex, offsetBy: bounds.upperBound)
        return self[self.startIndex...end]
    }
    
    subscript(bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(self.startIndex, offsetBy: bounds.upperBound)
        return self[self.startIndex..<end]
    }
}

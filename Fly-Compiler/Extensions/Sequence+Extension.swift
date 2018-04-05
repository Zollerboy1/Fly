//
//  Sequence+Extension.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

extension Sequence {
    
    /// Calls the given closure on each element in the enumerated sequence in the same order as a for-in loop until a closure returnes false.
    ///
    /// If a closure returnes false, the loop breaks and false is returned
    /// - Parameter body: A closure that takes the current loop index and the current element of the sequence as a parameter.
    /// - Parameter index: The index of the current looped element.
    /// - Parameter element: The current element in the loop.
    /// - Returns: False if the loop was broken because at minimum one closure returned false, true if the loop ended properly.
    @discardableResult func forAll(body: (_ index: Int, _ element: Element) -> Bool) -> Bool {
        for (index, element) in self.enumerated() {
            let shouldContinue = body(index, element)
            if !shouldContinue {
                return false
            }
        }
        return true
    }
}

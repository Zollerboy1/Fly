//
//  FSM.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

struct FSM {
    let states:Set<Int>
    let initialState:Int
    let acceptingStates:Set<Int>
    let nextState:((Int, Character) -> Int?)
    
    func run(_ input: String) -> Bool {
        var currentState = self.initialState
        
        loop: for character in input {
            if let nextState = self.nextState(currentState, character) {
                if self.acceptingStates.contains(nextState) {
                    return true
                }
                currentState = nextState
            } else {
                break loop
            }
        }
        return self.acceptingStates.contains(currentState)
    }
}

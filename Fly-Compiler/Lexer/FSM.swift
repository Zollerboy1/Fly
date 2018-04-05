//
//  FSM.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 04.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

struct FSM {
    struct NumberStates {
        static let initial = 1
        static let integer = 2
        static let beginNumberWithFractionalPart = 3
        static let numberWithFractionalPart = 4
        static let beginNumberWithExponent = 5
        static let beginNumberWithSignedExponent = 6
        static let numberWithExponent = 7
        static let noNextState = 0
    }
    
    struct StringStates {
        static let initial = 1
        static let string = 2
        static let escaped = 3
        static let closing = 4
        static let noNextState = 0
    }
    
    
    let states:Set<Int>
    let initialState:Int
    let acceptingStates:Set<Int>
    let noNextState:Int
    let nextState:((Int, Character, Character?) -> Int)
    
    ///Get a FSM for recognizing a number
    static var number:FSM {
        let fsmStates:Set = [
            NumberStates.initial,
            NumberStates.integer,
            NumberStates.beginNumberWithFractionalPart,
            NumberStates.beginNumberWithFractionalPart,
            NumberStates.beginNumberWithExponent,
            NumberStates.beginNumberWithSignedExponent,
            NumberStates.numberWithExponent,
            NumberStates.noNextState
        ]
        
        let fsmInitialState = NumberStates.initial
        
        let fsmAcceptingStates:Set = [
            NumberStates.integer,
            NumberStates.numberWithFractionalPart,
            NumberStates.numberWithExponent
        ]
        
        let fsmNoNextState = NumberStates.noNextState
        
        return FSM(states: fsmStates, initialState: fsmInitialState, acceptingStates: fsmAcceptingStates, noNextState: fsmNoNextState) { (currentState, character, nextCharacter) -> Int in
            switch currentState {
            case NumberStates.initial:
                if character.isDigit {
                    return NumberStates.integer
                }
                
            case NumberStates.integer:
                if character.isDigit {
                    return NumberStates.integer
                }
                
                if character == "." {
                    if let nextCharacter = nextCharacter, nextCharacter == "." {
                        return NumberStates.noNextState
                    }
                    
                    return NumberStates.beginNumberWithFractionalPart
                }
                
                if character.lowercased == "e" {
                    return NumberStates.beginNumberWithExponent
                }
                
            case NumberStates.beginNumberWithFractionalPart:
                if character.isDigit {
                    return NumberStates.numberWithFractionalPart
                }
                
            case NumberStates.numberWithFractionalPart:
                if character.isDigit {
                    return NumberStates.numberWithFractionalPart
                }
                
                if character.lowercased == "e" {
                    return NumberStates.beginNumberWithExponent
                }
                
            case NumberStates.beginNumberWithExponent:
                if character == "+" || character == "-" {
                    return NumberStates.beginNumberWithSignedExponent
                }
                
                if character.isDigit {
                    return NumberStates.numberWithExponent
                }
                
            case NumberStates.beginNumberWithSignedExponent:
                if character.isDigit {
                    return NumberStates.numberWithExponent
                }
                
            case NumberStates.numberWithExponent:
                if character.isDigit {
                    return NumberStates.numberWithExponent
                }
                
            default:
                break
            }
            
            return NumberStates.noNextState
        }
    }
    
    ///Get a FSM for recognizing a string
    static var string:FSM {
        let fsmStates:Set = [
            StringStates.initial,
            StringStates.string,
            StringStates.escaped,
            StringStates.closing,
            StringStates.noNextState
        ]
        
        let fsmInitialState = StringStates.initial
        
        let fsmAcceptingStates:Set = [
            StringStates.string
        ]
        
        let fsmNoNextState = StringStates.noNextState
        
        return FSM(states: fsmStates, initialState: fsmInitialState, acceptingStates: fsmAcceptingStates, noNextState: fsmNoNextState) { (currentState, character, _) -> Int in
            switch currentState {
            case StringStates.initial:
                if character == "\"" {
                    return StringStates.string
                }
                
            case StringStates.string:
                if character == "\\" {
                    return StringStates.escaped
                }
                
                if character == "\"" {
                    return StringStates.closing
                }
                
                return StringStates.string
                
            case StringStates.escaped:
                return StringStates.string
                
            case StringStates.closing:
                break
                
            default:
                break
            }
            
            return StringStates.noNextState
        }
    }
    
    
    /// Run the FSM with an input.
    ///
    /// - Parameter input: A String which should be recognized
    /// - Returns: A tuple of
    ///     * a Bool, which indicates, if the accepting states of the FSM contain the last state
    ///     * a String, containing the recognized region
    ///     * an Int, which represents the last state
    func run(_ input: String) -> (Bool, String, Int) {
        var currentState = self.initialState
        var length = 0
        
        input.forAll { (index, character) -> Bool in
            let nextState:Int
            if (input.count - index) >= 2 {
                nextState = self.nextState(currentState, character, input[index + 1])
            } else {
                nextState = self.nextState(currentState, character, nil)
            }
            
            guard nextState != self.noNextState else { return false }
            
            currentState = nextState
            length = index
            return true
        }
        
        return (self.acceptingStates.contains(currentState), String(input.prefix(length + 1)), currentState)
    }
}

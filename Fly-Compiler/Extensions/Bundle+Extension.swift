//
//  Bundle+Extension.swift
//  Fly-Compiler
//
//  Created by Josef Zoller on 05.04.18.
//  Copyright © 2018 Josef Zoller. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}

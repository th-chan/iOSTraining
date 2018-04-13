//
//  Configurable.swift
//  SearchBookApp
//
//  Created by Chan, Tsz Hin on 13/4/2018.
//  Copyright © 2018 temp. All rights reserved.
//

import Foundation

class Configurable {
    func getDomain() -> String {
        return Bundle.main.infoDictionary!["Domain"] as! String
    }
}

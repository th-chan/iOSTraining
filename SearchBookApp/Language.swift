//
//  Language.swift
//  SearchBookApp
//
//  Created by Chan, Tsz Hin on 12/4/2018.
//  Copyright © 2018 temp. All rights reserved.
//

import UIKit

extension UIViewController {
    func getString(_ param: String) -> String {
        return Bundle.main.localizedString(forKey: param, value: nil, table: nil)
    }
}

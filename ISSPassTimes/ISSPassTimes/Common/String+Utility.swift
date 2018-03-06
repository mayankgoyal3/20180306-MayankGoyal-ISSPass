//
//  String+Utility.swift
//  ISSPassTimes
//
//  Created by Mayank Goyal on 06/03/18.
//  Copyright © 2018 Mayank Goyal. All rights reserved.
//

import UIKit

public extension String {
    public func localize(_ comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? self)
    }
}


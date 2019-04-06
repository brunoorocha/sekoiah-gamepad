//
//  CategoryMask.swift
//  Book_Sources
//
//  Created by Bruno Rocha on 19/03/19.
//

import Foundation

struct CategoryMask {
    static let none: UInt32 = 0
    static let character: UInt32 = 0x1 << 0
    static let coin: UInt32 = 0x1 << 1
    static let platform: UInt32 = 0x1 << 2
}

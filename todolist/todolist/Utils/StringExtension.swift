//
//  StringExtension.swift
//  todolist
//
//  Created by t2023-m0047 on 2024/01/11.
//

import Foundation
import UIKit
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

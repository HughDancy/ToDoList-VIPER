//
//  String + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 26.01.2024.
//

import Foundation

extension String {
   func isValidEmail() -> Bool {
    // swiftlint:disable:next line_length 
    let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }

    func changeWordEnding() -> String {
        guard let endChar = self.last else { return "" }

        var newString = self

        if endChar == "я" && newString.count > 3 {
            newString.removeLast()
            newString += "ь"
        } else if newString.count == 3 {
            newString.removeLast()
            newString += "й"
        } else {
            newString.removeLast()
        }

        return newString
    }
}

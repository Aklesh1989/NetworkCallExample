//
//  Extension.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 16/11/21.
//

import Foundation
import UIKit

public extension NSObject
{
    class var nameOfClass: String
    {
        let componentsList = NSStringFromClass(self).split(separator: ".").map(String.init)
        return componentsList.last!
    }
}

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}

extension UIColor {
    static let themeColor = #colorLiteral(red: 0.09019607843, green: 0.2745098039, blue: 0.4509803922, alpha: 1) //#174673 alpha: 1.0
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

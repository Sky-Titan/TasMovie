//
//  String+.swift
//  TasUtility
//
//  Created by 박준현 on 2021/11/29.
//

import UIKit

extension String {
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }

    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    public func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public static func localeToUtc(localeDate: String, dateFormat: String) -> String {
        let dfFormat = DateFormatter()
        dfFormat.dateFormat = dateFormat
        dfFormat.timeZone = TimeZone.current
        let dtLocaleDate = dfFormat.date(from: localeDate)
            
        dfFormat.timeZone = TimeZone(abbreviation: "UTC")
        dfFormat.dateFormat = dateFormat
        return dfFormat.string(from: dtLocaleDate!)
    }
}

//
//  ConfigManager.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit

class ConfigManager {
    static let shared =  ConfigManager()
    
    var currentLanguage: SupportLanguage {
        guard let code = Locale.current.languageCode else { return .en }
        return SupportLanguage(rawValue: code) ?? .en
    }
    
    var currentTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = dateFormat
        return formatter.string(from: Date())
    }
    let dateFormat = "yyyy-MM-dd HH:mm:ss UTC"
}

enum SupportLanguage: String {
    case en
    case ko
}

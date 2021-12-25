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
    
}

enum SupportLanguage: String {
    case en
    case ko
}

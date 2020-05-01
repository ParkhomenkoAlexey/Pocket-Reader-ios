//
//  UserSettings.swift
//  Pocket Reader
//
//  Created by Алексей Пархоменко on 01.05.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit


final class UserSettings {
    
    private enum SettingsKey: String {
        case userBooks
    }
    
    static var userBooks: [BookItem] {
        get {
            guard let savedBooks = UserDefaults.standard.object(forKey: SettingsKey.userBooks.rawValue) as? Data, let decodedBooks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedBooks) as? [BookItem] else { return [] }
            return decodedBooks
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.userBooks.rawValue
            
            if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) {
                print("value: \(newValue) wa added to key \(key)")
                defaults.set(savedData, forKey: key)
            }
            
            
        }
    }
}

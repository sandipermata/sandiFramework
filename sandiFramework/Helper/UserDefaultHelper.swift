//
//  UserDefaultHelper.swift
//  SpeedTest_sji
//
//  Created by Sandi Permata on 23.04.20.
//  Copyright © 2020 sample. All rights reserved.
//

import Foundation

public enum UserDefaultKeys: String, CaseIterable {
    case status
    case login
    case logout
    case provider
    case upload
    case download
    case ping
    case jitter
    case km
}

/// UserDefaultsHelper.setData(value: "user-001", key: .userId)
/// let id = UserDefaultsHelper.getData(type: String.self, forKey: .userId)

public final class UserDefaultsHelper {
    
    public static func setData<T>(value: T, key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    
    public static func getData<T>(type: T.Type, forKey: UserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    
    public static func removeData(key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}

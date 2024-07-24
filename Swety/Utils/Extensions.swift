//
//  Extensions.swift
//  Swety
//
//  Created by Matheus Jorge on 7/17/24.
//

import SwiftUI

// ===== View =====

enum CornerRadius: CGFloat {
    case small = 8
    case medium = 16
    case large = 24
}

enum ShadowRadius: CGFloat {
    case small = 5
    case medium = 8
    case large = 10
}

extension View {
    func cornerRadius(_ radius: CornerRadius) -> some View {
        self.cornerRadius(radius.rawValue)
    }

    func shadow(radius: ShadowRadius) -> some View {
        self.shadow(radius: radius.rawValue)
    }
}

// ===== UserDefaults =====

enum UserDefaultsKeys: String {
    case userId
    case userAccessToken
    case userRefreshToken
    case defaultExercises
    case defaultExercisesLastFetch
}

extension UserDefaults {
    func set(_ value: Any?, forKey key: UserDefaultsKeys) {
        set(value, forKey: key.rawValue)
    }
    
    func data(forKey key: UserDefaultsKeys) -> Data? {
        return data(forKey: key.rawValue)
    }
    
    func string(forKey key: UserDefaultsKeys) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func object(forKey key: UserDefaultsKeys) -> Any? {
        return object(forKey: key.rawValue)
    }
    
    func removeObject(forKey key: UserDefaultsKeys) {
        removeObject(forKey: key.rawValue)
    }
    
    func setCodable<T: Codable>(_ value: T, forKey key: UserDefaultsKeys) {
        if let data = try? JSONEncoder().encode(value) {
            self.set(data, forKey: key)
            print("Successfully saved data for key: \(key)")
        } else {
            print("Failed to encode and save data for key: \(key)")
        }
    }
    
    func codable<T: Codable>(forKey key: UserDefaultsKeys) -> T? {
        if let data = self.data(forKey: key) {
            if let value = try? JSONDecoder().decode(T.self, from: data) {
                print("Successfully decoded data for key: \(key)")
                return value
            } else {
                print("Failed to decode data for key: \(key)")
            }
        } else {
            print("No data found for key: \(key)")
        }
        return nil
    }
}

// ===== Environment =====

struct DismissAllKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var dismissAll: () -> Void {
        get { self[DismissAllKey.self] }
        set { self[DismissAllKey.self] = newValue }
    }
}

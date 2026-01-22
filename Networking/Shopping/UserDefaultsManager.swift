//
//  UserDefaultsManager.swift
//  Networking
//
//  Created by 전민돌 on 1/22/26.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let value: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: self.key) as? T ?? self.value }
        set { UserDefaults.standard.set(newValue, forKey: self.key) }
    }
}

class UserDefaultsManager {
    @UserDefault(key: "searchKeywords", value: [])
    static var searchKeywords: [String]
    
    static func appendKeyword(_ keyword: String) {
        var keywords = UserDefaults.standard.stringArray(forKey: "searchKeywords") ?? []
        
        keywords.append(keyword)
        UserDefaults.standard.set(keywords, forKey: "searchKeywords")
    }
}

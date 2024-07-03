//
//  AuthKeychainManager.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 08.06.2024.
//

import Foundation
import Security

enum KeychainError: Error {
    case idNotFound
    case statusNotSuccess(OSStatus)
    case idDataInvalid
    case parsingFailed(String?)
}

protocol AuthKeychainManagerProtocol {
    var id: String? { get }
    var isAuth: Bool { get }
    
    func persist(id: String)
    func clear()
    
    func fetchId() throws -> String
}

final class AuthKeychainManager {
    private let secureItemDescription = "Auth id"
    
    private var accountName: String = "ToDoList-VIPER"
    private var serviceName: String = "-.ToDoList-VIPER"
    
    private var cachedId: String?

    private lazy var searchQuery = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: serviceName,
        kSecAttrAccount: accountName,
        kSecMatchLimit: kSecMatchLimitOne,
        kSecReturnData: true,
        kSecReturnAttributes: true
    ] as CFDictionary

    private lazy var basicSearchQuery = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: serviceName,
        kSecAttrAccount: accountName
    ] as CFDictionary
}

extension AuthKeychainManager: AuthKeychainManagerProtocol {
    var isAuth: Bool {
        id != nil
    }

    var id: String? {
        guard cachedId == nil else { return cachedId }
        cachedId = try? fetchId()
        return cachedId
    }

    func fetchId() throws -> String {
        var item: CFTypeRef?

        let status = SecItemCopyMatching(searchQuery, &item)

        if status == errSecItemNotFound {
            throw KeychainError.idNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.statusNotSuccess(status)
        }

        guard let dictionary = item as? [CFString: Any],
              let data = dictionary[kSecValueData] as? Data else {
            throw KeychainError.idDataInvalid
        }

        guard let id = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? String else {
            throw KeychainError.parsingFailed(String(data: data, encoding: .utf8))
        }

        print("Your id - \(id) was loaded, welcome!")

        return id
    }

    func persist(id: String) {
        guard let data = try? NSKeyedArchiver.archivedData(
            withRootObject: id,
            requiringSecureCoding: true
        ) else { return }

        let attributes = [
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecAttrDescription: secureItemDescription
        ] as CFDictionary

        var status = SecItemUpdate(basicSearchQuery, attributes)

        if status == errSecItemNotFound {
            let attributes = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
                kSecAttrService: serviceName,
                kSecAttrAccount: accountName,
                kSecValueData: data,
                kSecAttrDescription: secureItemDescription
            ] as CFDictionary

            status = SecItemAdd(attributes, nil)
        }

        if status == errSecSuccess {
            cachedId = id
        }
//        UserDefaults.standard.setValue(OnboardingStatesService.UserDefaultsValues.inputName.rawValue, forKey: "test")
        print("Your id - \(id) was saved!")
    }

    func clear() {
        cachedId = nil
        let status = SecItemDelete(basicSearchQuery)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return print("Somehow failed to clear Auth token")
        }
    }
}

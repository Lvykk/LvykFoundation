//
//  CacheManager.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import Foundation
import Cache

private let LibraryPath = NSHomeDirectory() + "/Library"

public class CacheManager {
    static let manager = CacheManager()

    var storageName: String = "GeneralPurpose"
    var directoryPath: String = LibraryPath

    // MARK: - General cache save

    static func setCodableObj<T: Codable>(key: String, value: T, expiry: Expiry?) throws {
        try CacheManager.manager.storage()?.setObject(JSONEncoder().encode(value), forKey: key, expiry: expiry)
    }

    static func getCodableObj<T: Codable>(key: String) throws -> T? {
        guard let data: Data = try CacheManager.manager.storage()?.object(forKey: key) else { return nil }

        switch data {
        case is T:
            return data as? T
        default:
            return try JSONDecoder().decode(T.self, from: data)
        }
    }

    /// Get the cache object
    func storage<Key: Hashable, T: Codable>() -> Storage<Key, T>? {
        storage(storageName: storageName, directoryPath: directoryPath)
    }

    func storage<Key: Hashable, T: Codable>(storageName: String, directoryPath: String? = nil) -> Storage<Key, T>? {
        CacheManager.storage(name: storageName, directoryPath: directoryPath)
    }

    static func storage<Key: Hashable, T: Codable>(name: String, directoryPath: String? = nil) -> Storage<Key, T>? {
        let diskConfig = DiskConfig(name: name, directory: URL(string: directoryPath ?? LibraryPath))

        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 0)

        let storage = try? Storage<Key, T>(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: T.self))

        return storage
    }
}

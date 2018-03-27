//
//  SettingsManager.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 27.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation

public class SettingsManager {
    public let settingsFolder: URL
    
    public init() {
        settingsFolder = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".ProEssentials", isDirectory: true)
            .appendingPathComponent("settings", isDirectory: true)
    }
    
    public func load<T:Setting>(type: T.Type) throws -> T? {
        let path = settingsFolder
            .appendingPathComponent((T.init() as T).filename)
        
        let json = try? String(contentsOf: path, encoding: .utf8)
        if json == nil {
            return nil // TODO: throw instead
        }
        
        let object: T? = try? JSONDecoder().decode(T.self, from: json!.data(using: .utf8)!)
        if object == nil {
            return nil// TODO: throw instead
        }
        
        return object!;
    }
    
    public func loadOrFallback<T:Setting>(type: T.Type) -> T {
        var setting: T?
        
        do {
            setting = try load(type: type);
            if (setting == nil) {
                setting = T.init()
            }
        }
        catch
        {
            setting = T.init()
        }

        return setting!;
    }
    
    public func save<T:Setting>(setting: T) throws -> Void {
        let path = settingsFolder
            .appendingPathComponent((T.init() as T).filename)
        
        let json = try? JSONEncoder().encode(setting);
        if json == nil {
            return; // TODO: throw instead
        }
        
        try json!.write(to: path)
    }
    
}

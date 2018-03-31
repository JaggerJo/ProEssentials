//
//  Setting.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 27.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation

public protocol Setting : Codable {
    var filename: String { get }
    
    init()
}

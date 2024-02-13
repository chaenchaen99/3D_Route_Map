//
//  Item.swift
//  3D-public-transportation
//
//  Created by 정채연 on 2/13/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

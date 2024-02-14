//
//  Item.swift
//  3d-public-transportation
//
//  Created by 정채연 on 2/15/24.
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

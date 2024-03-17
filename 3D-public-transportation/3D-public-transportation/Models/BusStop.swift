//
//  BusStop.swift
//  3d-public-transportation
//
//  Created by 정채연 on 3/13/24.
//

import Foundation

// MARK: - Welcome
struct BusStop: Codable {
    let response: BusStopResponse
}

// MARK: - Response
struct BusStopResponse: Codable {
    let header: Header
    let body: BusStopBody
}

// MARK: - Body
struct BusStopBody: Codable {
    let items: BusStopItems
    let numOfRows, pageNo, totalCount: Int
}

struct BusStopItems: Codable
{
    let item: [BusStopItem]
}


// MARK: - Item
struct BusStopItem: Codable {
    let citycode: Int
    let gpslati, gpslong: Double
    let nodeid, nodenm: String
    let nodeno: Int
}

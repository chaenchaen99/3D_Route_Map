//
//  BusLists.swift
//  3d-public-transportation
//
//  Created by 정채연 on 3/13/24.
//


import Foundation

// MARK: - BusLists
struct BusLists: Codable {
    let response: BusListsResponse
}

// MARK: - Response
struct BusListsResponse: Codable {
    let header: Header
    let body: BusListsBody
}

// MARK: - Body
struct BusListsBody: Codable {
    let items: BusItems
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct BusItems: Codable {
    let item: [BusItem]
}

// MARK: - Item
struct BusItem: Codable {
    let arrprevstationcnt, arrtime: Int
    let nodeid, nodenm, routeid: String
    let routeno: Int
    let routetp, vehicletp: String
}

// MARK: - Header
struct Header: Codable {
    let resultCode, resultMsg: String
}


enum Nodeid: String, Codable {
    case ggb206000535 = "GGB206000535"
}

enum Nodenm: String, Codable {
    case 판교역낙생육교현대백화점 = "판교역.낙생육교.현대백화점"
}

enum Routeno: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Routeno.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Routeno"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Routetp: String, Codable {
    case 일반버스 = "일반버스"
    case 직행좌석버스 = "직행좌석버스"
}

enum Vehicletp: String, Codable {
    case 일반차량 = "일반차량"
    case 저상버스 = "저상버스"
}

//
//  Business.swift
//  YelpAPI
//
//  Created by Andrew Acton on 2/9/23.
//

import Foundation

struct YelpData: Decodable {
    var businesses: [Business]
//    var total: Int
}

struct Business: Decodable {
    var id: String
    var alias: String
    var name: String
    var imageURL: String
    var isClosed: Bool
    var url: String
    var reviewCount: Int
    var categories: [Categories]
    var rating: Double
    var coordinates: Coordinates
    var transactions: [String]
    var price: String?
    var location: Location
    var phone: String
    var dispalyPhone: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case alias = "alias"
        case name = "name"
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url = "url"
        case reviewCount = "review_count"
        case categories = "categories"
        case rating = "rating"
        case coordinates = "coordinates"
        case transactions = "transactions"
        case price = "price"
        case location = "location"
        case phone = "phone"
        case dispalyPhone = "display_phone"
    }
}

struct Categories: Decodable {
    var alias: String
    var title: String
}

struct Coordinates: Decodable {
    var latitude: Double
    var longitude: Double
}

struct Location: Decodable {
    var displayAddress: [String]
    
    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}



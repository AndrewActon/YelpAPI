//
//  Error.swift
//  YelpAPI
//
//  Created by Andrew Acton on 2/15/23.
//

import Foundation

struct ErrorTopLevel: Decodable {
    var error: YelpError
}

struct YelpError: Decodable {
    var code: String
    var description: String
}

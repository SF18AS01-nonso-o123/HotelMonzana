//
//  RoomType.swift
//  HotelMonzana
//
//  Created by Chinonso Obidike on 3/5/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import Foundation
struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    
    //compare lefthand side with right hand side, return true if both ids are equal
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
        RoomType(id: 1, name: "One King", shortName: "K", price: 209),
        RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)
        ]
    }
}

//
//  Registeration.swift
//  HotelMonzana
//
//  Created by Chinonso Obidike on 3/5/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var NumberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

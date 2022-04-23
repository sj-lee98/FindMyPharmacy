//
//  KLDocument.swift
//  FindMyPharmacy
//
//  Created by 이성주 on 2022/04/23.
//

import Foundation

struct KLDocument: Decodable {
    let placeName: String
    let addressName: String
    let roadAddressName: String     // korea new address format
    let x: String
    let y:String
    let distance: String
    let phoneNumber: String
    
    // 받아온 json데이터 포맷과 비교해서 다른 경우 체크
    enum CodingKeys: String, CodingKey {
        case x,y, distance  // same
        case placeName = "place_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case phoneNumber = "phone"
    }
}

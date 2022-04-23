//
//  MTMapViewError.swift
//  FindMyPharmacy
//
//  Created by 이성주 on 2022/04/23.
//

import Foundation

enum MTMapViewError: Error {
    case failedUpdatingCurrentLocation
    case locationAuthorizationDenied
    
    
    // MTMapViewError를 전달받았을때 errorDescription을 전달하여 alert msg 표현 할 수 있도록 함.
    var errorDescription: String {
        switch self {
        case .failedUpdatingCurrentLocation:
            return "현재 위치를 불러오지 못했어요. 잠시 후 다시 시도해주세요."
        case .locationAuthorizationDenied:
            return "위치정보를 비활성화하면 사용자의 현재 위치를 알 수 없어요."
        }
    }
}

//
//  LocationInformationViewModel.swift
//  FindMyPharmacy
//
//  Created by 이성주 on 2022/04/23.
//

import RxSwift
import RxCocoa


struct LocationInformationViewModel {
    let disposeBag = DisposeBag()
    
    // subViewModels
    let detailListBackgroundViewModel = DetailListBackgroundViewModel()
    
    // viewModel -> view 로 전달 되어야 할 옵저버블
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    let detailListCellData: Driver<[DetailListCellData]>
    let scrollToSelectedLocation: Signal<Int>
    
    // view -> viewModel로 전달된 이벤트들
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()
    
    let documentData = PublishSubject<[KLDocument?]>()
    
    init() {
        //MARK: 지도 중심점 설정
        let selectDetailListItem = detailListItemSelected
            .withLatestFrom(documentData) { $1[$0] }
            .map { data -> MTMapPoint in
                guard let data = data,
                      let longitude = Double(data.x),
                      let latitude = Double(data.y) else {
                    return MTMapPoint()
                }
                let geoCoord = MTMapPointGeo(latitude: latitude, longitude: longitude)
                return MTMapPoint(geoCoord: geoCoord)
                
            }
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        
        let currentMapCenter = Observable
            .merge(
                selectDetailListItem,
                currentLocation.take(1),
                moveToCurrentLocation
            )
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = mapViewError.asObservable()
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
        
        detailListCellData = Driver.just([])
        
        scrollToSelectedLocation = selectPOIItem
            .map { $0.tag }
            .asSignal(onErrorJustReturn: 0)
    }
}

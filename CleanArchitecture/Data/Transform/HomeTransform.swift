//
//  HomeTransform.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import Foundation

extension HomeBannerResponse {
    public func toDomain() -> HomeEntity {
        guard let menuList = data?.menuList, menuList.count > 3 else {
            return HomeEntity(
                foodBannerList: [],
                trendBannerList: [],
                noticeBannerList: []
            )
        }
        
        // Combine Popup & New Open, Trend & Preference, and Hyundai Food Court To Home lists into one array and return
        let foodBannerList = mapToHomeBannerList(menuList[3].list2)
        let trendBannerList = mapToHomeBannerList(menuList[2].list)
        let noticeBannerList = mapToHomeBannerList(menuList[1].list)

        return HomeEntity(
            foodBannerList: foodBannerList,
            trendBannerList: trendBannerList,
            noticeBannerList: noticeBannerList
        )
    }
    
    private func mapToHomeBannerList<T>(_ list: [T]?) -> [HomeBanner] where T: HomeBannerListProtocol {
        return list?.compactMap { banner in
            HomeBanner(
                image: banner.image ?? "",
                dcRate: banner.dcRate ?? "",
                price: banner.price ?? "",
                link: banner.link ?? "",
                badgeNm: banner.badgeNm ?? "",
                place: banner.place ?? "",
                originPrice: banner.originPrice ?? "",
                title: banner.title ?? "",
                descript: banner.descript ?? ""
            )
        } ?? []
    }
}

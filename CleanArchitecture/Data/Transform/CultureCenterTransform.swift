//
//  CultureCenterTransform.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/2/25.
//

import Foundation

extension ApplyCrsList {
    public func toDomain() -> CultureLecture {
        return CultureLecture.init(applyCntCal: self.applyCntCal,
                                   nickNm: self.nickNm,
                                   crsNm: self.crsNm,
                                   tuition: self.tuition,
                                   timeclassinfo: self.timeclassinfo)
    }
}

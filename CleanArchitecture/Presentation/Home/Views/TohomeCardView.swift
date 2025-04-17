//
//  TohomeCardView.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/8/25.
//

import SwiftUI
import Kingfisher

struct TohomeCardView: View {
    let banner: HomeBanner

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: banner.image))
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("Tohome")
                .font(.caption)
                .foregroundColor(.gray)
            Text(banner.title)
                .font(.headline)
                .foregroundColor(.black)
            Text(banner.price.numberWithCommaFormat)
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
        }
    }
}

//
//  GenericErrorView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 18/5/2024.
//

import SwiftUI


struct GenericErrorView: View {
    private let configuration: GenericErrorViewConfigurable
    
    init(configuration: GenericErrorViewConfigurable) {
        self.configuration = configuration
    }
    
    var body: some View {
        VStack {
            Text(configuration.message)
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.bottom, 16)
            Button(action: configuration.primaryCTAAction, label: {
                Text(configuration.primaryCTATitle)
                    .bold()
                    .foregroundStyle(.white)
                
                Image(systemName: configuration.primaryCTAImage)
                    .foregroundStyle(.white)
            })
            .padding()
            .background(.black)
            .cornerRadius(8)
        }
    }
}

#if DEBUG
#Preview {
    let configuration = GenericErrorViewConfiguration(
        message: "Oops! We couldn't load the movies.",
        primaryCTATitle: "Try Again",
        primaryCTAImage: "arrow.counterclockwise",
        primaryCTAAction:  {}
    )
    return GenericErrorView(configuration: configuration)
}
#endif

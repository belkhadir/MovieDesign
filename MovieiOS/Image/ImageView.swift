//
//  ImageView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

public struct ImageView: View {
    private let data: Data
    
    public init(data: Data) {
        self.data = data
    }
    
    public var body: some View {
        ZStack {
            Image(uiImage: UIImage(data: data) ?? UIColor.red.toImage()!)
                .resizable()
                .frame(width: 150, height: 200)
                .scaledToFit()
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(data: Data())
    }
}

extension UIColor {
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

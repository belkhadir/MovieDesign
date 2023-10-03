//
//  SegementControlView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 2/10/2023.
//

import SwiftUI

struct SegmentControlView: View {
    private let viewModel: SegmentControlDisplayable
    private let selectedItem: (Int) -> Void
    
    @State private var selectedSegment = 0
    
    init(viewModel: SegmentControlDisplayable, selectedItem: @escaping (Int) -> Void) {
        self.viewModel = viewModel
        self.selectedItem = selectedItem
    }

    var body: some View {
        VStack(spacing: 20) {
            Picker("", selection: $selectedSegment) {
                ForEach(Array(viewModel.items.enumerated()), id: \.offset) { index, item in
                    Text(item).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedSegment) { newValue in
                selectedItem(newValue)
            }
        }
        .padding()
    }
}

struct SegementControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControlView(viewModel: MoviesDiscoveryViewModel(), selectedItem: {
            print("Index \($0)")
        })
    }
}

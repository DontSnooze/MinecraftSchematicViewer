//
//  BlocksMenuView.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import SwiftUI
import SceneKit

struct BlocksMenuView: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: ViewModel
    
    var body: some View {
        HStack {
            let width = (UIScreen.main.bounds.size.width / 5) * 3
            Spacer(minLength: width)
            
            VStack {
                header
                blockCountList
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40))
            }
            .background {
                Color.white
            }
            
        }
        .ignoresSafeArea()
    }
    
    var header: some View {
        HStack {
            Spacer()
            Button("Done") {
                dismiss()
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 25))
        }
    }
    
    var blockCountList: some View {
        List {
            Section(header: Text("Block Counts")) {
                ForEach(viewModel.blockCounts().sorted(by: <), id: \.key) { key, value in
                    HStack {
                        Text(key)
                        Spacer()
                        Text("\(value)")
                    }
                }
            }
        }
    }
}

struct BlocksMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BlocksMenuView(viewModel: BlocksMenuView.ViewModel(mapLevels: BlocksData.dummyMapLevels(), hiddenLevels: []))
    }
}

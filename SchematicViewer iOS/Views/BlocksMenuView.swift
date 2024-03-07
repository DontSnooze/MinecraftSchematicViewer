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
        VStack {
            
            HStack {
                Spacer()
                Button("Done") {
                    dismiss()
                }.padding()
            }
            
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
}

struct BlocksMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BlocksMenuView(viewModel: BlocksMenuView.ViewModel(mapLevels: BlocksData.dummyMapLevels()))
    }
}

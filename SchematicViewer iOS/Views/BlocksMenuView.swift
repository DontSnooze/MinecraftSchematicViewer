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
    @ObservedObject var viewModel: ViewModel
    
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
                Color(UIColor.systemBackground)
            }
        }
        .ignoresSafeArea()
    }
    
    var header: some View {
        HStack {
            Button("Done") {
                dismiss()
            }
            .padding([.top, .leading])
            Spacer()
            Button("Show All") {
                viewModel.showAllBlocks()
            }
            .padding([.top])
            Button("Hide All") {
                viewModel.hideAllBlocks()
            }
            .padding([.top, .trailing])
        }
    }
    
    var blockCountList: some View {
        NavigationView {
            List {
                Section(header: HStack {
                    Text("Block")
                    Spacer()
                    Text("Count")
                }) {
                    ForEach(viewModel.filteredBlockCounts.sorted(by: <), id: \.key) { key, value in
                        HStack {
                            Text(key)
                            Spacer()
                            Text(viewModel.textForBlockCount(count: value))
                            Button {
                                viewModel.handleVisibilityPressed(block: key)
                            } label: {
                                HStack {
                                    Image(systemName: viewModel.imageForBlockVisibility(block: key))
                                }
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Filter")
        }
        .navigationViewStyle(.stack)
        .statusBar(hidden: true)
    }
}

struct BlocksMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BlocksMenuView(viewModel: BlocksMenuView.ViewModel(mapLevels: BlocksData.dummyMapLevels(), hiddenLevels: [], hiddenBlocks: []))
    }
}

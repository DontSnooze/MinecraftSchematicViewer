//
//  MapLevelsMenu.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import SwiftUI

struct MapLevelsMenuView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button("Done") {
                    viewModel.handleDonePressed()
                    dismiss()
                }.padding()
                Spacer()
                Button("Show All") {
                    viewModel.showAllLevels()
                }
                Button("Hide All") {
                    viewModel.hideAllLevels()
                }.padding()
            }
            
            List {
                Section(header: Text("Map Levels")) {
                    ForEach(Array(0..<viewModel.levelCount), id: \.self) { level in
                        HStack {
                            Text("Level \(level)")
                            Spacer()
                            Button(viewModel.textForLevelHideButton(level: level)) {
                                if viewModel.levelIsHidden(level: level) {
                                    viewModel.hiddenLevels.removeAll { hiddenLevel in
                                        hiddenLevel == level
                                    }
                                } else {
                                    viewModel.hiddenLevels.append(level)
                                }
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MapLevelsMenuView(viewModel: MapLevelsMenuView.ViewModel(levelCount: 6, hiddenLevels: []))
}

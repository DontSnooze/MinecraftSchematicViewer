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
                    ForEach(Array(0..<viewModel.levelCount).reversed(), id: \.self) { level in
                        HStack {
                            Text("Level \(level)")
                            
                            Spacer()
                            
                            Button {
                                viewModel.handleVisibilityPressed(level: level)
                            } label: {
                                HStack {
                                    Image(systemName: viewModel.imageForLevelVisibility(level: level))
                                    Text(viewModel.textForLevelHideButton(level: level))
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

struct MapLevelsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MapLevelsMenuView(viewModel: MapLevelsMenuView.ViewModel(levelCount: 6, hiddenLevels: []))
    }
}

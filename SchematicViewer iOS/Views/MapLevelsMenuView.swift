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
        HStack {
            let width = (UIScreen.main.bounds.size.width / 5) * 3
            Spacer(minLength: width)
            
            VStack {
                header
                levels
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40))
            }
            .background {
                Color(UIColor.systemBackground)
            }
            .statusBar(hidden: true)
        }
        .ignoresSafeArea()
    }
    
    var header: some View {
        HStack {
            Button("Done") {
                viewModel.handleDonePressed()
                dismiss()
            }
            .padding([.top, .leading])
            Spacer()
            Button("Show All") {
                viewModel.showAllLevels()
            }
            .padding([.top])
            Button("Hide All") {
                viewModel.hideAllLevels()
            }
            .padding([.top, .trailing])
        }
    }
    
    var levels: some View {
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

struct MapLevelsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MapLevelsMenuView(viewModel: MapLevelsMenuView.ViewModel(levelCount: 6, hiddenLevels: []))
    }
}

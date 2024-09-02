//
//  AppView.swift
//  TCASample
//
//  Created by 박현수 on 8/30/24.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            
            // Push 1
            VStack {
                NavigationLink(state: RootFeature.Path.State.redFeature(RedFeature.State())) {
                    Text("RedView Push 1 (Link)")
                        .frame(height: 30)
                }
                
                NavigationLink(state: RootFeature.Path.State.blueFeature(BlueFeature.State())) {
                    Text("BlueView Push 1 (Link)")
                        .frame(height: 30)
                }
                
                Spacer()
                    .frame(height:50)
                
                Button("RedView Push 2 (append)") {
                    store.send(.clickRedButton)
                }.frame(height: 30)
                
                Button("BlueView Push 2 (append)") {
                    store.send(.clickBlueButton)
                }.frame(height: 30)
                
            }
            .navigationTitle("RootFeature")
            
        } destination: { store in
            switch store.case {
            case .redFeature(let redStore):
                RedView(store: redStore)
            case .blueFeature(let blueStore):
                BlueView(store: blueStore)
            case .orangeFeature(let orangeStore):
                OrangeView(store: orangeStore)
            }
        }
    }
}

//
//  BlueView.swift
//  TCASample
//
//  Created by 박현수 on 8/30/24.
//

import SwiftUI
import ComposableArchitecture

struct BlueView: View {
    
    var store: StoreOf<BlueFeature>
    
    var body: some View {
        
        ZStack {
            Color.blue
            
            VStack {
                Button("back") {
                    store.send(.clickBackButton)
                }.frame(height: 30)
                    .foregroundStyle(.black)
                
                Button("Next") {
                    store.send(.clickNextButton)
                }.frame(height: 30)
                    .foregroundStyle(.black)
            }
            .navigationTitle("BlueView")
        }
        
        
    }
}

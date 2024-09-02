//
//  BBView.swift
//  TCASample
//
//  Created by 박현수 on 8/30/24.
//

import SwiftUI
import ComposableArchitecture

struct OrangeView: View {
    
    var store: StoreOf<OrangeFeature>
    
    var body: some View {
        
        ZStack {
            Color.orange
            VStack {
                Button("back") {
                    store.send(.clickBackButton)
                }.frame(height: 30)
                    .foregroundStyle(.black)
            }
            .navigationTitle("OrangeView")
        }
        
    }
}

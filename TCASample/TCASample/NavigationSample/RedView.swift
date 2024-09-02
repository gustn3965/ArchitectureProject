//
//  RedView.swift
//  TCASample
//
//  Created by 박현수 on 8/30/24.
//

import SwiftUI
import ComposableArchitecture

struct RedView: View {
    
    var store: StoreOf<RedFeature>
    
    var body: some View {
        
        
        ZStack {
            Color.red
            
            VStack {
                Button("back") {
                    store.send(.clickBackButton)
                }.frame(height: 30)
                    .foregroundStyle(.black)
            }
            .navigationTitle("RedView")
        }
    }
}

//#Preview {
//    RedView(store: .init(initialState: RedFeature.State(), reducer: { RedFeature()}))
//}

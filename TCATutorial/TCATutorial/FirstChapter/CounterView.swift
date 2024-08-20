//
//  CounterView.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
    var store: StoreOf<CounterFeature>
    
    var body: some View {
        
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
  CounterView(
    store: .init(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    })
  )
}

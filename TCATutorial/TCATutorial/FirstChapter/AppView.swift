//
//  AppView.swift
//  TCATutorial
//
//  Created by 박현수 on 8/24/24.
//

import SwiftUI
import ComposableArchitecture
struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            
            if let childStore = store.scope(state: \.tab1, action: \.tab1) {
                VStack {
                    CounterView(store: childStore)
                        .tabItem { Text("counter 1") }
                    Spacer()
                    Button {
                        store.send(.clickDeleteTab1)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            } else {
                VStack {
                    Text("Tab 1 is unavailable")
                        .tabItem { Text("counter 1") }
                    Spacer()
                    Button {
                        store.send(.clickMakeTab1)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            
            CounterView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem { Text("counter 2") }
            
//            IfLetStore(
//                store.scope(state: \.tab1, action: \.tab1),
//                then: { counterStore in
//                    VStack {
//                        CounterView(store: counterStore)
//                            .tabItem { Text("counter 1") }
//                        Spacer()
//                        Button {
//                            store.send(.clickDeleteTab1)
//                        } label: {
//                            Image(systemName: "trash")
//                                .foregroundColor(.red)
//                        }
//                    }
//                    
//                },
//                else: {
//                    VStack {
//                        Text("Tab 1 is unavailable")
//                            .tabItem { Text("counter 1") }
//                        Spacer()
//                        Button {
//                            store.send(.clickMakeTab1)
//                        } label: {
//                            Image(systemName: "trash")
//                                .foregroundColor(.red)
//                        }
//                    }
//                    
//                    
//                }
//            )
      
        }
    }
}

#Preview {
  AppView(
    store: Store(initialState: AppFeature.State()) {
      AppFeature()
    }
  )
}

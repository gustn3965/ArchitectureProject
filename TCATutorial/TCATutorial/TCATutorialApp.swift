//
//  TCATutorialApp.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCATutorialApp: App {
    
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
                             
    var body: some Scene {
        WindowGroup {
//            ContactsView(store: .init(initialState: ContactsFeature.State(contacts: []), reducer: {
//                ContactsFeature()
//            }))
            
            CounterView(store: TCATutorialApp.store)
        }
    }
}

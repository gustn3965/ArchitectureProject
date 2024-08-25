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
    
    static let counterStore = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    static let appStore = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }
    
    static let contactStore = Store(initialState: ContactsFeature.State()) {
        ContactsFeature()
            ._printChanges()
    }
                             
    var body: some Scene {
        WindowGroup {
//            CounterView(store: TCATutorialApp.store)
            
//            AppView(store: Self.appStore)
            
            ContactsView(store: TCATutorialApp.contactStore)
        }
    }
}

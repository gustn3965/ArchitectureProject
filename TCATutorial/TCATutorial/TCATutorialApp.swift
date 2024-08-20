//
//  TCATutorialApp.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import SwiftUI

@main
struct TCATutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContactsView(store: .init(initialState: ContactsFeature.State(contacts: []), reducer: {
                ContactsFeature()
            }))
        }
    }
}

//
//  TCASampleApp.swift
//  TCASample
//
//  Created by 박현수 on 8/29/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCASampleApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: .init(initialState: AppFeature.State(), reducer: {
                AppFeature()
            }))
//            RootView(store: .init(initialState: RootFeature.State(),
//                                 reducer: {
//                RootFeature()
//            }))
            
//            BView(store: .init(initialState: BlueFeature.State(), reducer: {
//                BFeature()
//            }))
        }
    }
}

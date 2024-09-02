//
//  BBFeature.swift
//  TCASample
//
//  Created by 박현수 on 8/30/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct OrangeFeature {
    
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        case clickBackButton
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .clickBackButton:
                
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}


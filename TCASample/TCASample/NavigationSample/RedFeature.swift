//
//  AFeature.swift
//  TCASample
//
//  Created by 박현수 on 8/29/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct RedFeature {
    
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        case clickBackButton
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .clickBackButton:
                return .none
            }
        }
    }
}

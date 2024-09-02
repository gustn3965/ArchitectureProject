//
//  BlueFeature.swift
//  TCASample
//
//  Created by 박현수 on 8/29/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct BlueFeature {
    
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        case clickBackButton
        case clickNextButton
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .clickBackButton:
                return .none
            case .clickNextButton:
                return .none
            }
        }
    }
}

//
//  AppFeature.swift
//  TCATutorial
//
//  Created by 박현수 on 8/24/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
    
    @ObservableState
    struct State: Equatable {
        var tab1: CounterFeature.State?
        var tab2 = CounterFeature.State()
    }
    
    enum Action {
        
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
        case clickMakeTab1
        case clickDeleteTab1
    }
    
    var body: some ReducerOf<Self> {
        
//        Scope(state: \.tab1, action: \.tab1) {
//            CounterFeature()
//        }
        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }
        
        
        Reduce { state, action in
            switch action {
            case .clickMakeTab1:
                state.tab1 = CounterFeature.State()
                return .none
            case .clickDeleteTab1:
                state.tab1 = nil
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.tab1, action: \.tab1) {
            CounterFeature()
        }
    }
}

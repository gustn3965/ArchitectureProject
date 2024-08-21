//
//  CounterFeature.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State {
        var count = 0
        var isLoading = false
        var fact: String? 
        var isTimerRunning: Bool = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String?)
        case toggleTimerButtonTapped
        case timerTrick
    }
    
    
    enum CancelID {
        case timer
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(data: data, encoding: .utf8)
                    await send(.factResponse(fact))
                }

            case .factResponse(let fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                
                if state.isTimerRunning {
                    return .run { send in
                        
                        while true {
                            
                            
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTrick)
                            print("")
                        }
                    }.cancellable(id: CancelID.timer)
                    
                } else {
                    return .cancel(id: CancelID.timer)
                }
                
                
            case .timerTrick:
                state.count += 1
                state.fact = nil
                
                return .none
            }
        }
    }
}

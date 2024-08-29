//
//  ContactDetailFeature.swift
//  TCATutorial
//
//  Created by 박현수 on 8/28/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        let contact: Contact
    }
    
    enum Action {
        
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        case deleteButtonTapped
        enum Alert {
            case confirmDeletion
        }
        enum Delegate {
            case confirmDeletion
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .deleteButtonTapped:
                state.alert = .confirmDeletion
                return .none
            case .alert(.presented(.confirmDeletion)):
                
                return .run { send in
                    await send(.delegate(.confirmDeletion))
                    await self.dismiss()
                }
            case .delegate(.confirmDeletion):
                return .none
            case .delegate:
                return .none
            case .alert:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

extension AlertState where Action == ContactDetailFeature.Action.Alert {
    
    static let confirmDeletion = Self {
        TextState("Are you sure?")
          } actions: {
            ButtonState(role: .destructive, action: .confirmDeletion) {
              TextState("Delete")
            }
          }
}

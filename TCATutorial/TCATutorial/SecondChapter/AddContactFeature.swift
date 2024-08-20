//
//  AddContactFeature.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AddContactFeature {
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
        case delegate(Delegate)
        
        enum Delegate {
            case saveContact(Contact)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }

            case .saveButtonTapped:
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }
                
            case .delegate:
                return .none
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}

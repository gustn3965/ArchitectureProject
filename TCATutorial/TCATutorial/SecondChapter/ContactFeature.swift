//
//  ContactFeature.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(contact: Contact(id: UUID(), name: ""))
                return .none
                
            case .addContact(.presented(.cancelButtonTapped)):
                state.addContact = nil
                return .none
                
                // 1. 아래방식은 자식의 행동을 파악 및 로직을 알아야함.
//            case .addContact(.presented(.saveButtonTapped)):
                
                // 2. delegate로 자식이 부모에게 의도를 전달함으로써 더 나은 코드.
            case .addContact(.presented(.delegate(.saveContact(let contact)))):
                
                state.contacts.append(contact)
                return .none
                
            case .addContact:
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
}

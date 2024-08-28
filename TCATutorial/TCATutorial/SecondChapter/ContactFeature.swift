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
        //        @Presents var addContact: AddContactFeature.State?
        //        @Presents var alert: AlertState<Action.Alert>?
        @Presents var destination: Destination.State?
        
        var contacts: IdentifiedArrayOf<Contact> = []
        
    }
    
    enum Action {
        case addButtonTapped
        case deleteButtonTapped(id: Contact.ID)
        case destination(PresentationAction<Destination.Action>)
        //        case addContact(PresentationAction<AddContactFeature.Action>)
        //        case alert(PresentationAction<Alert>)
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                
                state.destination = .addContact(
                    AddContactFeature.State(
                                contact: Contact(id: self.uuid(), name: "")
                              )
                )
                //                state.addContact = AddContactFeature.State(contact: Contact(id: UUID(), name: ""))
                return .none
                
                //            case .destination(.presented(.addContact(.cancelButtonTapped))):
                //                state.destination = nil
                //                return .none
                
                // 1. 아래방식은 자식의 행동을 파악 및 로직을 알아야함.
                //            case .addContact(.presented(.saveButtonTapped)):
                
                // 2. delegate로 자식이 부모에게 의도를 전달함으로써 더 나은 코드.
            case .destination(.presented(.addContact(.delegate(.saveContact(let contact))))):
                
                state.contacts.append(contact)
                return .none
                
                //            case .addContact:
                //                return .none
                
            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.contacts.remove(id: id)
                return .none
                
            case .destination:
                return .none
                
                //
                //            case .alert:
                //                return .none
                //
            case let .deleteButtonTapped(id: id):
                    
                state.destination = .alert(.deleteConfirmation(id: id))
                //                state.alert = AlertState {
                //                    TextState("Are you sure?")
                //                } actions: {
                //                    ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                //                        TextState("Delete")
                //                    }
                //                }
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        //        .ifLet(\.$addContact, action: \.addContact) {
        //            AddContactFeature()
        //        }
        //
        //        .ifLet(\.$alert, action: \.alert)
        
        
    }
}

extension ContactsFeature {
    
    @Reducer(state: .equatable)
    enum Destination {
        case addContact(AddContactFeature)
        case alert(AlertState<ContactsFeature.Action.Alert>)
    }
}

extension AlertState where Action == ContactsFeature.Action.Alert {
    
    static func deleteConfirmation(id: UUID) -> Self {
        Self {
            TextState("Are you sure?")
        } actions: {
            ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                TextState("Delete")
            }
        }
    }
}

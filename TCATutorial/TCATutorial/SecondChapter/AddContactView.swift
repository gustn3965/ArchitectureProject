//
//  AddContactView.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
    
    @Bindable var store: StoreOf<AddContactFeature>
    
    var body: some View {
        
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
            Button("save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    AddContactView(store: .init(initialState: AddContactFeature.State(contact: Contact(id: UUID(), name: "DDD")), reducer: {
        AddContactFeature()
    }))
}

//
//  ContactsView.swift
//  TCATutorial
//
//  Created by 박현수 on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    @Bindable var store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        // item이 non-nil이게 되면 감지해서 sheet띄워준다.
        .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { store in
            NavigationStack {
                AddContactView(store: store)
            }
        }
        
    }
}

#Preview {
    ContactsView(store: .init(initialState: ContactsFeature.State(contacts: [
        Contact(id: UUID(), name: "Blob"),
        Contact(id: UUID(), name: "Vapor"),
        Contact(id: UUID(), name: "kKuDas")
    ]), reducer: {
        ContactsFeature()
    }))
}

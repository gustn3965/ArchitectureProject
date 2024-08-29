//
//  ContactsDetailView.swift
//  TCATutorial
//
//  Created by 박현수 on 8/28/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    
    @Bindable var store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        
        Form {
            Button("Delete") {
                store.send(.deleteButtonTapped)
            }
        }
        .navigationTitle(Text(store.contact.name))
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

//
//  ContactsFeatureTests.swift
//  TCATutorialTests
//
//  Created by 박현수 on 8/25/24.
//

import XCTest
import ComposableArchitecture

@testable import TCATutorial

@MainActor
final class ContactsFeatureTests: XCTestCase {
    func testAddFlow() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(
                    contact: Contact(id: UUID(0), name: "")
                )
            )
        }
        await store.send(\.destination.addContact.setName, "Blob Jr.") {
            $0.destination?.addContact?.contact.name = "Blob Jr."
        }
        await store.send(\.destination.addContact.saveButtonTapped)
        await store.receive(
            \.destination.addContact.delegate.saveContact,
             Contact(id: UUID(0), name: "Blob Jr.")
        ) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
        }
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
        
    }
    
    func test_NonExhaustive() async {
        
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
        
        await store.send(.addButtonTapped)
        await store.send(\.destination.addContact.setName, "adsfasdf")
//        await store.send(.destination(.presented(.addContact(.setName("asdfasdf")))))
        await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
        await store.skipReceivedActions()
        
        store.assert { state in
            state.contacts = [
                Contact(id: UUID(0), name: "adsfasdf")
            ]
            state.destination = nil
        }
//        await store.send(\.destination.addContact.setName, "Blob Jr.")
    }
    
    func test_deleteContact() async {
        
        let store = TestStore(initialState: ContactsFeature.State(contacts: [
            Contact(id: UUID(0), name: "bob"),
            Contact(id: UUID(1), name: "bob"),
        ]), reducer: {
            ContactsFeature()
        })
                      
        
        await store.send(.deleteButtonTapped(id: UUID(0))) {
            $0.destination = .alert(.deleteConfirmation(id: UUID(0)))
        }
        
        await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(0)))))) {
            $0.contacts.remove(id: UUID(0))
            $0.destination = nil
        }
                              
    }
}

//
//  TCATutorialTests.swift
//  TCATutorialTests
//
//  Created by 박현수 on 8/20/24.
//

import ComposableArchitecture
import XCTest
@testable import TCATutorial


@MainActor
final class CounterFeatureTests: XCTestCase {
    func testCounter() async {
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
        //      await stor/
    }
    
    func testTimer() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: { dependency in
            dependency.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        
        await store.receive(\.timerTrick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: { dependencies in
//            dependencies.numberFact = NumberFactClient(fetch: { number in
//                return "0은 TEST다."
//            })
            dependencies.numberFact.fetch = { number in
                return "0은 TEST다."
            }
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        
        
        await store.receive(\.factResponse) {
            $0.isLoading = false
            $0.fact = "0은 TEST다."
        }
    }
}

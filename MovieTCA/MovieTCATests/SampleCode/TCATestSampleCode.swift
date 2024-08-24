//
//  TCATestSampleCode.swift
//  MovieTCATests
//
//  Created by 박현수 on 8/11/24.
//

import XCTest
import ComposableArchitecture


@MainActor
class CounterTests: XCTestCase {
    
  func testBasics() async {
      
      let store: TestStoreOf<TestFeature> = .init(initialState: .init(count: 0), reducer: { TestFeature() })
      
      await store.send(.incrementButtonTapped) {
          $0.count = 1
      }
  }
    
    func testDD() async {
        let value = await prrrint()
        
        XCTAssert(value == "ABC")
    }
    
    func prrrint() async -> String  {
        
        await try? Task.sleep(for: .seconds(1))
        return "ABC"
    }
}

struct TestFeature: Reducer {
    
    struct State: Equatable { var count = 0 }
    enum Action { case incrementButtonTapped, decrementButtonTapped }
    struct Environment {}

    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
          switch action {
          case .incrementButtonTapped:
            state.count += 1
            return .none
          case .decrementButtonTapped:
            state.count -= 1
            return .none
          }
        }
    }
}

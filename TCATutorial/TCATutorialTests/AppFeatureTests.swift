//
//  AppFeatureTests.swift
//  TCATutorialTests
//
//  Created by 박현수 on 8/24/24.
//

import ComposableArchitecture
import XCTest


@testable import TCATutorial


@MainActor
final class AppFeatureTests: XCTestCase {
  func testIncrementInFirstTab() async {
    
      let store = TestStore(initialState: AppFeature.State()) {
          AppFeature()
      }
      
//      await store.send(.tab1(.incrementButtonTapped)) { state in
//          
//      }
      await store.send(\.tab1.incrementButtonTapped) {
          $0.tab1?.count = 1
      }
  }
}

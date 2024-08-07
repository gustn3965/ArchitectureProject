//
//  XCTestHelper.swift
//  MovieNetworkTests
//
//  Created by 박현수 on 8/8/24.
//

import Foundation
import XCTest

extension XCTestCase {
    func performAsyncTest(testBlock: @escaping (XCTestExpectation) -> Void) {
        let expectation = self.expectation(description: "Async test")
        testBlock(expectation)
        waitForExpectations(timeout: 5, handler: nil)
    }
}

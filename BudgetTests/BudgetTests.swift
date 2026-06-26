//
//  BudgetTests.swift
//  BudgetTests
//
//  Created by Anna Kochanova on 25.06.2026.
//

import XCTest
@testable import Budget

final class BudgetTests: XCTestCase {

    @MainActor func testListViewModel_initialState() {
        let sut = ListViewModel(storage: MockStorage())

        XCTAssertFalse(sut.operations.isEmpty)
    }

    @MainActor func testAddOperationIncreasesCount() {
        let sut = ListViewModel(storage: MockStorage())

        let initialCount = sut.operations.count

        let operation = Operation(
            type: .income,
            title: "aa",
            amount: 100,
            date: Calendar.current.date(from: DateComponents(year: 1999, month: 1, day: 1))!
        )

        try? sut.addOperation(operation)

        XCTAssertEqual(sut.operations.count, initialCount + 1)
    }
}

//
//  BudgetTests.swift
//  BudgetTests
//
//  Created by Anna Kochanova on 25.06.2026.
//

import XCTest
@testable import Budget

final class BudgetTests: XCTestCase {

    // helper
    @MainActor
    private func makeSUT() -> ListViewModel {
        ListViewModel(storage: TestMockStorage())
    }

    // initialState
    @MainActor
    func testListViewModel_initialState() {
        let sut = makeSUT()

        XCTAssertTrue(sut.operations.isEmpty)
    }

    // addOperation
    @MainActor
    func testAddOperationIncreasesCount() {
        let sut = makeSUT()
        let initialCount = sut.operations.count

        let operation = Operation(
            type: .income,
            title: "Test",
            amount: 100,
            date: Date()
        )

        try? sut.addOperation(operation)

        XCTAssertEqual(sut.operations.count, initialCount + 1)
    }

    // removeOperation
    @MainActor
    func testRemoveOperationDecreasesCount() {
        let sut = makeSUT()

        let operation = Operation(
            type: .income,
            title: "Test",
            amount: 100,
            date: Date()
        )

        try? sut.addOperation(operation)

        let initialCount = sut.operations.count

        sut.removeOperation(operation)

        XCTAssertEqual(sut.operations.count, initialCount - 1)
    }

    // editOperation
    @MainActor
    func testEditOperationUpdatesValue() {
        let sut = makeSUT()

        let operation = Operation(
            type: .income,
            title: "Old title",
            amount: 100,
            date: Date()
        )

        try? sut.addOperation(operation)

        let updated = Operation(
            id: operation.id,
            type: operation.type,
            title: "Updated title",
            amount: operation.amount,
            date: operation.date
        )

        try? sut.editOperation(updated)

        let result = sut.operations.first(where: { $0.id == operation.id })

        XCTAssertEqual(result?.title, "Updated title")
    }

    // totalBalance
    @MainActor
    func testTotalBalanceCalculation() {
        let sut = makeSUT()

        try? sut.addOperation(
            Operation(type: .income, title: "Income", amount: 200, date: Date())
        )

        try? sut.addOperation(
            Operation(type: .expense, title: "Expense", amount: 50, date: Date())
        )

        XCTAssertEqual(sut.totalBalance, 150)
    }

    // filteredOperations
    @MainActor
    func testFilteredOperations_showsOnlyExpenses() {
        let sut = makeSUT()

        try? sut.addOperation(
            Operation(type: .income, title: "Income", amount: 200, date: Date())
        )

        try? sut.addOperation(
            Operation(type: .expense, title: "Expense", amount: 50, date: Date())
        )

        sut.showOnlyExpenses = true

        XCTAssertEqual(sut.filteredOperations.count, 1)
        XCTAssertEqual(sut.filteredOperations.first?.type, .expense)
    }
}


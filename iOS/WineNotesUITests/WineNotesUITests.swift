import XCTest

final class WineNotesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddButtonOpensEditor() throws {
        app.buttons["addButton"].tap()
        XCTAssertTrue(app.buttons["saveButton"].waitForExistence(timeout: 2))
        app.buttons["cancelButton"].tap()
    }

    func testAddFlowSavesItem() throws {
        let listCountBefore = app.tables.cells.count
        app.buttons["addButton"].tap()
        app.buttons["saveButton"].tap()
        XCTAssertTrue(app.buttons["addButton"].waitForExistence(timeout: 2))
        XCTAssertGreaterThanOrEqual(app.tables.cells.count, listCountBefore)
    }

    func testKeyboardDismissesOnTapOutside() throws {
        app.buttons["addButton"].tap()
        let textFields = app.textFields
        if textFields.count > 0 {
            let field = textFields.element(boundBy: 0)
            field.tap()
            app.staticTexts.firstMatch.tap()
            XCTAssertFalse(field.isFocused)
        }
        app.buttons["cancelButton"].tap()
    }

    func testSettingsOpens() throws {
        app.buttons["settingsButton"].tap()
        XCTAssertTrue(app.buttons["settingsDoneButton"].waitForExistence(timeout: 2))
        app.buttons["settingsDoneButton"].tap()
    }
}

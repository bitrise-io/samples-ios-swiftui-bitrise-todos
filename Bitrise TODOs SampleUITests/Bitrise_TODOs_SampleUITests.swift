//
//  Bitrise_TODOs_SampleUITests.swift
//  Bitrise TODOs SampleUITests
//
//  Created by viktorbenei on 2023. 06. 26..
//

import XCTest

final class Bitrise_TODOs_SampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddingAnItem() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Given we type in an example task and click Add Task
        let enterNewTaskTextField = app.textFields["Enter new task"]
        enterNewTaskTextField.tap()
        enterNewTaskTextField.typeText("Add a basic UI test to the app")
        app.buttons["Add Task"].tap()
        
        // Then the task should exist on the "Not Done Yet" (default) list
        let collectionViewsQuery = app.collectionViews
        let addASimpleUiTestStaticText = collectionViewsQuery.staticTexts["Add a basic UI test to the app"]
        XCTAssert(addASimpleUiTestStaticText.exists)
        
        // And should not exist on the "Done" list
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Done"].tap()
        XCTAssertFalse(addASimpleUiTestStaticText.exists)
    }
    
    func testAddingAndMarkingAnItemAsDoneThenUndone() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Given we type in an example task, click Add Task, and then mark it as "Done" by clicking the checkbox on it
        let enterNewTaskTextField = app.textFields["Enter new task"]
        enterNewTaskTextField.tap()
        enterNewTaskTextField.typeText("Add a basic UI test to the app")
        app.buttons["Add Task"].tap()
        let collectionViewsQuery = app.collectionViews
        let addASimpleUiTestStaticText = collectionViewsQuery.staticTexts["Add a basic UI test to the app"]
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Square"]/*[[".cells.buttons[\"Square\"]",".buttons[\"Square\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // The task should not exist on the "Not Done Yet" list
        XCTAssertFalse(addASimpleUiTestStaticText.exists)
        // But it should exist on the Done list
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Done"].tap()
        XCTAssert(addASimpleUiTestStaticText.exists)
        // And if we mark it as "not done yet" (untick checkbox)
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Selected"]/*[[".cells.buttons[\"Selected\"]",".buttons[\"Selected\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // It should be again on the "Not Done Yet" list
        tabBar.buttons["Not Done Yet"].tap()
        XCTAssert(addASimpleUiTestStaticText.exists)
    }
    
    func testAddTwoTasksAndMarkTheSecondAsDoneThenUndone() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Given we add 2 tasks
        let enterNewTaskTextField = app.textFields["Enter new task"]
        enterNewTaskTextField.tap()
        enterNewTaskTextField.typeText("Task 1")
        let addTaskButton = app.buttons["Add Task"]
        addTaskButton.tap()
        enterNewTaskTextField.tap()
        enterNewTaskTextField.typeText("Task 2")
        addTaskButton.tap()
        
        
        // Both Tasks should be present on the (default) "Not done yet" list
        let collectionViewsQuery = app.collectionViews
        let task1StaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Task 1"]/*[[".cells.staticTexts[\"Task 1\"]",".staticTexts[\"Task 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(task1StaticText.exists)
        let task2StaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Task 2"]/*[[".cells.staticTexts[\"Task 2\"]",".staticTexts[\"Task 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(task2StaticText.exists)
        
        
        // When we mark the second one as completed
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).buttons["Square"].tap()
        // The fist one should still be on the Not Done Yet list
        XCTAssert(task1StaticText.exists)
        //  but the second one shouldn't
        XCTAssertFalse(task2StaticText.exists)
        
        // When we switch over to the "Done" list
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Done"].tap()
        // The fist task should not be on this Done list
        XCTAssertFalse(task1StaticText.exists)
        //  but the second one should
        XCTAssert(task2StaticText.exists)
        
        // When we mark the second task as not-done-yet
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Selected"]/*[[".cells.buttons[\"Selected\"]",".buttons[\"Selected\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //  neither tasks should be on the Done list
        XCTAssertFalse(task1StaticText.exists)
        XCTAssertFalse(task2StaticText.exists)
        
        // Instead, if we switch back to "Not Done Yet" list
        tabBar.buttons["Not Done Yet"].tap()
        // Both tasks should be listed there
        XCTAssert(task1StaticText.exists)
        XCTAssert(task2StaticText.exists)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

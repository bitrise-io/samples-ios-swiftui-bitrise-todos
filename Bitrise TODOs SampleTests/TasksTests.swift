//
//  TasksTests.swift
//  Bitrise TODOs SampleTests
//
//  Created by viktorbenei on 2023. 07. 02..
//

import XCTest
@testable import Bitrise_TODOs_Sample

class TasksTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInit() {
        let tasks = Tasks()
        XCTAssertTrue(tasks.tasks.isEmpty)
    }
    
    func testInitWithTasks() {
        let task = Task(title: "Test", completed: false)
        let tasks = Tasks(withTasks: [task])
        XCTAssertEqual(tasks.tasks.count, 1)
        XCTAssertEqual(tasks.tasks.first?.title, "Test")
    }
    
    func testAddTask() {
        let tasks = Tasks()
        tasks.addTask(title: "Test")
        XCTAssertEqual(tasks.tasks.count, 1)
        XCTAssertEqual(tasks.tasks.first?.title, "Test")
    }
    
    func testToggleTaskCompletion() {
        let task = Task(title: "Test", completed: false)
        let tasks = Tasks(withTasks: [task])
        XCTAssertFalse(tasks.tasks.first?.completed ?? true)
        tasks.toggleTaskCompletion(task: task)
        XCTAssertTrue(tasks.tasks.first?.completed ?? false)
    }
    
    func testDeleteTask() {
        let task = Task(title: "Test", completed: false)
        let tasks = Tasks(withTasks: [task])
        tasks.deleteTask(task: task)
        XCTAssertTrue(tasks.tasks.isEmpty)
    }
}

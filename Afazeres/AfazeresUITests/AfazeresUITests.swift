import XCTest

class when_app_is_launched: XCTestCase {

    func test_should_not_display_any_tasks() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(0, taskList.cells.count)
    }
    
    override func tearDown() {
        super.tearDown()
        Springboard.deleteApp()
    }
}

class when_user_saves_a_new_task: XCTestCase {
    
    func test_should_be_able_to_display_task_successfully() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(1, taskList.cells.count)
    }
    
    func test_display_error_message_for_duplicate_title_tasks() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        saveTaskButton.tap()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(1, taskList.cells.count)
        
        let messageText = app.staticTexts["messageText"]
        XCTAssertEqual(messageText.label, "Task is already added")
    }
    
    override func tearDown() {
        super.tearDown()
        Springboard.deleteApp()
    }
    
}

class when_user_deletes_a_new_task: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
    }
    
    func test_should_delete_task_successfully() {
        let cell = app.tables["taskList"].cells["Mow the lawn, Medium"]
        cell.swipeLeft()
        app.tables["taskList"].buttons["Delete"].tap()
        XCTAssertFalse(cell.exists)
    }
    
    override func tearDown() {
        Springboard.deleteApp()
    }
    
}

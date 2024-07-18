import XCTest

class Springboard {
    
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    class func deleteApp() {
        XCUIApplication().terminate()
        springboard.activate()
        
        let appIcon = springboard.icons.matching(identifier: "Afazeres").firstMatch
        appIcon.press(forDuration: 1.3)
        
        let _ = springboard.buttons["Remover App"].waitForExistence(timeout: 1.0)
        springboard.buttons["Remover App"].tap()
        
        let deleteButton = springboard.alerts.buttons["Apagar App"].firstMatch
        if deleteButton.waitForExistence(timeout: 5) {
            deleteButton.tap()
            springboard.alerts.buttons["Apagar"].tap()
        }
    }
    
}

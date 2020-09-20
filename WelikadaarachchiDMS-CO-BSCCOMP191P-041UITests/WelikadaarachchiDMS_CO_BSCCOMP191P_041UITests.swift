//
//  WelikadaarachchiDMS_CO_BSCCOMP191P_041UITests.swift
//  WelikadaarachchiDMS-CO-BSCCOMP191P-041UITests
//
//  Created by Mahima Sithuruwan on 9/10/20.
//  Copyright © 2020 Mahima Sithuruwan. All rights reserved.
//

import XCTest

class WelikadaarachchiDMS_CO_BSCCOMP191P_041UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInvalidLogin_CredentialsAlertShown() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Already have an account?"].tap()
        app.textFields["Email"].tap()
        app.secureTextFields["Password"].tap()
        app.buttons["Log In"].tap()

        let alertDialog = app.alerts["Log In"]

        XCTAssertTrue(alertDialog.exists)

        alertDialog.buttons["Ok"].tap()
        
        
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let validEmail = "852@gmail.com"
        let validPassword = "852852"
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Already have an account?"].tap()
        
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)

        app.textFields["Email"].tap()
        
        emailTextField.typeText(validEmail)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(validPassword)
        
        app.buttons["Log In"].tap()
        
      //  let map = app.maps["mapView"]
      //         XCTAssertTrue(map.exists)
        
        
// //XCTAssertTrue(app.maps["mapView"].exists)
//        let downloadCell = app.tables.staticTexts["My Downloads"]
//
//               let exists = NSPredicate(format: "exists == 1")
//
//               expectation(for: exists, evaluatedWith: downloadCell, handler: nil)
//               waitForExpectations(timeout: 5, handler: nil)
        
      //  let downloadCell =  app.textViews.staticTexts["All you need is"]
            
       // let exists = "All you need is"

      //  XCTAssertTrue(app.textViews.staticTexts["All you need is"].waitForExistence(timeout: 15))

       // expectation(for: exists, evaluatedWith: downloadCell, handler: nil)
      //        waitForExpectations(timeout: 10, handler: nil)
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

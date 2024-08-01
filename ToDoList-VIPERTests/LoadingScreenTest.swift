//
//  LoadingScreenTest.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 30.07.2024.
//

import XCTest
@testable import ToDoList_VIPER

final class LoadingScreenTest: XCTestCase {

    var loadingController: AnimationLoadingController!
    var loadingPresenter: AnimationLoadingPresenterProtocol!
    var loadingRouter: AnimationLoadingRouterProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        loadingController = AnimationLoadingController()
        loadingPresenter = AnimationLoadingPresenter()
        loadingRouter = AnimationLoadingRouter()
        loadingController.presenter = loadingPresenter
        loadingPresenter.view = loadingController
        loadingPresenter.router = loadingRouter
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        loadingController = nil
        loadingPresenter = nil
        loadingRouter = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssertIdentical(loadingController.presenter, loadingPresenter)
        XCTAssertIdentical(loadingPresenter.view, loadingController)
        XCTAssertIdentical(loadingPresenter.router, loadingRouter)

        XCTAssertNotNil(loadingController)
        XCTAssertNotNil(loadingPresenter)
        XCTAssertNotNil(loadingRouter)
        XCTAssertNoThrow(loadingPresenter.router?.goToTheApp(fromView: loadingController))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

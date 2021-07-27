//
//  GitDMAppTests.swift
//  GitDMAppTests
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import XCTest
@testable import GitDMApp
var presenter: UsersListPresenter!
var interactor = UsersInteractor()
class GitDMAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter  = UsersListPresenter()
        interactor = UsersInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        presenter.loadUsers(finished: {
            interactor.getAllUserFromServer { (users) in
                XCTAssert(users.count != 0)
            } finishedWithError: { (error) in
                print(error)
                XCTFail()
            }
        }) { (errorResponse) in
            print(errorResponse)
            XCTFail()
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

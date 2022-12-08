//
//  iOSAppTaskAndreiTancTests.swift
//  iOSAppTaskAndreiTancTests
//
//  Created by Andrei Tanc on 08.12.2022.
//

import XCTest
@testable import iOSAppTaskAndreiTanc

final class iOSAppTaskAndreiTancTests: XCTestCase {

    var apiService: ApiServiceMock!
    var coreDataManager: CoreDataManager!
    var dataLayer: DataLayer!
    
    override func setUpWithError() throws {
        super.setUp()
        apiService = ApiServiceMock()
        coreDataManager = CoreDataManagerMock()
        
        dataLayer = DataLayer(apiService: apiService, coreDataManager: coreDataManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_whenNewViewModel_shouldInitProperly() {
        let vm = TaskViewModel(dataLayer: dataLayer)
        
        XCTAssertTrue(vm.posts.isEmpty)
        XCTAssertTrue(!vm.shouldPresentAlert)
    }
    
    func test_whenRefreshing_shouldComePostsFromNetwork() {
        let vm = TaskViewModel(dataLayer: dataLayer)
        
        vm.refreshLogic()
        
        XCTAssertTrue(vm.posts.count == 4)
    }
}

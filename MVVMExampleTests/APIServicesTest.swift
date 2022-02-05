//
//  APIServicesTest.swift
//  MVVMExampleTests
//
//  Created by Mac on 1/31/22.
//

import XCTest
import Alamofire
import UIKit

@testable import MVVMExample

class APIServicesTest: XCTestCase {

    var sut:APIServices!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut=APIServices()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut=nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetDataSuccess() {

        // Given A apiservice
        let sut = self.sut!

        let expect = XCTestExpectation(description: "callback")
        var resposeError:Error?
        var responseSucess:ArticleModel?
        
        guard let bundle=Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("No Content")
            return
        }

        sut.getData(url: URL(fileURLWithPath: bundle), method:.get, params: nil, encoding: JSONEncoding.default, headers: nil, completion: { (articleModel:ArticleModel?,errorModel:ArticleModel? , error) in
            resposeError=error
            responseSucess=articleModel
            expect.fulfill()
            
        })

        wait(for: [expect], timeout:1)
        
        XCTAssertNil(resposeError)
        XCTAssertNotNil(responseSucess)
    }

    func testGetDataFail() {

        // Given A apiservice
        let sut = self.sut!

        let expect = XCTestExpectation(description: "callback")
        var resposeError:Error?
        var responseSucess:ArticleModel?
        
        guard let bundle=Bundle.unitTest.path(forResource: "stub_error", ofType: "json") else {
            XCTFail("No Content")
            return
        }

        sut.getData(url: URL(fileURLWithPath: bundle), method:.get, params: nil, encoding: JSONEncoding.default, headers: nil, completion: { (articleModel:ArticleModel?,errorModel:ArticleModel? , error) in
            resposeError=error
            responseSucess=articleModel
            expect.fulfill()
            
        })

        wait(for: [expect], timeout:1)
        
        XCTAssertNotNil(resposeError)
        XCTAssertNil(responseSucess)
    }
}

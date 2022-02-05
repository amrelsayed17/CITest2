//
//  MostPopularArticlesViewModelTest.swift
//  MVVMExampleTests
//
//  Created by Mac on 1/31/22.
//

import XCTest

@testable import MVVMExample

class MostPopularArticlesViewModelTest: XCTestCase {
    
    var viewModel:MostPopularArticlesViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel=MostPopularArticlesViewModel()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel=nil
        
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
    
    
    func testGetTotal()
    {
        viewModel.getTotal(x: 5, y: 10)
        XCTAssertEqual(viewModel.z, 15)
    }
    
    func testSetupCellViewModel()
    {
        viewModel.setupCellViewModel(data: [Result(uri: "", url: "", id: 0, assetID: 0, source: nil, publishedDate: "", updated: "", section: "", subsection: "", nytdsection: "", adxKeywords: "", column: "", byline: "", type: nil, title: nil, abstract: "", desFacet: nil, orgFacet: nil, perFacet: nil, geoFacet: nil, media: [Media(type: nil, subtype: nil, caption: "", copyright: "", approvedForSyndication: 0, mediaMetadata: nil)], etaID: 0),
                                            Result(uri: "", url: "", id: 0, assetID: 0, source: nil, publishedDate: "", updated: "", section: "", subsection: "", nytdsection: "", adxKeywords: "", column: "", byline: "", type: nil, title: nil, abstract: "", desFacet: nil, orgFacet: nil, perFacet: nil, geoFacet: nil, media: [], etaID: 0)])
        XCTAssertNotNil(viewModel.cell_data)
        XCTAssertEqual(viewModel.cell_data.count,2)
        
        let cell:DataListCellViewModel=viewModel.getCellModel(index: 0)
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell.titleText,viewModel.cell_data[0].titleText)
    }
    
    func testGetArticles()
    {
        guard let bundle=Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("No Content")
            return
        }
        viewModel.getArticlesData(url:URL(fileURLWithPath: bundle))
        XCTAssertNotNil(viewModel.cell_data)

    }
    
}

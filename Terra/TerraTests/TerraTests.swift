//
//  TerraTests.swift
//  TerraTests
//
//  Created by Anthony Gonzalez on 1/26/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import XCTest
@testable import Terra

class TerraTests: XCTestCase {
    
    func testSpeciesJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "speciesModelTestData", withExtension: "json") else {
            XCTFail("Missing file: speciesModelTestaData.json")
            return
        }
        
        let jsonData = try Data(contentsOf: url)
        let animal: Species = try JSONDecoder().decode(Species.self, from: jsonData)
        
        XCTAssertEqual(animal.commonName, "African Elephant")
    }
    
    func testNewsResponseJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "newsResponseTestData", withExtension: ".json") else {
            XCTFail("Missing file: newsResponseTestData")
            return
        }
        
        let jsonData = try Data(contentsOf: url)
        
        do {
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
            XCTAssertGreaterThan(newsResponse.articles!.count, 0)
        } catch {
            XCTFail("Decoding error: \(error)")
        }
    }
    
 
    
    func testFactoryLabelWorks() {
        let labelTitle = "ASDF"
        let label = Factory.makeLabel(title: labelTitle,
                                      fontWeight: .bold,
                                      fontSize: 15, widthAdjustsFontSize: <#Bool#>,
                                      color: .white,
                                      alignment: .left)
        XCTAssert(label.text == labelTitle,
                  "Factory method not assigning title correctly")
    }
    
    func testISO8601Formatter() {
        
        let testNewsArticle = NewsArticle(title: "",
                                          url: "",
                                          urlToImage: "",
                                          publishedAt: "2020-08-08T00:33:22Z")
        
        
        XCTAssertEqual(testNewsArticle.publishedAt, "Aug 7 2020, 8:33 PM", "Expected 'Aug 7 2020, 8:33 PM', but returned '\(testNewsArticle.publishedAt)' instead")
    }
    
    func testRemovingNonAlphabetCharsExtension() {
        let testString = "Jurong Bird Park's conservation breeding efforts soar with more than 100 new hatchlings!"
        
        let expectedString = "jurongbirdparksconservationbreedingeffortssoarwithmorethannewhatchlings"
        
        XCTAssertEqual(testString.lowercaseAlphaNumericsOnly,  expectedString,
                       "Expected '\(expectedString)', but returned '\(testString.lowercaseAlphaNumericsOnly)' instead")
    }
    
//    func testNewsArticleDuplicateRemoval() {
//        func filterDuplicateArticles(from news: [NewsArticle]) -> [NewsArticle] {
//            var seenHeadlines = Set<String>()
//            
//            return news.compactMap { (newsArticle) in
//                guard !seenHeadlines.contains(newsArticle.cleanedUpTitle)
//                    else { return nil }
//                seenHeadlines.insert(newsArticle.cleanedUpTitle)
//                return newsArticle
//            }
//        }
//        
//        let testNewsArticleTitle = "Washington state officials slam Navy's changes to military testing program that would harm more orcas"
//        
//        let testNewsArticleArray: [NewsArticle] = [
//            NewsArticle(title: testNewsArticleTitle,
//                        url: "",
//                        urlToImage: "",
//                        publishedAt: ""),
//            
//            NewsArticle(title: testNewsArticleTitle,
//                        url: "",
//                        urlToImage: "",
//                        publishedAt: ""),
//            
//            NewsArticle(title: testNewsArticleTitle,
//                        url: "",
//                        urlToImage: "",
//                        publishedAt: ""),
//            
//            NewsArticle(title: testNewsArticleTitle,
//                        url: "",
//                        urlToImage: "",
//                        publishedAt: ""),
//            
//            NewsArticle(title: testNewsArticleTitle,
//                        url: "",
//                        urlToImage: "",
//                        publishedAt: ""),
//            
//            NewsArticle(title: testNewsArticleTitle,
//                        url: "",
//                        urlToImage: "",
//                        publishedAt: "")
//        ]
//        
//        var testNewsArrayWithFilterMethod: [NewsArticle] {
//            return filterDuplicateArticles(from: testNewsArticleArray)
//        }
//        
//        let testNewsArrayFilteredCount = testNewsArrayWithFilterMethod.filter{ $0.title == testNewsArticleTitle }.count
//        
//        XCTAssertEqual(testNewsArrayFilteredCount, 1,
//                       "Expected only 1 article to have this title, but returned \(testNewsArrayFilteredCount) instead")
//    }
    
    
    func testSpeciesRedListCategoryFilter() {
        
    }
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

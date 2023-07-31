//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Ahzam Ghori on 31/07/2023.
//

import XCTest
@testable import MovieApp

final class MovieAppTests: XCTestCase {
    
  override class func setUp() {
      if UserDefaults.standard.object(forKey: "title") != nil {
          XCTAssert(true, "Title Exist")
      }
       
     else  if UserDefaults.standard.object(forKey: "image") != nil {
          XCTAssert(true, "Image Exist")
      }
      
     else if UserDefaults.standard.object(forKey: "vote") != nil {
          XCTAssert(true, "Vote Exist")
      }
      
     else if UserDefaults.standard.object(forKey: "release") != nil {
          XCTAssert(true, "Release Exist")
      }
      
      else {
          XCTAssert(false, "No value Exist")
      }
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
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

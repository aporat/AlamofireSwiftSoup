//
//  ProgressToolbarTests.swift
//  ProgressToolbarTests
//
//  Created by Adar Porat on 8/24/20.
//  Copyright © 2020 Adar Porat. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireSwiftSoup

class AlamofireSwiftSoupTests: XCTestCase {
    
    func testExample() throws {
        AF.request("https://httpbin.org/").responseSwiftSoupHTML { dataResponse in
            switch dataResponse.result {
            case .failure(let error):
                debugPrint(error)
            case .success(let document):
                if let scriptElement = try? document.select("title").first(), let titleString = try? scriptElement.html() {
                    debugPrint(titleString)
                }
            }
        }
    }
    
    
}

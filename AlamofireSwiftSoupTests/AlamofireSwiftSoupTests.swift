//
//  ProgressToolbarTests.swift
//  ProgressToolbarTests
//
//  Created by Adar Porat on 8/24/20.
//  Copyright © 2020 Adar Porat. All rights reserved.
//

import Alamofire
@testable import AlamofireSwiftSoup
import XCTest

class AlamofireSwiftSoupTests: XCTestCase {
    func testExample() throws {
        AF.request("https://httpbin.org/").responseSwiftSoupHTML { dataResponse in
            switch dataResponse.result {
            case let .failure(error):
                debugPrint(error)
            case let .success(document):
                if let scriptElement = try? document.select("title").first(), let titleString = try? scriptElement.html() {
                    debugPrint(titleString)
                }
            }
        }
    }
}

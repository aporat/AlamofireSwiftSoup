import Alamofire
@testable import AlamofireSwiftSoup
import Foundation
import SwiftSoup
import Testing

struct AlamofireSwiftSoupTests {
    let serializer = SwiftSoupHTMLResponseSerializer()

    @Test func parsesHTMLDocument() throws {
        let html = "<html><head><title>Test</title></head><body><p>Hello</p></body></html>"
        let data = html.data(using: .utf8)

        let document = try serializer.serialize(request: nil, response: nil, data: data, error: nil)

        #expect(try document.title() == "Test")
        #expect(try document.select("p").text() == "Hello")
    }

    @Test func throwsOnNilData() {
        #expect(throws: AFError.self) {
            try serializer.serialize(request: nil, response: nil, data: nil, error: nil)
        }
    }

    @Test func throwsOnEmptyData() {
        #expect(throws: AFError.self) {
            try serializer.serialize(request: nil, response: nil, data: Data(), error: nil)
        }
    }

    @Test func throwsOnPassedError() {
        let error = URLError(.badServerResponse)
        #expect(throws: URLError.self) {
            try serializer.serialize(request: nil, response: nil, data: nil, error: error)
        }
    }

    @Test func respectsResponseEncoding() throws {
        let html = "<html><body>Héllo</body></html>"
        let data = html.data(using: .utf8)
        let url = URL(string: "https://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "text/html; charset=utf-8"])

        let document = try serializer.serialize(request: nil, response: response, data: data, error: nil)

        #expect(try document.body()?.text() == "Héllo")
    }

    @Test func parsesWithExplicitEncoding() throws {
        let html = "<html><body>Test</body></html>"
        let data = html.data(using: .isoLatin1)
        let serializer = SwiftSoupHTMLResponseSerializer(encoding: .isoLatin1)

        let document = try serializer.serialize(request: nil, response: nil, data: data, error: nil)

        #expect(try document.body()?.text() == "Test")
    }
}

import Alamofire
import Foundation
import SwiftSoup

extension Document: @retroactive @unchecked Sendable {}

public final class SwiftSoupHTMLResponseSerializer: ResponseSerializer, Sendable {
    public let dataPreprocessor: DataPreprocessor
    public let emptyResponseCodes: Set<Int>
    public let emptyRequestMethods: Set<HTTPMethod>
    public let encoding: String.Encoding?

    public init(dataPreprocessor: DataPreprocessor = SwiftSoupHTMLResponseSerializer.defaultDataPreprocessor,
                encoding: String.Encoding? = nil,
                emptyResponseCodes: Set<Int> = SwiftSoupHTMLResponseSerializer.defaultEmptyResponseCodes,
                emptyRequestMethods: Set<HTTPMethod> = SwiftSoupHTMLResponseSerializer.defaultEmptyRequestMethods)
    {
        self.dataPreprocessor = dataPreprocessor
        self.encoding = encoding
        self.emptyResponseCodes = emptyResponseCodes
        self.emptyRequestMethods = emptyRequestMethods
    }

    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> Document {
        guard error == nil else { throw error! }

        guard var data = data, !data.isEmpty else {
            guard emptyResponseAllowed(forRequest: request, response: response) else {
                throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
            }

            return try SwiftSoup.parse("")
        }

        data = try dataPreprocessor.preprocess(data)

        var convertedEncoding = encoding

        if let encodingName = response?.textEncodingName as CFString?, convertedEncoding == nil {
            let ianaCharSet = CFStringConvertIANACharSetNameToEncoding(encodingName)
            let nsStringEncoding = CFStringConvertEncodingToNSStringEncoding(ianaCharSet)
            convertedEncoding = String.Encoding(rawValue: nsStringEncoding)
        }

        let actualEncoding = convertedEncoding ?? .isoLatin1

        guard let string = String(data: data, encoding: actualEncoding) else {
            throw AFError.responseSerializationFailed(reason: .stringSerializationFailed(encoding: actualEncoding))
        }

        do {
            return try SwiftSoup.parse(string)
        } catch {
            throw AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))
        }
    }
}

extension DataRequest {
    @discardableResult
    public func responseSwiftSoupHTML(queue: DispatchQueue = .main,
                                      encoding: String.Encoding? = nil,
                                      completionHandler: @escaping @Sendable (AFDataResponse<Document>) -> Void) -> Self
    {
        response(queue: queue,
                 responseSerializer: SwiftSoupHTMLResponseSerializer(encoding: encoding),
                 completionHandler: completionHandler)
    }

    public func serializingSwiftSoupHTML(encoding: String.Encoding? = nil) -> DataTask<Document> {
        serializingResponse(using: SwiftSoupHTMLResponseSerializer(encoding: encoding))
    }
}

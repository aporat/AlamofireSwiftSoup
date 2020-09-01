import Foundation
import Alamofire
import SwiftSoup

public final class SwiftSoupHTMLResponseSerializer: ResponseSerializer {
    public let dataPreprocessor: DataPreprocessor
    public let emptyResponseCodes: Set<Int>
    public let emptyRequestMethods: Set<HTTPMethod>
    /// Optional string encoding used to validate the response.
    public let encoding: String.Encoding?
    
    /// Creates an instance with the provided values.
    ///
    /// - Parameters:
    ///   - dataPreprocessor:    `DataPreprocessor` used to prepare the received `Data` for serialization.
    ///   - encoding:            A string encoding. Defaults to `nil`, in which case the encoding will be determined
    ///                          from the server response, falling back to the default HTTP character set, `ISO-8859-1`.
    ///   - emptyResponseCodes:  The HTTP response codes for which empty responses are allowed. `[204, 205]` by default.
    ///   - emptyRequestMethods: The HTTP request methods for which empty responses are allowed. `[.head]` by default.
    public init(dataPreprocessor: DataPreprocessor = SwiftSoupHTMLResponseSerializer.defaultDataPreprocessor,
                encoding: String.Encoding? = nil,
                emptyResponseCodes: Set<Int> = SwiftSoupHTMLResponseSerializer.defaultEmptyResponseCodes,
                emptyRequestMethods: Set<HTTPMethod> = SwiftSoupHTMLResponseSerializer.defaultEmptyRequestMethods) {
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
    /// Adds a handler to be called once the request has finished.
    ///
    /// - Parameters:
    ///   - queue:             The queue on which the completion handler is dispatched. `.main` by default.
    ///   - encoding:            A string encoding. Defaults to `nil`, in which case the encoding will be determined
    ///                          from the server response, falling back to the default HTTP character set, `ISO-8859-1`.
    ///   - completionHandler: A closure to be executed once the request has finished.
    ///
    /// - Returns:             The request.
    @discardableResult
    public func responseSwiftSoupHTML(queue: DispatchQueue = .main,
                                      encoding: String.Encoding? = nil,
                                      completionHandler: @escaping (AFDataResponse<Document>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: SwiftSoupHTMLResponseSerializer(encoding: encoding),
                        completionHandler: completionHandler)
    }
}

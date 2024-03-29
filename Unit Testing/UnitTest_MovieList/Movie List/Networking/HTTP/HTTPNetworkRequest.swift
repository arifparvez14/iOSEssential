//
//  HTTPNetworkRequest.swift
//  Movie List
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {

    /// Set the body, method, headers, and paramaters of the request
    static func configureHTTPRequest(from route: HTTPNetworkRoute,
                                     with parameters: HTTPParameters,
                                     includes headers: HTTPHeaders,
                                     contains body: Data?,
                                     and method: HTTPMethod) throws -> URLRequest {

        let urlString = "\(baseURL)\(route.rawValue)"
        guard let url = URL(string: urlString) else {
            Log.info("[Error] URL Missing")
            throw HTTPNetworkError.missingURL
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeOutInterval)

        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        Log.info("[URL]: \(String(describing: request.url))")
        return request
    }

    /// Configure the request parameters and headers before the API Call
    static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                              headers: HTTPHeaders?,
                                              request: inout URLRequest) throws {

        do {
            if let headers = headers {
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
            if let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
            }
        } catch {
            Log.info("[Error] Header/Footer encoding failed")
            throw HTTPNetworkError.encodingFailed
        }
    }
}

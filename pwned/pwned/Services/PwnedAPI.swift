//
//  PwnedAPI.swift
//  pwned
//
//  Created by Josep Gonzalez Fernandez on 17/7/17.
//  Copyright © 2017 Dreams Corner. All rights reserved.
//

import Foundation
import Social
import RxSwift
import RxCocoa
import RxAlamofire

typealias JSONObject = [String: Any]

protocol PwnedAPIProtocol {
    static func breaches(of email: String) -> Observable<[JSONObject]>
}

struct PwnedAPI: PwnedAPIProtocol {
    // MARK: - API Addresses
    fileprivate enum Address: String {
        case breachAccount = "breachedaccount/"
        case breach = "breach/"
        case listBreaches = "breaches"
        case listDataClasses = "dataclasses"
        
        private var baseURL: String { return "https://haveibeenpwned.com/api/v2/" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }
    
    // MARK: - API errors
    enum Errors: Error {
        case requestFailed
        case badResponse
        case httpError(Int)
    }
    
    // MARK: - API Endpoint Requests
    static func breaches(of email: String) -> Observable<[JSONObject]> {
        return request(PwnedAPI.Address.breachAccount, pathInfo: email)
    }
    
    // MARK: - generic request to send an SLRequest
    static private func request<T: Any>(_ address: Address, pathInfo: String = "", parameters: [String: String] = [:]) -> Observable<T> {
        return Observable.create { observer in
            
            guard let request = SLRequest(
                forServiceType: SLServiceTypeTwitter,
                requestMethod: .GET,
                url: URL(string: "\(address.url.absoluteString)\(pathInfo)")!,
                parameters: parameters
                ) else {
                    observer.onError(Errors.requestFailed)
                    return Disposables.create()
            }
            
            request.perform {data, response, error in
                if let error = error {
                    observer.onError(error)
                }
                if let response = response, response.statusCode >= 400 && response.statusCode < 600 {
                    observer.onError(Errors.httpError(response.statusCode))
                }
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? T, let result = json {
                    observer.onNext(result)
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}

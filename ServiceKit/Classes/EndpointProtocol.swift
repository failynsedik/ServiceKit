//
//  EndpointProtocol.swift
//  ServiceKit
//
//  Created by Failyn Kaye Sedik on 5/25/22.
//

import Foundation

public enum EndpointRequestMethod: String {
	case get = "GET"
	case post = "POST"
}

public protocol EndpointProtocol {
	var host: String { get }
	var path: String { get }
	var httpMethod: EndpointRequestMethod { get }
	var parameters: [String: Any] { get }
	var headers: [String: String] { get }
}

extension EndpointProtocol {
	public var urlComponents: URLComponents {
		var components = URLComponents()
		components.scheme = "https"
		components.host = host
		components.path = path
		
		var queryItems = [URLQueryItem]()
		for (key, value) in parameters {
			queryItems.append(URLQueryItem(name: key, value: "\(value)"))
		}
		components.queryItems = queryItems
		
		return components
	}
	
	public var request: URLRequest {
		guard let url = urlComponents.url else {
			preconditionFailure("Invalid URL components: \(urlComponents)")
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue
		
		for (key, value) in headers {
			request.setValue(value, forHTTPHeaderField: key)
		}
		
		return request
	}
}
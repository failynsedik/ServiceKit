//
//  UserEndpoint.swift
//  ServiceKit_Example
//
//  Created by Failyn Kaye Sedik on 5/25/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import ServiceKit

/// NOTE: Should hold endpoints related to users
enum UserEndpoint {
	/// - Parameters:
	///   - since: A user ID. Only return users with an ID greater than this ID.
	///   - limit: Results per page (max 100). If `nil`, the default will be **30**.
	case getUsers(since: Int, limit: Int?)
}

extension UserEndpoint: EndpointProtocol {
	var host: String { "api.github.com" }
	
	var path: String {
		switch self {
		case .getUsers: return "/users"
		}
	}
	
	var httpMethod: EndpointRequestMethod {
		switch self {
		case .getUsers: return .get
		}
	}
	
	var parameters: [String: Any] {
		switch self {
		case let .getUsers(since, limit):
			var parameters: [String: Any] = [:]
			parameters["since"] = since
			
			if let limit = limit {
				parameters["per_page"] = limit
			}
			
			return parameters
		}
	}
	
	var headers: [String: String] {
		[
			"Content-Type": "application/json",
			"Accept": "application/vnd.github.v3+json",
		]
	}
}

//
//  ViewController.swift
//  ServiceKit
//
//  Created by failynsedik on 05/25/2022.
//  Copyright (c) 2022 failynsedik. All rights reserved.
//

import ServiceKit
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
		getUsers()
    }

	private func getUsers() {
		let serviceKit = ServiceKit(endpoint: UserEndpoint.getUsers(since: 0, limit: 10))
		
		Task {
			let users = await serviceKit.request(responseType: [UserListResponse].self)
			dump(users)
		}
	}
}


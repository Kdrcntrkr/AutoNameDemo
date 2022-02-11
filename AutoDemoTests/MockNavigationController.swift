//
//  MockNavigationController.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import UIKit

class MockNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}


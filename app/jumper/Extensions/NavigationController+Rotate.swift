//
//  NavigationController+Rotate.swift
//  Jumper
//
//  Created by arabian9ts on 2019/08/24.
//  Copyright © 2019 arabian9ts. All rights reserved.
//

// https://qiita.com/usayuki/items/38ed20b27dcc09c24cba

import UIKit

extension UINavigationController {
    open override var shouldAutorotate: Bool {
        guard let viewController = self.visibleViewController else { return true }
        return viewController.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let viewController = self.visibleViewController else { return .all }
        return viewController.supportedInterfaceOrientations
    }
}

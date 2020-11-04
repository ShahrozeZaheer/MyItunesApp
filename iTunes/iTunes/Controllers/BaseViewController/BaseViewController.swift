//
//  BaseViewController.swift
//   
//
//  Created by Afroz on 26/02/2019.
//  Copyright © 2019 Etisalat. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    var colorScheme = NavigationBarColorScheme.light

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }

    func setupAppearance() {
//        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _applyTheme()
    }

    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            _applyBackTheme()
            super.willMove(toParent: parent)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// Navigation Bar
extension BaseViewController {
    private func _applyTheme() {
        if let navController = navigationController as? BaseNavigationController {
            navController.colorScheme = colorScheme
        }
    }

    private func _applyBackTheme() {
        if let viewControllers = navigationController?.viewControllers {
            if viewControllers.count > 1 {
                if let vc = viewControllers[viewControllers.count - 2] as? BaseViewController, let navController = navigationController as? BaseNavigationController {
                    navController.colorScheme = vc.colorScheme
                }
            }
        }
    }
}

//
//  BaseNavigationController.swift
//   
//
//  Created by Afroz on 12/03/2019.
//  Copyright © 2019 Etisalat. All rights reserved.
//

import UIKit

enum NavigationBarColorScheme: Int {
    case none
    case light
    case dark
    case transparentWhite
}

extension NavigationBarColorScheme {
    var forgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor.white

        case .dark:
            return UIColor.black

        case .transparentWhite:
            return UIColor.white

        case .none:
            return UIColor.clear
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .light:
            return UIColor.white

        case .dark:
            return UIColor.black

        case .transparentWhite:
            return UIColor.clear

        case .none:
            return UIColor.clear
        }
    }

    var translucent: Bool {
        switch self {
        case .light:
            return false

        case .dark:
            return false

        case .transparentWhite:
            return true

        case .none:
            return false
        }
    }
}

enum NavigationBarType: Int {
    case cross
    case dots
    case dashboard
    case registration
    case hidden
    case profile
    case dashboardNotification
    case none = -1
}

class BaseNavigationController: UINavigationController {
    // MARK: - Properties

    // __________________________________________________________________________________
    //
    var rightItem: UIBarButtonItem?
    var leftItem: UIBarButtonItem?
    var colorScheme: NavigationBarColorScheme = .light {
        didSet {
            if colorScheme != oldValue {
                updateColorScheme()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch colorScheme {
        case .dark:
            return .lightContent
        default:
            return .default
        }
    }

    var type: NavigationBarType = .none

    // MARK: - Constructors

    // __________________________________________________________________________________
    //
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    init(rootViewController: UIViewController?, colorScheme: NavigationBarColorScheme) {
        if let rootVC = rootViewController {
            super.init(rootViewController: rootVC)
        } else {
            super.init()
        }
        self.colorScheme = colorScheme
    }

    init(rootViewController: UIViewController?, colorScheme: NavigationBarColorScheme, type: NavigationBarType) {
        if let rootVC = rootViewController {
            super.init(rootViewController: rootVC)
        } else {
            super.init()
        }
        self.colorScheme = colorScheme
        self.type = type
    }

    // MARK: - Life Cycle

    // __________________________________________________________________________________
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupAppearance()
    }

    fileprivate func _setupAppearance() {
        // Remove Shadow
        navigationBar.shadowImage = UIImage()

        // Remove Background
        navigationBar.setBackgroundImage(UIImage(), for: .default)

        view.backgroundColor = UIColor.clear
        
//        NotificationCenter.default.addObserver(forName: NSLocale.currentLocaleDidChangeNotification, object: nil, queue: nil) { _ in
//            self.changeDirection()
//        }

        
        // Back Button
        _setupBackButton()

        // Color Scheme
        updateColorScheme()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Helper methods

    // __________________________________________________________________________________
    //

    
    func showNavigationBar(animated: Bool) {
        setNavigationBarHidden(false, animated: animated)
    }

    func hideNavigationBar(animated: Bool) {
        setNavigationBarHidden(true, animated: animated)
    }

    func hideLeftItemFor(viewController: UIViewController?) {
        if viewController != nil {
            viewController?.navigationItem.leftBarButtonItem = nil
            viewController?.navigationItem.setHidesBackButton(true, animated: false)
        }
    }

    func showLeftItemFor(viewController: UIViewController?) {
        if let lItem = leftItem, let vc = viewController {
            vc.navigationItem.leftBarButtonItem = lItem
        }
    }

    func hideRightItemFor(viewController: UIViewController?) {
        if let vc = viewController {
            vc.navigationItem.rightBarButtonItem = nil
        }
    }

    func showRightItemFor(viewController: UIViewController?) {
        if let rItem = rightItem, let vc = viewController {
            vc.navigationItem.rightBarButtonItem = rItem
        }
    }

    // MARK: - Back Button

    // __________________________________________________________________________________
    //
    fileprivate func _setupBackButton() {
        // Set back image
        
        var backButtonBackgroundImage = UIImage(named: "back")!
        backButtonBackgroundImage = backButtonBackgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: backButtonBackgroundImage.size.width - 1, bottom: 0, right: 0))
        let barAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [BaseNavigationController.self])
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton

        // Hide back button text
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -10000, vertical: 0), for: .default)
    }

    // MARK: - Color Scheme

    // __________________________________________________________________________________
    //
    func updateColorScheme() {
        if colorScheme == .none {
            hideNavigationBar(animated: true)
            return
        }
        showNavigationBar(animated: true)
        _setupBackgroundAppearance()
        _setupForgroundAppearance()
    }

    fileprivate func _setupBackgroundAppearance() {
        navigationBar.isTranslucent = colorScheme.translucent
        self.navigationBar.barTintColor = self.colorScheme.backgroundColor
        self.navigationBar.layoutIfNeeded()

//        UIView.animate(withDuration: 0.7, animations: {
//            self.navigationBar.barTintColor = self.colorScheme.backgroundColor
//        }) { (complete) in
//            if complete {
//                self.navigationBar.layoutIfNeeded()
//            }
//        }
    }

    fileprivate func _setupForgroundAppearance() {
        // Set title appearance
        let color = colorScheme.forgroundColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)
        ]

        navigationBar.tintColor = color
        _refreshColorScheme(with: color)
    }

    fileprivate func _refreshColorScheme(with color: UIColor?) {
        DispatchQueue.main.async(execute: {
            for view: UIView in self.navigationBar.subviews {
                let subviews = view.subviews
                for subview: UIView in subviews {
                    if subview.self is UILabel {
                        if let color = color {
                            (subview as? UILabel)?.textColor = color
                        }
                    }
                }
            }
        })
    }
}

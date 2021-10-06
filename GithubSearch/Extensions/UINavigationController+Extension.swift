//
//  UINavigationController+Extension.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/05.
//

import Foundation
import UIKit

protocol NavigationControllerProtocol {
    func push<T>(nibName: String,
                 type: T.Type,
                 animated: Bool,
                 dependency: ((T)->Void)?) where T: UIViewController
    
    func push<T>(storyBoard: String,
                 identifier: String,
                 type: T.Type,
                 animated: Bool,
                 dependency: ((T)->Void)?) where T: UIViewController
    
    func present<T>(nibName: String,
                    type: T.Type,
                    animated: Bool,
                    dependency: ((T)->Void)?,
                    completion: (()->Void)?) where T: UIViewController
    
    func present<T>(storyBoard: String,
                    identifier: String,
                    type: T.Type,
                    animated: Bool,
                    dependency: ((T)->Void)?,
                    completion: (()->Void)?) where T: UIViewController
}

extension UINavigationController: NavigationControllerProtocol {
    
    func push<T>(nibName: String,
                 type: T.Type,
                 animated: Bool,
                 dependency: ((T)->Void)? = nil) where T: UIViewController {
        let vc = T.init(nibName: nibName, bundle: nil)
        dependency?(vc)
        self.pushViewController(vc, animated: animated)
    }
    
    func push<T>(storyBoard: String,
                 identifier: String,
                 type: T.Type,
                 animated: Bool,
                 dependency: ((T)->Void)? = nil) where T: UIViewController {
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier) as! T
        dependency?(vc)
        self.pushViewController(vc,
                                animated: animated)
    }
    
    func present<T>(nibName: String,
                    type: T.Type,
                    animated: Bool,
                    dependency: ((T)->Void)? = nil,
                    completion: (()->Void)? = nil) where T: UIViewController {
        let vc = T.init(nibName: nibName, bundle: nil)
        dependency?(vc)
        self.present(vc,
                     animated: animated,
                     completion: completion)
    }
    
    func present<T>(storyBoard: String,
                    identifier: String,
                    type: T.Type,
                    animated: Bool,
                    dependency: ((T)->Void)? = nil,
                    completion: (()->Void)? = nil) where T: UIViewController {
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier) as! T
        dependency?(vc)
        self.present(vc,
                     animated: animated,
                     completion: completion)
    }
    
}

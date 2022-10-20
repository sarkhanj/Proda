//
//  ContainerVC.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/17/22.
//

import UIKit

protocol menuButtonAnimated {
    func animate()
}

class ContainerVC: UIViewController {
    
    
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed

    let menuVC = MenuVC()
    let tasksVC = TasksVC()
    var navVC: UINavigationController?
    var delegate: menuButtonAnimated?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVCs()
    }
    
    func addChildVCs() {
        // MenuVC
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // TasksVC
        tasksVC.delegate = self
        tasksVC.title = "Tasks"
        let navVC = UINavigationController(rootViewController: tasksVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        navVC.navigationBar.tintColor = .systemBlue
        self.navVC = navVC
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            print("touched outside of menu")
            let touch = touches.first
            if touch?.view != self.menuVC {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                    
                    self.navVC?.view.frame.origin.x = 0
                    self.delegate?.animate()
                }completion: { done in
                    if done {
                        self.menuState = .closed
                    }
                }
            }
            
        }


}


extension ContainerVC: TasksVCDelegate {
    func didTapMenuButton() {
        print("getting call")
        switch menuState {
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = self.tasksVC.view.frame.size.width - 100
                self.delegate?.animate()
            }completion: { done in
                if done {
                    self.menuState = .opened
                }
            }
        case .opened:
            // close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = 0
                self.delegate?.animate()
            }completion: { done in
                if done {
                    self.menuState = .closed
                }
            }
        }
    }
}

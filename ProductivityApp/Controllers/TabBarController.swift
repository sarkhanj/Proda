//
//  TabBarController.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/13/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
//        UITabBar.appearance().backgroundColor = .systemGray6

        viewControllers = [createTasksNavigationController(), createCalendarNavigationController(), createMeditationNavigationController()]
        
    }
    
    func createTasksNavigationController() -> UIViewController {
        let containerVC = ContainerVC()
//        let tasksVC = TasksVC()
//        tasksVC.title = "Tasks"
//        tasksVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        containerVC.delegate = self
        containerVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        return containerVC
    }
    
    func createCalendarNavigationController() -> UINavigationController {
        let calendarVC = CalendarVC()
        calendarVC.title = "Calendar"
        calendarVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        return UINavigationController(rootViewController: calendarVC)
    }
    
    func createMeditationNavigationController() -> UINavigationController {
        let meditationVC = MeditationVC()
        meditationVC.title = "Meditation"
        meditationVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        return UINavigationController(rootViewController: meditationVC)
    }
    
    

}

extension TabBarController: menuButtonAnimated {
    func animate() {
        print("animating tabbar")
        switch menuState {
        case .closed:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                if let containerVC = self.viewControllers?[0] as? ContainerVC {
                    self.tabBar.frame.origin.x = containerVC.tasksVC.view.frame.size.width - 100
                }
                
                
            }completion: { done in
                if done {
                    self.menuState = .opened
                }
            }
        case .opened:
            // close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.tabBar.frame.origin.x = 0
                
            }completion: { done in
                if done {
                    self.menuState = .closed
                }
            }
        }
    }
    
    
}

//
//  SceneDelegate.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 01.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = makeRootViewController()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}


extension SceneDelegate {
    private func makeRootViewController() -> UITabBarController {

        let habitsVC = HabitsViewController()
        let notesVC = NotesViewController()
        let infoVC = InfoViewController()

        let habitsNavBarVC = UINavigationController(rootViewController: habitsVC)
        let notesNavBarVC = UINavigationController(rootViewController: notesVC)
        let infoNavBarVC = UINavigationController(rootViewController: infoVC)
        
        setSettings(forViewControllers: habitsVC, infoVC, notesVC)
        
        let rootTabBarController = UITabBarController()
        rootTabBarController.viewControllers = [habitsNavBarVC, notesNavBarVC, infoNavBarVC]
        
        setSettings(forTabBarController: rootTabBarController)
        
        return rootTabBarController
    }
    
    private func setSettings(forTabBarController tabBarController: UITabBarController) {
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        tabBarController.tabBar.tintColor = .purple
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barStyle = .default
    }
    
    private func setSettings(forViewControllers viewControllers: UIViewController...) {
        viewControllers.forEach{ viewController in
            if viewController is HabitsViewController {
                viewController.tabBarItem.image = UIImage(systemName: "rectangle.split.1x2.fill")
                viewController.tabBarItem.title = "Сегодня"
            } else if viewController is NotesViewController {
                viewController.tabBarItem.image =  UIImage(systemName: "list.bullet.rectangle.fill")
                viewController.tabBarItem.title = "Заметки"
            } else if viewController is InfoViewController {
                viewController.tabBarItem.image =  UIImage(systemName: "info.square.fill")
                viewController.tabBarItem.title = "Информация"
            }
        }
    }
}

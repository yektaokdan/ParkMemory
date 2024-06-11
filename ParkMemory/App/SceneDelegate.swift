import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let mapViewModel = MapVM()
        let mapViewVC = MapViewVC(viewModel: mapViewModel)
        
        let settingsViewVC = SettingsViewVC()
        
        window.rootViewController = createTabbar(mapViewVC: mapViewVC, settingsViewVC: settingsViewVC)
        
        window.makeKeyAndVisible()
        configureNavigationBar()
        self.window = window
    }

    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    func createMapViewVC(mapViewVC: MapViewVC) -> UINavigationController {
        mapViewVC.title = "Map"
        mapViewVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "mappin.and.ellipse"), tag: 0)
        return UINavigationController(rootViewController: mapViewVC)
    }

    func createSettingsNC(settingsViewVC: SettingsViewVC) -> UINavigationController {
        settingsViewVC.title = "Settings"
        settingsViewVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        return UINavigationController(rootViewController: settingsViewVC)
    }

    func createTabbar(mapViewVC: MapViewVC, settingsViewVC: SettingsViewVC) -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGray
        UITabBar.appearance().backgroundColor = UIColor.systemGray6.withAlphaComponent(0.8)

        tabbar.viewControllers = [createMapViewVC(mapViewVC: mapViewVC), createSettingsNC(settingsViewVC: settingsViewVC)]
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

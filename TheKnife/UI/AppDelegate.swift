import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var mainController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        buildMainController()
        window?.rootViewController = mainController
        window?.makeKeyAndVisible()
        return true
    }
    
    private func buildMainController() {
        let restaurantsModel = RestaurantsListViewModel(restaurantsStore: RestaurantsRestStore(),
                                                        favoritesStore: FavoritesDefaultsStore()
        )
        
        let restaurantsController = RestaurantsListController()
        restaurantsController.vm = restaurantsModel
        
        mainController = MainController(rootViewController: restaurantsController)
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }

}

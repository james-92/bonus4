import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 當應用程式的場景（Scene）即將連接時會呼叫此方法。
        // 您可以在此方法中選擇性地配置並將 UIWindow（視窗）附加到提供的 UIWindowScene。
        // 如果使用 Storyboard，`window` 屬性將自動初始化並附加到場景。
        // 此方法不代表連接的場景或會話是新的（請參考 `application:configurationForConnectingSceneSession`）。
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 當系統釋放場景時會呼叫此方法。
        // 這通常發生在場景進入背景後，或者場景的會話被捨棄時。
        // 在此方法中釋放與場景相關的任何資源，以便下次場景重新連接時可以重新創建。
        // 場景可能會重新連接，因此不要在此處做永久性的清理。
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 當場景從非活動狀態轉為活動狀態時會呼叫此方法。
        // 可以在此方法中重啟在場景非活動狀態時暫停（或尚未啟動）的任務。
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // 當場景從活動狀態轉為非活動狀態時會呼叫此方法。
        // 這可能發生在暫時的中斷（例如接收到來電）時。
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 當場景從背景轉回前景時會呼叫此方法。
        // 可以在此方法中撤銷進入背景時所做的更改。
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // 當場景從前景轉入背景時會呼叫此方法。
        // 可以在此方法中保存資料、釋放共用資源，並存儲足夠的場景狀態信息，
        // 以便將場景恢復到其當前狀態。
    }
}

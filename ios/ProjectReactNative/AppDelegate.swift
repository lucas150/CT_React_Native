import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider
import CleverTapReact
import UserNotifications
import CoreLocation
import CleverTapSDK

@main
class AppDelegate: RCTAppDelegate, UNUserNotificationCenterDelegate {
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    self.moduleName = "ProjectReactNative"
    self.dependencyProvider = RCTAppDependencyProvider()
    self.initialProps = [:]
    // Integrate CleverTap SDK
    CleverTap.autoIntegrate()
    CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
   // register category with actions
     let action1 = UNNotificationAction(identifier: "action_1", title: "Back", options: [])
     let action2 = UNNotificationAction(identifier: "action_2", title: "Next", options: [])
     let action3 = UNNotificationAction(identifier: "action_3", title: "View In App", options: [])
     let category = UNNotificationCategory(identifier: "CTNotification", actions: [action1, action2, action3], intentIdentifiers: [], options: [])
     UNUserNotificationCenter.current().setNotificationCategories([category])
    // Notify CleverTap React Native SDK about app launch
    CleverTapReactManager.sharedInstance()?.applicationDidLaunch(options: launchOptions)
    
    
    
    //MARK: INBOX
//    CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
//            let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
//            let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
//            print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
//     }))
//    
    
    
    
    // Register for push notifications
    registerForPushNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  // MARK: - Push Notification Registration
  func registerForPushNotifications() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self
    center.requestAuthorization(options: [.sound, .badge, .alert]) { granted, error in
      if granted {
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
  }
  
  
  // MARK: - APNs Registration Handlers
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
    CleverTap.sharedInstance()?.setPushToken(deviceToken)
  }
  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
  }
  
  
  // MARK: - Push Notification Handling
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                didReceive response: UNNotificationResponse,
                withCompletionHandler completionHandler: @escaping () -> Void) {
    NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
    completionHandler()
  }
  
  
  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                willPresent notification: UNNotification,
                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
    CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
    completionHandler([.badge, .sound, .alert])
  }
  
  
  
  override func application(_ application: UIApplication,
               didReceiveRemoteNotification userInfo: [AnyHashable : Any],
               fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
    completionHandler(UIBackgroundFetchResult.noData)
  }
  
  func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
    NSLog("pushNotificationTapped: customExtras: %@", customExtras)
  }
  
  
  

  
  
  
  
  
  // MARK: - React Native Bundle
  override func sourceURL(for bridge: RCTBridge) -> URL? {
    self.bundleURL()
  }
  
  
  override func bundleURL() -> URL? {
    #if DEBUG
    RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
    #else
    Bundle.main.url(forResource: "main", withExtension: "jsbundle")
    #endif
  }
}

//
//  NotificationViewController.swift
//  Notification Content Extension
//
//  Created by Henil Gandhi on 21/02/25.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import CTNotificationContent

class NotificationViewController: CTNotificationViewController {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
  override func userDidPerformAction(_ action: String, withProperties properties: [AnyHashable : Any]!) {
         print("userDidPerformAction \(action) with props \(String(describing: properties))")
     }
}

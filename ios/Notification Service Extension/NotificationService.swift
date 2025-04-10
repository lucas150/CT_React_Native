//
//  NotificationService.swift
//  Notification Service Extension
//
//  Created by Henil Gandhi on 21/02/25.
//

import UserNotifications
import CTNotificationService
import CleverTapSDK

class NotificationService: CTNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
       CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)

    }
    
}

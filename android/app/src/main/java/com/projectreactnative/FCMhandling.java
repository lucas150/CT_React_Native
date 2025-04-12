package com.projectreactnative;
import android.content.Context;
import android.content.Intent;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
import androidx.core.app.NotificationCompat;

import com.clevertap.android.sdk.CleverTapAPI;
import com.clevertap.android.sdk.CleverTapInstanceConfig;
import com.clevertap.android.sdk.pushnotification.LaunchPendingIntentFactory;
import com.clevertap.android.sdk.pushnotification.NotificationInfo;
//import com.clevertap.android.sdk.pushnotification.fcm.CTFcmMessageHandler;
import com.clevertap.android.sdk.pushnotification.fcm.CTFcmMessageHandler;
//import com.clevertap.android.xps.CTXiaomiMessageHandler;
import com.clevertap.android.sdk.pushnotification.fcm.FcmMessageListenerService;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
//import com.xiaomi.mipush.sdk.MiPushMessage;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class FCMhandling extends FirebaseMessagingService {

    // @Override
    // public void onMessageReceived(RemoteMessage message) {
    //     Log.d("CleverTap", "FCM Message Received");
    //     CleverTapAPI CleverTapdDefaultInstance = CleverTapAPI.getDefaultInstance(getApplicationContext());
    //     Map<String, String> data = message.getData();

    //     if (data.containsKey("wzrk_id")) {
    //         Log.d("CleverTap", "wzrk_id is present: " + data.get("wzrk_id"));
    //         new CTFcmMessageHandler().createNotification(getApplicationContext(), message);
    //     } else {
    //         Log.d("CleverTap", "wzrk_id is NOT present");
    //     }


    // }
    @Override
    public void onNewToken(String token1)
    {
        super.onNewToken(token1);
        Log.d("MY_TOKEN", "Refreshed token: " + token1);
        
    }


    @Override
    public void onMessageReceived(RemoteMessage message) {
        new CTFcmMessageHandler().createNotification(getApplicationContext(), message);
    }
}

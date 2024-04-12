package com.jmpfbmx.evergage_flutter

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.evergage.android.Evergage
import com.evergage.android.ClientConfiguration
import com.evergage.android.LogLevel
import com.evergage.android.Screen

/** EvergageFlutterPlugin */
class EvergageFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "evergage_flutter")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    var evergage = Evergage.getInstance()
    val screen: Screen? = evergage.getScreenForActivity(activity)
    val contextEvergage: com.evergage.android.Context? = evergage.globalContext

    when (call.method) {
      "initializeEvergage" -> {
        val arguments = call.arguments as Map<*, *>
        val account = arguments["account"] as String
        val dataset = arguments["dataset"] as String
        val userId = arguments["userId"] as String
        val usePushNotifications = arguments["usePushNotification"] as Boolean
        initializeEvergage(account, dataset, userId, usePushNotifications)
        result.success(null)
      }
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      else -> result.notImplemented()
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
    Evergage.initialize(activity.application)
    Evergage.setLogLevel(LogLevel.ALL)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  private fun initializeEvergage(account: String, dataset: String, userId: String, usePushNotifications: Boolean) {
    val evergage = Evergage.getInstance()
    evergage.setUserId(userId)
    evergage.start(ClientConfiguration.Builder()
            .account(account)
            .dataset(dataset)
            .usePushNotifications(usePushNotifications)
            .build())
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

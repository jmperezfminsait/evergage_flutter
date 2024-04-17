package com.jmpfbmx.evergage_flutter

import android.app.Activity
import android.content.Context
import android.widget.Toast
import androidx.annotation.NonNull

import org.json.*

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.evergage.android.*

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
      "setAccountId" -> {
        val arguments = call.arguments as Map<*, *>
        val accountId = arguments["accountId"] as String
        setAccountId(accountId)
        result.success(null)
      }
      "getAccountId" -> {
        result.success(getAccountId())
      }
      "getAnonymousId" -> {
        result.success(getAnonymousId())
      }
      "getUserId" -> {
        result.success(getUserId())
      }
      "setAccountAttribute" -> {
        val arguments = call.arguments as Map<*, *>
        val attributeName = arguments["attributeName"] as String
        val attributeValue = arguments["attributeValue"] as String
        setAccountAttribute(attributeName, attributeValue)
        result.success(null)
      }
      "setUserAttribute" -> {
        val arguments = call.arguments as Map<*, *>
        val attributeName = arguments["attributeName"] as String
        val attributeValue = arguments["attributeValue"] as String
        setUserAttribute(attributeName, attributeValue)
        result.success(null)
      }
      "setFirebaseToken" -> {
        val arguments = call.arguments as Map<*, *>
        val token = arguments["token"] as String
        setFirebaseToken(token)
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

  private fun setAccountId(accountId: String) {
    val evergage = Evergage.getInstance()
    evergage.accountId = accountId
  }

  private fun getAccountId(): String? {
    val evergage = Evergage.getInstance()
    return evergage.accountId
  }

  private fun getAnonymousId(): String? {
    val evergage = Evergage.getInstance()
    return evergage.anonymousId
  }

  private fun getUserId(): String? {
    val evergage = Evergage.getInstance()
    return evergage.userId
  }

  private fun setAccountAttribute(attributeName: String, attributeValue: String) {
    val evergage = Evergage.getInstance()
    evergage.setAccountAttribute(attributeName, attributeValue)
  }

  private fun setUserAttribute(attributeName: String, attributeValue: String) {
    val evergage = Evergage.getInstance()
    evergage.setUserAttribute(attributeName, attributeValue)
  }

  private fun setFirebaseToken(token: String) {
    val evergage = Evergage.getInstance()
    evergage.setFirebaseToken(token)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

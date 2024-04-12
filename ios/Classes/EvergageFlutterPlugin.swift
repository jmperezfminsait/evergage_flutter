import Flutter
import UIKit
import Evergage

public class EvergageFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "evergage_flutter", binaryMessenger: registrar.messenger())
    let instance = EvergageFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let evergage = Evergage.sharedInstance()
    evergage.logLevel = EVGLogLevel.all
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initializeEvergage":
        let arguments = call.arguments as! NSDictionary
        initializeEvergage(
            account: arguments["account"] as! String,
            dataset: arguments["dataset"] as! String,
            userId: arguments["userId"] as! String,
            usePushNotification: arguments["usePushNotification"] as! Bool
        )
        result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func initializeEvergage(account: String, dataset: String, userId: String, usePushNotification: Bool) {
    let evergage = Evergage.sharedInstance()
    evergage.userId = userId
    evergage.start { (clientConfigurationBuilder) in
        clientConfigurationBuilder.account = account
        clientConfigurationBuilder.dataset = dataset
        clientConfigurationBuilder.usePushNotifications = usePushNotification
    }
  }
}

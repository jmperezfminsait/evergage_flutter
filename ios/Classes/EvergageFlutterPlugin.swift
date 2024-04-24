import Flutter
import UIKit
import Evergage
import CommonCrypto

public class SwiftEvergageFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "evergage_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftEvergageFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      let arguments = call.arguments as! NSDictionary
      
      let evergage = Evergage.sharedInstance()
      evergage.logLevel = EVGLogLevel.all
      
      
      switch call.method {
      case "initializeEvergage":
          evergage.start { (clientConfigurationBuilder) in
              clientConfigurationBuilder.account = arguments["account"] as! String
              clientConfigurationBuilder.dataset = arguments["dataset"] as! String
              clientConfigurationBuilder.usePushNotifications = arguments["usePushNotification"] as! Bool
          }
          
          result(nil)
      case "setUser":
          let email = arguments["email"] as? String
          
          evergage.userId = arguments["userId"] as? String         
          
          result(nil)
      case "setUserAttribute":
          evergage.setUserAttribute(arguments["attributeName"] as? String, forName: "attributeName")
          evergage.setUserAttribute(arguments["attributeValue"] as? String, forName: "attributeValue")
          
          result(nil)
      case "trackAction":
          let action = arguments["action"] as! String
          evergage.globalContext?.trackAction(action)
          result(nil)
      default:
          result(FlutterMethodNotImplemented)
      }
  }
}

public extension Data{
    func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}

public extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
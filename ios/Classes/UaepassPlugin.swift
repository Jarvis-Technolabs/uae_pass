import Flutter
import UIKit

public class UaepassPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "uaepass", binaryMessenger: registrar.messenger())
    let instance = UaepassPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "openUaePassApp":
      if let args = call.arguments as? [String: Any],
        let appName = args["appName"] as? String,
        let appPage = args["appPage"] as? String
      {

        if UIApplication.shared.canOpenURL(URL(string: appName)!) {
          var appUrl = URL(string: appName + appPage)!
          UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
        } else {
          result(appName)
        }
      } else {
        result(FlutterError.init(code: "bad args", message: nil, details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
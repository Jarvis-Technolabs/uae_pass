import Flutter
import UIKit

var flutterResults : FlutterResult!

public class UaepassPlugin: NSObject, FlutterPlugin {

    let METHOD_CHANNEL_OPEN_APP = "openUaePassApp"
    let IS_APP_ENABLED = "isAppEnabled"
    let LAUNCH_APP = "launchApp"
    let KEY_URL = "url"
    let KEY_SUCCESS_URL = "successurl"
    let KEY_FAILURE_URL = "failureurl"
    let KEY_RESULT_SUCCESS="loadSuccessUrl"
    let KEY_CANCELLED="canceled"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "uaepass", binaryMessenger: registrar.messenger())
    let instance = UaepassPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case METHOD_CHANNEL_OPEN_APP:
      flutterResults = result
      let arguments = call.arguments as? NSDictionary
      let uriSchema = (arguments![KEY_URL] as? String)!
      var testURL = URL(string: uriSchema)
      testURL = replaceUriParameter(uri: testURL!, key: KEY_SUCCESS_URL, newValue: externalURLSchemeSuccess())
      testURL = replaceUriParameter(uri: testURL!, key: KEY_FAILURE_URL, newValue: externalURLSchemeFail())
      openCustomApp(uriSchema:testURL!.absoluteString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

   public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          // below will check url is success or failure which comes from other app
          return checkSchemeUrl(url: url.absoluteString)
      }

  // this method will open app mathcing urlscheme
      public func openCustomApp(uriSchema:String){
          let customURL = URL(string: uriSchema)!
          if #available(iOS 10.0, *) {
              UIApplication.shared.open(customURL)
          } else {
              UIApplication.shared.openURL(customURL)
          }
      }

      // this method will return string for opening our app from uae pass app when authorization success
      public  func externalURLSchemeSuccess() -> String {
          guard let urlTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? [AnyObject],
                let urlTypeDictionary = urlTypes.first as? [String: AnyObject],
                let urlSchemes = urlTypeDictionary["CFBundleURLSchemes"] as? [AnyObject],
                let externalURLScheme = urlSchemes.first as? String else {
              return ""
          }
          return "\(externalURLScheme)://uaePassSuccess"
      }

      // this method will return string for opening our app from uae pass app when authorization fail
      public  func externalURLSchemeFail() -> String{
          guard let urlTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? [AnyObject],
                let urlTypeDictionary = urlTypes.first as? [String: AnyObject],
                let urlSchemes = urlTypeDictionary["CFBundleURLSchemes"] as? [AnyObject],
                let externalURLScheme = urlSchemes.first as? String else { return "" }
          return "\(externalURLScheme)://uaePassFail"
      }

      // this will check url returning from other app, is returning success or failure
      public  func checkSchemeUrl(url:String) -> Bool{
          print("checkSchemeUrl:::->")

          if url == externalURLSchemeSuccess() {
              print("returning From  :: externalURLSchemeSuccess ");
              flutterResults(KEY_RESULT_SUCCESS)
              return true
          } else if url == externalURLSchemeFail() {
              print("returning From  :: externalURLSchemeFail ");
              flutterResults(KEY_CANCELLED)
              return false
          }
          return true
      }

      public func replaceUriParameter(uri: URL, key: String, newValue: String) -> URL {

          let params = uri.queryParameters!
          var urlComp = URLComponents(url: uri, resolvingAgainstBaseURL: true)
          urlComp?.query = nil

          var arrQueryItem = [URLQueryItem]()
          print(arrQueryItem)
          for (k, v) in params {
              arrQueryItem.append(URLQueryItem(name: k, value: (k==key) ? newValue : v))
          }
          let finalURL = (urlComp?.url!.appending(arrQueryItem)!)!
          return finalURL
      }
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }

    func appending(_ queryItems: [URLQueryItem]) -> URL? {
            guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
                // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
                return nil
            }
            // append the query items to the existing ones
            urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

            // return the url from new url components
            return urlComponents.url
        }
}
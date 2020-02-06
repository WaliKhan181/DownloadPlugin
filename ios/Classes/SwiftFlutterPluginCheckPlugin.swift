import Flutter
import UIKit

public class SwiftFlutterPluginCheckPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_plugin_check", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterPluginCheckPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "showToast"){
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            var map = call.arguments as? Dictionary<String,URL>
            var message = map?["url"]
            var request = URLRequest(url: message!)
            request.httpMethod = "GET"
            let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
                 if let localURL = localURL {
                     if let string = try? String(contentsOf: localURL) {
                         print(string)
                     }
                 }
             }
            task.resume()
        }
    }
}

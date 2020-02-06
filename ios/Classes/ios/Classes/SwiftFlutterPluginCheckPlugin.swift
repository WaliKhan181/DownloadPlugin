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
            let task =
                session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if (error == nil) {
                    // Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("Success: \(statusCode)")

                    // This is your file-variable:
                    // data
                }
                else {
                    // Failure
                    print("Failure: %@", error!.localizedDescription);
                }
            })
            task.resume()
        }
    }
}

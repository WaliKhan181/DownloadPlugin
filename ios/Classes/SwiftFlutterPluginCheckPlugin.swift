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
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            let request = NSMutableURLRequest(URL: URL)
            request.HTTPMethod = "GET"
            let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if (error == nil) {
                    // Success
                    let statusCode = (response as NSHTTPURLResponse).statusCode
                    println("Success: \(statusCode)")
                    
                    // This is your file-variable:
                    // data
                }
                else {
                    // Failure
                    println("Failure: %@", error.localizedDescription);
                }
            })
            task.resume()
        }
    }
}

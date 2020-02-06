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
            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as! URL
            let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
            
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            var map = call.arguments as? Dictionary<String,String>
            var message = map?["url"]
            var fileURL = URL(string: message!)
            var request = URLRequest(url: fileURL!)
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Successfully downloaded. Status code: \(statusCode)")
                    }
                    
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    } catch (let writeError) {
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    }
                    
                } else {
                    print("Error took place while downloading a file. Error description: %@");
                }
            }
            task.resume()
            
        }
    }
}

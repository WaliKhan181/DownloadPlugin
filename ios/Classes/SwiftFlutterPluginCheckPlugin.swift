import Flutter
import UIKit

public class SwiftFlutterPluginCheckPlugin: NSObject, FlutterPlugin {
    let documentInteractionController = UIDocumentInteractionController()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_plugin_check", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterPluginCheckPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "showToast"){
            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as! URL

            var currentDate = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .medium
            let dateTimeString = formatter.string(from: currentDate)
            var map = call.arguments as? Dictionary<String,String>
            var message = map?["url"]
//            var isImage : Bool = false
            var destinationFileUrl :URL = documentsUrl.appendingPathComponent("JFA " + dateTimeString)
//            if(message!.contains(".JPG") || message!.contains(".PNG") || message!.contains(".JPEG")){
//                destinationFileUrl = documentsUrl.appendingPathComponent("JFA " + dateTimeString + ".jpg")
//                isImage = true
//            }
//            else if(message!.contains(".PDF")){
//                destinationFileUrl = documentsUrl.appendingPathComponent("JFA " + dateTimeString + ".pdf")
//            }
//            else if(message!.contains(".DOCX")){
//                destinationFileUrl = documentsUrl.appendingPathComponent("JFA " + dateTimeString + ".docx")
//            }
            var qMark = message?.split(separator: "?")
            var firstUrl = qMark?.first
            var index = (firstUrl?.lastIndex(of: "."))!
            var fileExtension = firstUrl?.suffix(from: index)
            destinationFileUrl = documentsUrl.appendingPathComponent("JFA " + dateTimeString + fileExtension!)

            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)

            var fileURL = URL(string: message!)
            var request = URLRequest(url: fileURL!)
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in

                print("HI")
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Successfully downloaded. Status code: \(statusCode)")
                    }

                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                        let fileManager = FileManager.default
//                        if(isImage){
//                            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//                            let directory = path[0]
//                            let imagePath = (directory as NSString).strings(byAppendingPaths: ["JFA " + dateTimeString + ".jpg"])
//                            if fileManager.fileExists(atPath: imagePath[0]){
//                                UIImageWriteToSavedPhotosAlbum(UIImage(contentsOfFile: imagePath[0])!, nil, nil, nil)
//                            }}
//                        else{
//                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                        }
                    } catch (let writeError) {
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    }
                    DispatchQueue.main.async {
                        self.share(url: destinationFileUrl)
                    }

                } else {
                    print("Error took place while downloading a file. Error description: %@");
                }
            }
            task.resume()
        }
    }

    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.absoluteString
        documentInteractionController.name = url.absoluteString
        documentInteractionController.presentPreview(animated: true)
    }
}

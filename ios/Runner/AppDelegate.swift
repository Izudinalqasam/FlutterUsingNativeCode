import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "MyChannel", binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        
        guard let ArgCopy = call.arguments else { return }
        
        guard let fromArgCopy = ArgCopy as? [String : Any] else { return }
        
        if let resultFromArg = fromArgCopy["from"] as? String,
           "myNativeFunction" == call.method {
            var messageToFlutter = self.myNativeFunction()
            messageToFlutter = messageToFlutter + ", Back to " + resultFromArg
                result(messageToFlutter)
        } else {
            result(FlutterError(code: "-1", message: "iOS could not extract " +
            "flutter arguments in method: (sendParams)", details: nil))
        }
    })
        
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func myNativeFunction() -> String {
        return "Message from IOS"
    }
}

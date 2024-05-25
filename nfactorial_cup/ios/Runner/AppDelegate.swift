import Flutter
import UIKit
import YandexMapsMobile

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // YMKMapKit.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
    YMKMapKit.setApiKey("e648b0d7-8906-47f5-b03f-b63c0e58698d") // Your generated API key
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
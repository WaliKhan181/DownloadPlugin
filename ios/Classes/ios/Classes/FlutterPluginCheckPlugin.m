#import "FlutterPluginCheckPlugin.h"
#if __has_include(<flutter_plugin_check/flutter_plugin_check-Swift.h>)
#import <flutter_plugin_check/flutter_plugin_check-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_plugin_check-Swift.h"
#endif

@implementation FlutterPluginCheckPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPluginCheckPlugin registerWithRegistrar:registrar];
}
@end

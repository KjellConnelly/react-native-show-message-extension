
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#import <Messages/Messages.h>

@interface RNReactNativeShowMessageExtension : NSObject <RCTBridgeModule>

@end

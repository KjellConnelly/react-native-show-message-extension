
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#import <Messages/Messages.h>
#import <MessageUI/MessageUI.h>

@interface RNReactNativeShowMessageExtension : NSObject <RCTBridgeModule, MFMessageComposeViewControllerDelegate>

@end

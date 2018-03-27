
#if __has_include("RCTBridgeModule.h")
  #import "RCTBridgeModule.h"
  #import "RCTConvert.h"
#else
  #import <React/RCTBridgeModule.h>
  #import <React/RCTConvert.h>
#endif

#import <Messages/Messages.h>
#import <MessageUI/MessageUI.h>

@interface RNReactNativeShowMessageExtension : NSObject <RCTBridgeModule, MFMessageComposeViewControllerDelegate>

@end

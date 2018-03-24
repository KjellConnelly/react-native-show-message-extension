
#import "RNReactNativeShowMessageExtension.h"

@implementation RNReactNativeShowMessageExtension

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(open: (RCTResponseSenderBlock)callback) {
  savedCallback = callback;
  UIViewController *topViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];

}


@end

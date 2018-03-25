
#import "RNReactNativeShowMessageExtension.h"

@implementation RNReactNativeShowMessageExtension

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

//RCT_EXPORT_METHOD(show: (RCTResponseSenderBlock)callback) {
RCT_EXPORT_METHOD(canSendText: (RCTResponseSenderBlock)callback) {
  NSNumber *canSendText = [NSNumber numberWithBool: [MFMessageComposeViewController canSendText]];
  callback(@[canSendText]);
}

RCT_EXPORT_METHOD(show) {
  //savedCallback = callback;
  UIViewController *topViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];

  if (![MFMessageComposeViewController canSendText]) {
    NSLog(@"Cannot send text on this device. Are you using the simulator?");
    return;
  }

  MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
  [messageVC setMessageComposeDelegate:self];

  if (NSClassFromString(@"MSMessage")) {
    MSMessageTemplateLayout *msgLayout = [[MSMessageTemplateLayout alloc] init];
    msgLayout.caption = @"something here";
    //msgLayout.image = image; (UIImage)
    MSMessage *message = [[MSMessage alloc] init];

    message.layout = msgLayout;

    [messageVC setMessage:message];

    [topViewController presentViewController:messageVC animated:true completion:^{

    }];
  } else {
    NSLog(@"No MSMessage");
    return;
  }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
  [controller dismissViewControllerAnimated:YES completion:nil];
}



@end

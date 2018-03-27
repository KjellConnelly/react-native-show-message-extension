
#import "RNReactNativeShowMessageExtension.h"

@implementation RNReactNativeShowMessageExtension
RCTResponseSenderBlock savedCallback;

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

//RCT_EXPORT_METHOD(show: (RCTResponseSenderBlock)callback) {
RCT_EXPORT_METHOD(canSendText: (RCTResponseSenderBlock)callback) {
  NSNumber *canSendText = [NSNumber numberWithBool: [MFMessageComposeViewController canSendText]];
  callback(@[canSendText]);
}

RCT_EXPORT_METHOD(show: (NSDictionary *)options: (RCTResponseSenderBlock)callback) {
  savedCallback = callback;

  if (![MFMessageComposeViewController canSendText]) {
    // 0 == cannot send text. Are you on simulator?
    NSLog(@"react-native-show-message-extension: Cannot send text on this device. Are you using the simulator?");
    callback(@[@0, [NSNull null]]);
    return;
  }

  if (NSClassFromString(@"MSMessage")) {

    UIViewController *topViewController = [self topViewController];//[[[UIApplication sharedApplication] keyWindow] rootViewController];
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    [messageVC setMessageComposeDelegate:self];
    MSMessageTemplateLayout *msgLayout = [[MSMessageTemplateLayout alloc] init];
    MSMessage *message = [[MSMessage alloc] init];

    // message VC properties from react native call
    messageVC.recipients = [self getArrayFromOptions:options :@"message" :@"recipients"];
    messageVC.subject = [self getStringFromOptions:options :@"message" :@"subject"];
    messageVC.body = [self getStringFromOptions:options :@"message" :@"subject"];

    // MSMessage properties
    message.URL = [self getURLFromOptionsJSONBased:options :@"message" :@"url"];
    message.shouldExpire = [self getBOOLFromOptionsDefaultIsFalse:options :@"layout" :@"shouldExpire"];

    // layout properties
    msgLayout.image = [self getUIImageFromOptions:options :@"layout" :@"imagePath"];
    msgLayout.mediaFileURL = [self getURLFromOptions:options :@"layout" :@"mediaFileURL"];
    msgLayout.imageTitle = [self getStringFromOptions:options :@"layout" :@"imageTitle"];
    msgLayout.imageSubtitle = [self getStringFromOptions:options :@"layout" :@"imageSubtitle"];
    msgLayout.subcaption = [self getStringFromOptions:options :@"layout" :@"subcaption"];
    msgLayout.trailingCaption = [self getStringFromOptions:options :@"layout" :@"trailingCaption"];
    msgLayout.trailingSubcaption = [self getStringFromOptions:options :@"layout" :@"trailingSubcaption"];
    msgLayout.accessibilityLabel = [self getStringFromOptions:options :@"layout" :@"accessibilityLabel"];

    // Open it up!
    message.layout = msgLayout;
    [messageVC setMessage:message];
    [topViewController presentViewController:messageVC animated:true completion:^{
      // No error
    }];
  } else {
    // 1 == no msmessage capability. iOS10+? Probably not.
    callback(@[@1, [NSNull null]]);
    return;
  }
}

- (NSURL *) getURLFromOptionsJSONBased : (NSDictionary *) options : (NSString *) firstKey : (NSString *) secondKey {
  if ([options objectForKey:firstKey] != nil) {
    NSDictionary *dict = [options objectForKey:firstKey];
    if ([dict objectForKey:secondKey] != nil) {
      NSString *jsonString = (NSString *)[dict objectForKey:secondKey];
      NSURL *convertURL = [RCTConvert NSURL:jsonString];
      return convertURL;
    }
  }

  return nil;
}

- (BOOL) getBOOLFromOptionsDefaultIsFalse : (NSDictionary *) options : (NSString *) firstKey : (NSString *) secondKey {
  if ([options objectForKey:firstKey] != nil) {
    NSDictionary *dict = [options objectForKey:firstKey];
    if ([dict objectForKey:secondKey] != nil) {
      return [[dict objectForKey:secondKey] boolValue];
    }
  }

  return false;
}

- (NSURL *) getURLFromOptions : (NSDictionary *) options : (NSString *) firstKey : (NSString *) secondKey {
  if ([options objectForKey:firstKey] != nil) {
    NSDictionary *dict = [options objectForKey:firstKey];
    NSString *filePath = (NSString *)[dict objectForKey:secondKey];
    if (filePath != nil) {
      NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
      NSString *path = [NSString stringWithFormat:@"%@/%@", bundlePath, filePath];
      NSURL *url = [NSURL fileURLWithPath:path];

      if (url == nil) {
        if (![filePath isEqualToString:@""]) {
          NSLog(@"react-native-show-message-extension error finding URL. To find the path to your asset, please provide a String with the URL from the app's bundle. To find this, open Xcode and navigate to Products > YourApp.app. Right-click it, and click 'Show in Finder'. In finder, right-click YourApp.app (extension may be hidden), and click 'Show Package Contents'. Navigate through here to find your asset file. Xcode assets will typically be on this root level. Packaged items will be in folders within the assets folder.");
        }
      }

      return url;
    }
  }

  return nil;
}

- (UIImage *) getUIImageFromOptions : (NSDictionary *) options : (NSString *) firstKey : (NSString *) secondKey {
  if ([options objectForKey:firstKey] != nil) {
    NSDictionary *dict = [options objectForKey:firstKey];
    NSString *imagePath = (NSString *)[dict objectForKey:secondKey];
    if (imagePath != nil) {
      NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
      NSString *path = [NSString stringWithFormat:@"%@/%@", bundlePath, imagePath];
      UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]]];

      if (img == nil) {
        if (![imagePath isEqualToString:@""]) {
          NSLog(@"react-native-show-message-extension error finding image. To find the path to your image, please provide a String with the URL from the app's bundle. To find this, open Xcode and navigate to Products > YourApp.app. Right-click it, and click 'Show in Finder'. In finder, right-click YourApp.app (extension may be hidden), and click 'Show Package Contents'. Navigate through here to find your image file. Xcode assets will typically be on this root level. Packaged items will be in folders within the assets folder.");
        }
      }

      return img;
    }
  }

  return nil;
}

- (NSArray *) getArrayFromOptions : (NSDictionary *) options : (NSString *) firstKey : (NSString *) secondKey {
  if ([options objectForKey:firstKey] != nil) {
    NSDictionary *dict = [options objectForKey:firstKey];
    if ([dict objectForKey:secondKey] != nil) {
      return (NSArray *)[dict objectForKey:secondKey];
    }
  }

  return nil;
}

- (NSString *) getStringFromOptions : (NSDictionary *) options : (NSString *) firstKey : (NSString *) secondKey {
  if ([options objectForKey:firstKey] != nil) {
    NSDictionary *dict = [options objectForKey:firstKey];
    if ([dict objectForKey:secondKey] != nil) {
      return (NSString *)[dict objectForKey:secondKey];
    }
  }

  return nil;
}

- (UIViewController *)topViewController{
  return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
  if (rootViewController.presentedViewController == nil) {
    return rootViewController;
  }

  if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
    UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
    UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
    return [self topViewController:lastViewController];
  }

  UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
  return [self topViewController:presentedViewController];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
  [controller dismissViewControllerAnimated:YES completion:^{
    // successfully opened and closed
    savedCallback(@[[NSNull null], @(result)]);
  }];
}



@end


# react-native-show-message-extension

## What this Module is for
1. If you have an iOS Message Extension and want to be able to send a MSMessage from within your React-Native app.
2. Right now, you can only send some basic data such as a text, a url (as stringified JSON to be processed by your native message extension), an image, or a file such as mp3 or video.
3. This module only prefills some things for a text message to be sent. It doesn't actually open your Message Extension. I wish it did, but it turns out this currently isn't possible.

## Getting started

`$ npm i react-native-show-message-extension`

### Mostly automatic installation

##### New Way (with pod)
`$ cd ios && pod install && cd ../`

##### Old Way
`$ react-native link react-native-show-message-extension`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-show-message-extension` and add `RNReactNativeShowMessageExtension.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNReactNativeShowMessageExtension.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

## Prior to Using Please Note:
1. If you try to use this on the Simulator, it will not work as ```MFMessageComposeViewController``` will not open on the Simulator. So you must build on a real device to test this module.
2. If you want to attach an image, you will need to use an image path. To do this, you need to view the structure of your app's bundle. Xcode will normally only allow for everything on the root level, so giving just an image name works. But the React Native Packager allows for multiple assets with the same name as long as they're in different folders. So you must navigate your Product's filesystem to find the path created. (This is to send images that your app has, not remote images, or images that your extension as bundled.)
3. Although I attached all of these options, I'm not sure what they all do exactly. Please look at Apple's documentation for more info.

## Example
```javascript
import ShowMessageExtension from 'react-native-show-message-extension'

export default class App extends Component {
  constructor(props) {
    super(props)

    // maybe your extension is a pizza app, and you want to pass data that your app can handle.
    // do it with options.message.url (Javascript object that is stringified)
    const pizzaData = {
      size:"Large",
      toppings:[
        {name:"Pepperoni", count:"1"},
        {name:"Mozzarella", count:"2"},
        {name:"Basil", count:"1"},
      ]
    }

    this.options = {
      message: {
        recipients: ["4258857529"],
        subject: "Check out this cool image", // Seems like this is the message that shows in the text
        body: "",
        url:JSON.stringify(pizzaData),
      },
      layout: {
        imagePath: "assets/images/icons/icon_156.png",
        mediaFileURL: undefined, // you can technically put the same imagePath here instead of above and it'll work the same, But here you can add other assets like audio or video instead.
        imageTitle: "Image Title",
        imageSubtitle: "Image Subtitle",
        caption: "Some Caption",
        subcaption: "SubCaption",
        trailingCaption: "Trailing Caption",
        trailingSubcaption: "Trailing SubCaption",
        accessibilityLabel: "Accessibility Label",
        summaryText: "And to summarize...",
        shouldExpire: false,
      }
    }

    this.options2 = {
      message: {
        recipients: ["4258857529"],
        subject: "Cool Email plz Read",
        body: "",
        url:JSON.stringify(pizzaData),
      },
      layout: {
        imagePath: undefined, // imagePath overrides mediaFileURL. So if you have both, only the image will show.
        mediaFileURL: "assets/myAudio/mySong.mp3",
        imageTitle: "Image Title",
        imageSubtitle: "Image Subtitle",
        caption: "Some Caption",
        subcaption: "SubCaption",
        trailingCaption: "Trailing Caption",
        trailingSubcaption: "Trailing SubCaption",
        accessibilityLabel: "Accessibility Label",
        summaryText: "And to summarize...",
        shouldExpire: true,
      }
    }
  }

  render() {
    return (
      <View>
        <Button title={"Send Image"} onPress={async()=>{
          try {
            const successCode = await ShowMessageExtension.show(this.options)
            // successCode: 0 = user pressed cancel, 1 = sent, 2 = failed
          } catch(errorCode) {
            // errorCode: 0 = cannot send text. Simulator? Something else?
            // 1 = cannot create a MSMessage. Not iOS 10+?
          }
        }} />

        <Button title={"Send MP3"} onPress={async()=>{
          try {
            const successCode = await ShowMessageExtension.show(this.options2)
            // successCode: 0 = user pressed cancel, 1 = sent, 2 = failed
          } catch(errorCode) {
            // errorCode: 0 = cannot send text. Simulator? Something else?
            // 1 = cannot create a MSMessage. Not iOS 10+?
          }
        }} />
      </View>
    )
  }
}
```





## Example 2: Check if user can send text before showing a button for them to press
```javascript
import ShowMessageExtension from 'react-native-show-message-extension'

export default class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      // undefined while we check, false if we cannot, true if we can.
      ableToSendText: undefined
    }
    this.options = {
      message: {
        subject: "Check out my icon!",
      },
      layout: {
        imagePath: "assets/images/icons/icon_156.png",
      }
    }

    ShowMessageExtension.canSendText(ableTo=>{
      this.setState({ableToSendText:ableTo})
    })
  }

  render() {
    return (
      <View>
        {this.state.ableToSendText == true ?
          <Button title={"Send App Icon"} onPress={async()=>{
            try {
              const successCode = await ShowMessageExtension.show(this.options)
            } catch(errorCode) {

            }
          }} />
          :
          <Text>
            {this.state.ableToSendText == false ? "Unable to send text using this device" : "..."}
          </Text>
        }
      </View>
    )
  }
}
```

## Native Objective-C Example
This example shows how you might go about handling a message's url to create data from yourself React-Native app, and be able to use this data when a user opens their Messages app and taps on a MSMessage that you sent.
```objc
// MessagesViewController.m, subclass of MSMessagesAppViewController
-(void)didBecomeActiveWithConversation:(MSConversation *)conversation {
  MSMessage *message = conversation.selectedMessage;
  if (message == nil) { return; }
  if (message.URL == nil) { return; }

  NSString *jsonString = [message.URL.absoluteString stringByRemovingPercentEncoding];
  // do something with JSON string such as parsing it
  NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  NSArray *toppings = dict[@"toppings"];
  NSLog(@"User wants %i toppings", (int)toppings.count);
}
```

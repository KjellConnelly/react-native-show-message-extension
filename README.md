
# react-native-show-message-extension

## Does not work yet. Still building initial version. Do Not Use Yet.

## Getting started

`$ npm install react-native-show-message-extension --save`

### Mostly automatic installation

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

## Usage
```javascript
import ShowMessageExtension from 'react-native-show-message-extension';

// TODO: What to do with the module?
RNReactNativeShowMessageExtension;
```

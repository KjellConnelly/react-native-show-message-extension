import { NativeModules } from 'react-native'

const { RNReactNativeShowMessageExtension } = NativeModules

export default class ShowMessageExtension {
  static test() {
    console.log("Testing")
  }
}

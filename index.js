import { NativeModules } from 'react-native'

const { RNReactNativeShowMessageExtension } = NativeModules

export default class ShowMessageExtension {
  static open() {
    RNReactNativeShowMessageExtension.open()
  }
}
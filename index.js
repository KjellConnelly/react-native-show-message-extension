import { NativeModules } from 'react-native'

const { RNReactNativeShowMessageExtension } = NativeModules

export default class ShowMessageExtension {
  static show() {
    RNReactNativeShowMessageExtension.show()
  }

  static canSendText(callback) {
    RNReactNativeShowMessageExtension.canSendText(canSend=>{
      callback(canSend)
    })
  }
}

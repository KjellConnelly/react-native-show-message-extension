import { NativeModules } from 'react-native'
const { RNReactNativeShowMessageExtension } = NativeModules

export default class ShowMessageExtension {
  static show(inputOptions, onOpen, onClose) {
    let options = {
      message: {
        recipients: inputOptions.message ? (inputOptions.message.recipients || []) : [],
        subject: inputOptions.message ? (inputOptions.message.subject || "") : "",
        body: inputOptions.message ? (inputOptions.message.body || "") : "",
      },
      layout: {
        imagePath: inputOptions.layout ? (inputOptions.layout.imagePath || "") : "",
        mediaFileURL: inputOptions.layout ? (inputOptions.layout.mediaFileURL || "") : "",
        imageTitle: inputOptions.layout ? (inputOptions.layout.imageTitle || "") : "",
        imageSubtitle: inputOptions.layout ? (inputOptions.layout.imageSubtitle || "") : "",
        caption: inputOptions.layout ? (inputOptions.layout.caption || "") : "",
        subcaption: inputOptions.layout ? (inputOptions.layout.subcaption || "") : "",
        trailingCaption: inputOptions.layout ? (inputOptions.layout.trailingCaption || "") : "",
        trailingSubcaption: inputOptions.layout ? (inputOptions.layout.trailingSubcaption || "") : "",
        accessibilityLabel: inputOptions.layout ? (inputOptions.layout.accessibilityLabel || "") : "",
        summaryText: inputOptions.layout ? (inputOptions.layout.summaryText || "") : "",
        shouldExpire: inputOptions.layout ? (inputOptions.layout.shouldExpire || false) : false,
      }
    }

    RNReactNativeShowMessageExtension.show(options, errorCode=>{
      onOpen(errorCode)
    }, onCloseResult=>{
      // onCloseResult 0 = cancelled, 1 = sent, 2 = failed
      onClose(onCloseResult)
    })
  }

  static canSendText(callback) {
    RNReactNativeShowMessageExtension.canSendText(canSend=>{
      callback(canSend)
    })
  }
}

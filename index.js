import { NativeModules } from 'react-native'
const { RNReactNativeShowMessageExtension } = NativeModules

export default class ShowMessageExtension {
  static async show(inputOptions) {
    let options = {
      message: {
        recipients: inputOptions.message ? (inputOptions.message.recipients || []) : [],
        subject: inputOptions.message ? (inputOptions.message.subject || "") : "",
        body: inputOptions.message ? (inputOptions.message.body || "") : "",
        url: inputOptions.message ? (inputOptions.message.url || "") : "",
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

    return new Promise((resolve, reject)=>{
      RNReactNativeShowMessageExtension.show(options, (errorCode, successCode)=>{
        if (errorCode != null) {
          reject(errorCode)
        } else {
          // successCode:  0 = cancelled, 1 = sent, 2 = failed
          resolve(successCode)
        }
      })
    })
  }

  static canSendText(callback) {
    RNReactNativeShowMessageExtension.canSendText(canSend=>{
      callback(canSend == 0 ? false : true)
    })
  }
}

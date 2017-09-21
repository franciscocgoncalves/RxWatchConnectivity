//
//  InterfaceController.swift
//  Example for RxWatchConnectivity-watchOS Extension
//
//  Created by Francisco Gonçalves on 27/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import WatchConnectivity
import RxWatchConnectivity
import WatchKit

class InterfaceController: WKInterfaceController {

  @IBOutlet var label: WKInterfaceLabel!
  var delegate: WCSessionDelegate?
  var session: WCSession?

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)

    guard WCSession.isSupported() else {
      return
    }

    session = WCSession.default()

    // must set a delegate otherwhise calling activateSession will produce an error
    delegate = RxWCSessionDelegateProxy.createProxyForObject(self) as? WCSessionDelegate
    session?.delegate = delegate
    session?.activate()
  }


  @IBAction func buttonTapped() {
    label.setText("🙈")

    session?.sendMessage(["message": "🐵"], replyHandler: { (messageReceived) in
      if let message = messageReceived["message"] as? String, message == "✅" {
        self.label.setText("🙉")
      } else {
        self.label.setText("🙊")
      }
    }) { (error) in
      self.label.setText("🙊")
    }
  }
}

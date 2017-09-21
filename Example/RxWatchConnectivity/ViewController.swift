//
//  ViewController.swift
//  RxWatchConnectivity
//
//  Created by franciscocgoncalves on 06/27/2017.
//  Copyright (c) 2017 franciscocgoncalves. All rights reserved.
//

import RxSwift
import RxWatchConnectivity
import UIKit
import WatchConnectivity

class ViewController: UIViewController {

  @IBOutlet weak var label: UILabel!
  var delegate: WCSessionDelegate?
  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    guard WCSession.isSupported() else {
      return
    }

    let session = WCSession.default()

    delegate = RxWCSessionDelegateProxy.createProxyForObject(self) as? WCSessionDelegate

    // must set a delegate otherwhise calling activateSession will produce an error
    session.delegate = delegate
    session.activate()

    session.rx
      .didReceiveMessageWithReplyHandler
      .observeOn(MainScheduler.instance)
      .do(onNext: { (messageReceived, replyHandler) in
        if let message = messageReceived["message"] as? String {
          self.label.text = message
          replyHandler(["message": "✅"])
        } else {
          replyHandler(["message": "❌"])
        }
      })
      .subscribe()
      .addDisposableTo(disposeBag)
  }
}



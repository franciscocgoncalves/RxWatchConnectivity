//
//  RxWatchConnectivityDelegateProxy+watchOS.swift
//  RxWatchConnectivity
//
//  Created by Francisco Gonçalves on 08/02/2017.
//  Copyright © 2017 Francisco Gonçalves. All rights reserved.
//

import Foundation
import Result

import WatchConnectivity

extension RxWCSessionDelegateProxy: WCSessionDelegate {
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {
    handle(session, activationDidCompleteWith: activationState, error: error)
  }
}

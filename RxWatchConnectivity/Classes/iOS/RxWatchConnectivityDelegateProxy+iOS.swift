//
//  RxWatchConnectivityDelegateProxy+iOS.swift
//  RxWatchConnectivity
//
//  Created by Francisco Gonçalves on 08/02/2017.
//  Copyright © 2017 Francisco Gonçalves. All rights reserved.
//

import Result
import WatchConnectivity

extension RxWCSessionDelegateProxy: WCSessionDelegate {
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {
    handle(session, activationDidCompleteWith: activationState, error: error)
  }

  func sessionDidBecomeInactive(_ session: WCSession) {
    didBecomeInactiveSubject.on(.next(session))
    self._forwardToDelegate?.sessionDidBecomeInactive(session)
  }

  func sessionDidDeactivate(_ session: WCSession) {
    didDeactivateSubject.on(.next(session))
    self._forwardToDelegate?.sessionDidDeactivate(session)
  }
}

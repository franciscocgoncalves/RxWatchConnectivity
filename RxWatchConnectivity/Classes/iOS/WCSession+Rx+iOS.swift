//
//  WCSession+Rx+iOS.swift
//  RxWatchConnectivity
//
//  Created by Francisco Gonçalves on 08/02/2017.
//  Copyright © 2017 Francisco Gonçalves. All rights reserved.
//

import RxSwift
import WatchConnectivity

extension Reactive where Base : WCSession {

  public var didBecomeInactive: Observable<WCSession> {
    return delegateProxy.didBecomeInactiveSubject
  }

  public var didDeactivate: Observable<WCSession> {
    return delegateProxy.didDeactivateSubject

  }

  public var watchStateDidChange: Observable<WCSession> {
    return delegate
      .methodInvoked(#selector(WCSessionDelegate.sessionWatchStateDidChange(_:)))
      .map { a in
        return try castOrThrow(WCSession.self, a[0])
    }
  }
}

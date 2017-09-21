//
//  WCSession+Rx.swift
//  RxWatchConnectivity
//
//  Created by Francisco Gonçalves on 08/02/2017.
//  Copyright © 2017 Francisco Gonçalves. All rights reserved.
//

import Result
import RxCocoa
import RxSwift
import WatchConnectivity

// Taken from RxCococa until marked as public
func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
  guard let returnValue = object as? T else {
    throw RxCocoaError.castingError(object: object, targetType: resultType)
  }
  return returnValue
}

extension Reactive where Base : WCSession {
  /**
   Reactive wrapper for `delegate`.
   For more information take a look at `DelegateProxyType` protocol documentation.
   */
  public var delegate: DelegateProxy {
    return RxWCSessionDelegateProxy.proxyForObject(base)
  }

  internal var delegateProxy: RxWCSessionDelegateProxy {
    return RxWCSessionDelegateProxy.proxyForObject(base)
  }

  public var activationDidComplete: Observable<Result<WCSessionActivationState, AnyError>> {
    return delegateProxy.activationDidCompleteSubject
  }

  public var reachabilityDidChange: Observable<Bool> {
    return delegate
      .methodInvoked(#selector(WCSessionDelegate.sessionReachabilityDidChange(_:)))
      .map { a in
        let session = try castOrThrow(WCSession.self, a[0])
        return session.isReachable
      }
  }

  public var didReceiveMessage: Observable<[String : Any]> {
    return delegate
      .methodInvoked(#selector(WCSessionDelegate.session(_:didReceiveMessage:)))
      .map { a in
        return try castOrThrow([String: Any].self, a[1])
    }
  }

  public var didReceiveMessageWithReplyHandler: Observable<([String : Any], ([String : Any]) -> Void)> {
    return delegateProxy.didReceiveMessageWithReplyHandlerSubject
  }

  public var didReceiveMessageData: Observable<Data> {
    return delegate
      .methodInvoked(#selector(WCSessionDelegate.session(_:didReceiveMessageData:)))
      .map { a in
        return try castOrThrow(Data.self, a[1])
    }
  }

  public var didReceiveMessageDataWithReplyHandler: Observable<(Data, (Data) -> Void)> {
    return delegateProxy.didReceiveDataWithReplyHandlerSubject
  }

  public var didReceiveUserInfo: Observable<[String : Any]> {
    return delegate
      .methodInvoked(#selector(WCSessionDelegate.session(_:didReceiveUserInfo:)))
      .map { a in
        return try castOrThrow([String: Any].self, a[1])
    }
  }

  public var didReceiveFile: Observable<WCSessionFile> {
    return delegate
      .methodInvoked(#selector(WCSessionDelegate.session(_:didReceive:)))
      .map { a in
        return try castOrThrow(WCSessionFile.self, a[1])
    }
  }

  public var didFinishFileTransfer: Observable<Result<WCSessionFileTransfer, AnyError>> {
    return delegateProxy.didFinishFileTransfer
  }
}

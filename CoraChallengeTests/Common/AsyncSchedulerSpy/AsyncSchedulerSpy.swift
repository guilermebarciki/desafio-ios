//
//  AsyncSchedulerSpy.swift
//  CoraChallengeTests
//
//  Created by Guilerme Barciki on 09/07/24.
//

import Foundation
@testable import CoraChallenge


class AsyncSchedulerSpy: AsyncScheduler {
  var code: (() async -> Void)?
  
  init(code: @escaping () async -> Void) {
    self.code = code
  }
  
  static func schedule(code: @escaping () async -> Void) -> AsyncScheduler {
    return AsyncSchedulerSpy(code: code)
  }
  
  func execute() async {
    await code?()
  }
}

class AsyncSchedulerFactorySpy: AsyncSchedulerFactory {
  var scheduleList: [AsyncSchedulerSpy] = []
  
  @discardableResult
  func create(code: @escaping () async -> Void) -> AsyncScheduler {
    let schedule = AsyncSchedulerSpy.schedule(code: code)
    
    if let schedule = schedule as? AsyncSchedulerSpy {
        scheduleList.append(schedule)
    }
    
    return schedule
  }
  
  func executeLast() async {
    await scheduleList.popLast()?.execute()
  }
}

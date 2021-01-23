import Foundation
import SwiftCoroutine

/// Run `block` on `queue`, blocking the thread from which this is called
public func runBlocking(in queue: DispatchQueue, _ block: @escaping () -> Void) {
    let semaphore = DispatchSemaphore(value: 0)

    queue.startCoroutine {
        block()
        semaphore.signal()
    }

    semaphore.wait()
}

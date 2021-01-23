@testable import RememberifyDbLib

import Foundation
import XCTest

final class AccessTokenTests: XCTestCase {
    let coroutineDispatchQueue = DispatchQueue(label: "com.rememberify.rememberify-db.coroutine-dispatch-queue")

    func testAccessTokenWithValidCredentials() {
        runBlocking(in: coroutineDispatchQueue) {
            let token = SpotifyAccessToken.getAccessToken(spotifyClientId, spotifyClientSecret)

            XCTAssertNotNil(token, "Token must not be nil")
        }
    }
}

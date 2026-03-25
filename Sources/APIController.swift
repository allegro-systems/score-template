import Foundation
import Score

/// A simple API controller demonstrating route handling.
struct APIController: Controller {
    var base: String { "/api" }

    var routes: [Route] {
        [
            Route(
                method: .get, path: "/status",
                handler: { (_: RequestContext) -> Response in
                    let json = #"{"status":"ok","version":"1.0.0"}"#
                    return Response.json(Data(json.utf8))
                })
        ]
    }
}

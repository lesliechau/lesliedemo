
import Foundation
import Kitura
import KituraNet
import SwiftyJSON
import LoggerAPI
import Configuration

// {{ configuration/bluemix/importModule }}
// {{ auth/mca/importModule }}
// {{ auth/facebook/importModule }}
// {{ auth/google/importModule }}
// {{ auth/http/importModule }}
// {{ middleware/profiling/importModule }}
// {{ data/cloudant/importModule }}
// {{ data/redis/importModule }}

public let router = Router()
public let manager = ConfigurationManager()
public var port: Int = 8080
    
public func initialize() throws {
    
    try manager.load(file: "../../config.json")
                .load(.environmentVariables)
    
    // {{ data/redis/declareDatabase }}
    // {{ data/redis/declareRedis }}
    // {{ middleware/profiling/declareSwiftMetrics }}
    // {{ data/cloudant/initializeCloudantBluemix }}
    // {{ data/cloudant/initializeCloudant }}
    // {{ data/redis/initializeRedis }}
    // {{ data/redis/initializeRedisBluemix }}
    // {{ auth/mca/initializeMCA }}
    // {{ auth/facebook/initializeToken }}
    // {{ auth/facebook/initializeAuthLogin }}
    // {{ auth/google/initializeAuthLogin }}
    // {{ auth/google/initializeToken }}
    // {{ auth/http/initializeHttpBasic }}
    // {{ auth/http/initializeHttpDigest }}
    // {{ web/initializeMiddleware }}
    // {{ middleware/profiling/initialization }}
    
    port = manager["port"] as? Int ?? port
    
    router.all("/*", middleware: BodyParser())
    
    initializeIndex()
    // initializeCustomerRoutes()
    // initializeFlightRoutes()
    
}

public func run() throws {
    Kitura.addHTTPServer(onPort: port, with: router)
    Kitura.run()
}



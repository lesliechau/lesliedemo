
import Foundation
import Kitura
import KituraNet
import SwiftyJSON
import LoggerAPI
import Configuration

// <%= configuration/bluemix/importModule %>

// <%= auth/mca/importModule %>

// <%= auth/facebook/importModule %>

// <%= auth/google/importModule %>

// <%= auth/http/importModule %>

// <%= middleware/profiling/importModule %>

// <%= data/cloudant/importModule %>

// <%= data/redis/importModule %>

public class Controller {

    public let router = Router()
    
    public let manager: ConfigurationManager
    
    public var port: Int {
        
        return manager["port"] as? Int ?? 8090
    }
    
    // <%= data/redis/declareDatabase %>
    
    // <%= data/redis/declareRedis %>
    
    // <%= middleware/profiling/declareSwiftMetrics %>

    public init() throws {

        manager = ConfigurationManager()
        try manager.load(.environmentVariables).load(file: "../../config.json")
        
        // <%= data/cloudant/initializeCloudantBluemix %>
        
        // <%= data/cloudant/initializeCloudant %>
        
        // <%= data/redis/initializeRedis %>
        
        // <%= data/redis/initializeRedisBluemix %> 
        
        // <%= auth/mca/initializeMCA %>
        
        // <%= auth/facebook/initializeToken %>
        
        // <%= auth/facebook/initializeAuthLogin %>
        
        // <%= auth/google/initializeAuthLogin %>
        
        // <%= auth/google/initializeToken %>
        
        // <%= auth/http/initializeHttpBasic %>
        
        // <%= auth/http/initializeHttpDigest %>
        
        // <%= web/initializeMiddleware %>
        
        // <%= middleware/profiling/initialization %>
        
        router.all("/*", middleware: BodyParser())

    }
    
}

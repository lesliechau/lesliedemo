
import Foundation
import Kitura
import KituraNet
import SwiftyJSON
import LoggerAPI
import SwiftConfiguration

// If <% bluemix %> is selected, add the following:
// import BluemixConfig
// If <% cloudant %>  is selected, add the following:
// import CouchDB
// end if
// If <% redis %>  is selected, add the following:
// import SwiftRedis
// end if

public class Controller {

    public let router = Router()
    
    public let manager: ConfigurationManager
    
    // if <%= cloudant %> is selected, add the following:
    // internal let database: Database
    // end if
    
    // if <%= redis %> is selected, add the following:
    // let redis: Redis
    // let redisService: RedisService
    // end if

    public var port: Int {
        return manager.applicationPort
    }

    public init() throws {

        manager = ConfigurationManager()
        try manager.load(.environmentVariables).load(file: "../../config.json")
        
        // If <%= cloudant %> is selected and <%= bluemix %> is set add the following:
        // let cloudantService = try manager.getCloudantService(name: "<%= cloudant_service_name %>")
        // let dbClient = CouchDBClient(service: cloudantService)
        // else if <%= cloudant %> selected, but <%= bluemix %> is not
        // let couchDBConnProps = ConnectionProperties(host: "127.0.0.1", port: 5984, secured: false)
        // let dbClient = CouchDBClient(connectionProperties: couchDBConnProps)
        // end if
        // if <%= cloudant %> selected
        // self.database = dbClient.database("databaseName")
        // end if
        
        // if <%= redis %> is selected
        // self.redis = Redis()
        // if <%= redis %> and <% bluemix %> are selected
        // self.redisService = try manager.getRedisService(name: "todolist-redis")
        // end if
        
        
        // if <% web %> is selected, add the following:
        // router.all("/", middleware: StaticFileServer(path: <%= public_path %>"))
        router.all("/", middleware: StaticFileServer())
        // end if
        
    }
    
}
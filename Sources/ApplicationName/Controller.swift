
import Foundation
import Kitura
import KituraNet
import SwiftyJSON
import LoggerAPI
import Configuration

// authentication-related imports
import Credentials

// if <%= mca %> is selected
import MobileClientAccessKituraCredentialsPlugin

// if <%= facebook %> is selected
import CredentialsFacebook

// If <% bluemix %> is selected, add the following:
import BluemixConfig
// end if

// if <% metrics %> is selected, add the following:
import SwiftMetrics
import SwiftMetricsKitura
//

// If <% cloudant %>  is selected, add the following:
// import CouchDB
// end if

// If <% redis %>  is selected, add the following:
// import SwiftRedis
// end if

//

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
    
    // if <% metrics %> is selected:
    let metrics: SwiftMetrics!
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
        
        // authentication
        let credentials = Credentials() // middleware for securing endpoints
        
        // if <%= mca %> is selected
        // MCA credentials
        //credentials.register(plugin: MobileClientAccessKituraCredentialsPlugin())
        
        // if <%= fbToken %> is selected: Facebook OAuth2 token
        // TODO: should we accept input of options in the token init?
        credentials.register(plugin: CredentialsFacebookToken())
        
        // if <%= fbAuth %> is selected: Facebook OAuth2 Auth flow login
        let fbClientId: String = "clientId"  // <%= fbClientId %> the App ID of your app in the Facebook Developer dashboard
        let fbClientSecret: String = "clientSecret"  // <%= fbClientSecret %> the App Secret of your app in the Facebook Developer dashboard
        let callbackUrl: String = "" + "/login/facebook/callback" // <%= fbCallback %>
        let options: [String:Any] = [:]  // <%= fbOptions %>
        let fbCredentials = CredentialsFacebook(clientId: fbClientId,
                                                clientSecret: fbClientSecret,
                                                callbackUrl: callbackUrl,
                                                options: options)
        
        credentials.register(plugin: fbCredentials)
        
        // Assign middleware instance
        router.get("/*", middleware: credentials)
        
        
        // if <% web %> is selected, add the following:
        // router.all("/", middleware: StaticFileServer(path: <%= public_path %>"))
        router.all("/", middleware: StaticFileServer())
        // end if
        
        // if <% metrics %> is selected:
        metrics = try SwiftMetrics()
        SwiftMetricsKitura(swiftMetricsInstance: metrics)
        let monitoring = metrics.monitor()
        // end if
        
        router.all("/*", middleware: BodyParser())

        
    }
    
}

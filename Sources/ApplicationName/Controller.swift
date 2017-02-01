
import Foundation
import Kitura
import KituraNet
import SwiftyJSON
import LoggerAPI
import Configuration

// TODO including BluemixConfig needs to automatically include SwiftMetrics
// <%= configuration/bluemix/importModule %>
import BluemixConfig

// <%= auth/mca/importModule %>
import Credentials
import MobileClientAccessKituraCredentialsPlugin

// <%= auth/facebook/importModule %>
import CredentialsFacebook

// <%= auth/google/importModule %>
import CredentialsGoogle

// <%= auth/http/importModule %>
import CredentialsHTTP

// <%= middleware/profiling/importModule %>
import SwiftMetrics
import SwiftMetricsKitura

// <%= data/cloudant/importModule %>
import CouchDB

// <%= data/redis/importModule %>
import SwiftRedis

public class Controller {

    public let router = Router()
    
    public let manager: ConfigurationManager
    
    //internal let database: Database
    
    //let redis: Redis
    //let redisService: RedisService
    
    let metrics: SwiftMetrics!
    
    // QUESTION: how do we get port in the case of using Configuration, not BluemixConfig?
    // <%= configuration/bluemix/initializePort %>
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
        
        let credentials = Credentials() // middleware for securing endpoints
        
        // <%= auth/mca/initializeMCA %>
        //credentials.register(plugin: MobileClientAccessKituraCredentialsPlugin())
        
        // <%= auth/facebook/initializeToken %>
        let fbOptions: [String: Any] = [:] // <%= fbOptions %>  // an optional dictionary ([String:Any]) of Facebook authentication options
        credentials.register(plugin: CredentialsFacebookToken(options: fbOptions))
        
        // <%= auth/facebook/initializeAuthLogin %>
        let fbClientId = "clientId"  // <%= fbClientId %> the App ID of your app in the Facebook Developer dashboard
        let fbClientSecret = "clientSecret"  // <%= fbClientSecret %> the App Secret of your app in the Facebook Developer dashboard
        let callbackUrl = "" + "/login/facebook/callback" // <%= fbCallback %>
        let options: [String: Any] = [:]  // <%= fbOptions %>
        let fbCredentials = CredentialsFacebook(clientId: fbClientId,
                                                clientSecret: fbClientSecret,
                                                callbackUrl: callbackUrl,
                                                options: options)
        credentials.register(plugin: fbCredentials)
        
        // <%= auth/google/initializeAuthLogin %>
        let clientId = "cliendId" //<%= googleClientId %>  // the Client ID from the credentials tab of your project in the Google Developer's console
        let clientSecret = "clientSecret" //<%= googleClientSecret %>  // the Client Secret from the credentials tab of your project in the Google Developer's console
        let googleCallbackUrl = "callbackUrl" //<%= googleCallback %>  // ex: serverUrl + "/login/google/callback"
        let googleOptions: [String: Any] = [:] //<%= googleOptions %>  // an optional dictionary ([String:Any]) of Google authentication options
        let googleCredentials = CredentialsGoogle(clientId: clientId,
                                                  clientSecret: clientSecret,
                                                  callbackUrl: googleCallbackUrl,
                                                  options: googleOptions)
        credentials.register(plugin: googleCredentials)
        
        // <%= auth/google/initializeToken %>
        let gTokenOptions: [String: Any] = [:] //<%= googleOptions %>  // an optional dictionary ([String:Any]) of Google authentication options
        let googleTokenCredentials = CredentialsGoogleToken(options: gTokenOptions)
        credentials.register(plugin: googleTokenCredentials)
        
        // <%= auth/http/initializeHttpBasic %>
        let users = ["John" : "12345", "Mary" : "qwerasdf"]  // <%= httpUsers %>
        let basicCredentials = CredentialsHTTPBasic(verifyPassword: { userId, password, callback in
            if let storedPassword = users[userId] {
                if (storedPassword == password) {
                    callback(UserProfile(id: userId, displayName: userId, provider: "HTTPBasic"))
                }
            }
            else {
                callback(nil)
            }
        })
        credentials.register(plugin: basicCredentials)
        
        // <%= auth/http/initializeHttpDigest %>
        let users2 = ["John" : "12345", "Mary" : "qwerasdf"]  // <%= httpUsers %>
        let opaque = "0a0b0c0d"  // <%= opaque %>
        let realm = "Kitura-users" // <%= realm %>
        let digestCredentials = CredentialsHTTPDigest(userProfileLoader: { userId, callback in
            if let storedPassword = users2[userId] {
                callback(UserProfile(id: userId, displayName: userId, provider: "HTTPDigest"), storedPassword)
            }
            else {
                callback(nil, nil)
            }
        }, opaque: opaque, realm: realm)
        credentials.register(plugin: digestCredentials)
        
        // Assign middleware instance
        router.get("/*", middleware: credentials)
        
        // <%= web/initializeMiddleware %>
        router.all("/", middleware: StaticFileServer(path: "/public")) // <%= publicPath %>
        
        // <%= middleware/profiling/initialization %>
        metrics = try SwiftMetrics()
        // QUESTION: do we need line 150? What does this do?
        SwiftMetricsKitura(swiftMetricsInstance: metrics)
        let monitoring = metrics.monitor()
        
        router.all("/*", middleware: BodyParser())

    }
    
}

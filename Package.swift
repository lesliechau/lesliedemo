
import PackageDescription

// let applicationName = "<% applicationName %>"
let applicationName = "ApplicationName"

// let applicationServerName =  "<% applicationName %>Server"
let applicationServerName = "ApplicationNameServer"

let package = Package(
    name: applicationName,
    targets: [
      Target(name: applicationName, dependencies: []),
      Target(name: applicationServerName, dependencies: [ .Target(name: applicationName) ])
    ],
    dependencies: [
        
        .Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1),

        // <%= configuration/bluemix/importDependency %>,
        .Package(url: "git@github.ibm.com:IBM-Swift/bluemix-config.git",      majorVersion: 0),
        
        // <%= configuration/standard/importDependency %>,
        // .Package(url: "https://github.ibm.com/IBM-Swift/swift-configuration.git", majorVersion: 0),
        
        // <%= data/cloudant/importDependency %>,
        .Package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git",  majorVersion: 1),
        
        // <%= data/mongodb/importDependency %>,
        .Package(url: "https://github.com/tfrank64/MongoKitten.git",      majorVersion: 3),
        
        // <%= data/redis/importDependency %>,
        .Package(url: "https://github.com/IBM-Swift/Kitura-redis.git",       majorVersion: 1),
        
        // <%= data/postgresql/importDependency %>,
        .Package(url: "https://github.com/IBM-Swift/Swift-Kuery.git",     majorVersion: 0),
        
        // <%= middleware/profiling/importDependency %>,
        .Package(url: "https://github.com/RuntimeTools/SwiftMetrics.git",       majorVersion: 0),
        
        // <%= auth/mca/importDependency %>,
        .Package(url: "https://github.com/jkingoliver/bms-mca-kitura-credentials-plugin.git", majorVersion: 0),
        //.Package(url: "https://github.com/ibm-bluemix-mobile-services/bms-mca-kitura-credentials-plugin.git", majorVersion: 0, minor: 4),
        
        // <%= auth/facebook/importDependency %>,
        .Package(url: "https://github.com/IBM-Swift/Kitura-CredentialsFacebook.git", majorVersion: 1),
        
        // <%= auth/google/importDependency %>,
        .Package(url: "https://github.com/IBM-Swift/Kitura-CredentialsGoogle",  majorVersion: 1),
        
        // <%= auth/http/importDependency %>
        .Package(url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", majorVersion: 1)
    ],
    exclude: []
)

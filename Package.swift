
import PackageDescription

// let applicationName = "<% applicationName %>"
let applicationName = "Application"

// let applicationServerName =  "<% applicationName %>Server"
let applicationServerName = "Server"

let package = Package(
    name: applicationName,
    targets: [
      Target(name: applicationName, dependencies: []),
      Target(name: applicationServerName, dependencies: [ .Target(name: applicationName) ])
    ],
    dependencies: [
        
        .Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1),
        .Package(url: "git@github.ibm.com:IBM-Swift/Configuration.git",      majorVersion: 0)

        // <%= configuration/bluemix/importDependency %>,
        
        // <%= configuration/standard/importDependency %>,
        
        // <%= data/cloudant/importDependency %>,
        
        // <%= data/mongodb/importDependency %>,
        
        // <%= data/redis/importDependency %>,
        
        // <%= data/postgresql/importDependency %>,
        
        // <%= middleware/profiling/importDependency %>,
        
        // <%= auth/mca/importDependency %>,
        
        // <%= auth/facebook/importDependency %>,
        
        // <%= auth/google/importDependency %>,
        
        // <%= auth/http/importDependency %>
        
    ],
    exclude: []
)

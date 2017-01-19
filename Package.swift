
import PackageDescription

// let applicationName = "<% applicationName %>"
let applicationName = "ApplicationName"

// let applicationServerName =  "<% applicationName %>"Server
let applicationServerName = "ApplicationNameServer"

let package = Package(
    name: applicationName,
    targets: [
      Target(name: applicationName, dependencies: []),
      Target(name: applicationServerName, dependencies: [ .Target(name: applicationName) ])
    ],
    dependencies: [
        
        // if <%= bluemix %> selected add:
        .Package(url: "https://github.ibm.com/IBM-Swift/bluemix-config.git",      majorVersion: 0),
        // else 
        // .Package(url: "https://github.ibm.com/IBM-Swift/swift-configuration.git", majorVersion: 0),
        // end if
        
        // if Cloudant selected <%= cloudant %>
        // .Package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git",  majorVersion: 1),
        // end if
        
        // if MongoDB selected <%= mongodb %>
        // .Package(url: "https://github.com/tfrank64/MongoKitten.git",      majorVersion: 3),
        // end if
        
        // if Redis selected <%= redis %>
        .Package(url: "https://github.com/IBM-Swift/Kitura-redis.git",       majorVersion: 1),
        // end if 
        
        // if PostgreSQL selected
        // .Package(url: "https://github.com/IBM-Swift/Swift-Kuery.git",     majorVersion: 0),
        // end if
        
        .Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1)
    ],
    exclude: []
)

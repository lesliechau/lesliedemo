
import Foundation
import Kitura
import LoggerAPI
import HeliumLogger

// Replace with {{applicationName}}
import Application

do {
  
    HeliumLogger.use(LoggerMessageType.info)

    try initialize()
    try run()
  
} catch let error {
  
    Log.error(error.localizedDescription)

}

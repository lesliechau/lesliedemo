
import Foundation
import Kitura
import LoggerAPI
import HeliumLogger

// Replace with <%= applicationName %>
import ApplicationName

do {
  
  HeliumLogger.use(LoggerMessageType.info)

  let controller = try Controller()
  
  Kitura.addHTTPServer(onPort: controller.port, with: controller.router)
 
  Kitura.run()

} catch let error {
  
  Log.error(error.localizedDescription)

}

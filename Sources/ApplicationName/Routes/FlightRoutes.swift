import Kitura

// let baseURL = {{modelName}}
let baseURL = "flight"

public func initializeFlightRoutes() {
    
    router.get(baseURL) { request, response, next in
        response.status(.OK).send("")
        next()
    }
    
    router.post(baseURL) { request, response, next in
        response.status(.OK).send("")
        next()
    }
    
    router.put(baseURL) { request, response, next in
        response.status(.OK).send("")
        next()
    }
    
    router.delete(baseURL) { request, response, next in
        response.status(.OK).send("")
        next()
    }
    
}

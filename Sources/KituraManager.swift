import Kitura

public class KituraManager {
    private let router = Router()
    
    // MARK: - Construct
    public init (onPort port: Int = 8080) {
        Kitura.addHTTPServer(onPort: port, with:router)
        
        self.confiugRouter()
    }
    
    // MARK: - Http Requests (Inner)
    private func confiugRouter() {
        self.router.get("/aa") {
            request, response, next in
            response.send("Hello, World!")
            next()
        }
    }
    
    // MARK: - Start / Stop
    public func start() {
        Kitura.run()
    }
    
    public func stop() {
        Kitura.stop()
    }
}


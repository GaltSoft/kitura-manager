import Kitura

public class KituraManager {
    private let router = Router()
    
    // MARK: - Construct
    public init (onPort port: Int = 8080) {
        Kitura.addHTTPServer(onPort: port, with: self.router)
        
        self.setupRouter()
    }
    
    // MARK: - Http Requests (Inner)
    private func setupRouter() {
        self.router.get("/") {
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

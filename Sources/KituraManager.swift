import Kitura

public typealias CBMethod = (RouterRequest, RouterResponse) -> Bool

public class KituraManager {
    internal let router = Router()
    init(_ port: Int = 8080) {
        Kitura.addHTTPServer(onPort: port, with: router)
    }
  
    // MARK: - Http Requests (Inner)
    public func setupRouter(_ routerMethod: String, path: String,  callback: @escaping CBMethod) {
        guard let method = RouterMethod(rawValue: routerMethod) else { return }
        let handler:RouterHandler =  {req, resp, next in
            if callback(req, resp) {
                return
            }
            next()
        }

        switch method {
        case .all:
            self.router.all(path, handler:handler)
            
        case .get:
            self.router.get(path, handler:handler)
            
        case .post:
            self.router.post(path, handler:handler)
            
        case .put:
            self.router.put(path, handler:handler)
            
        case .head:
            self.router.head(path, handler:handler)
            
        case .delete:
            self.router.delete(path, handler:handler)
            
        case .options: 
            self.router.options(path, handler:handler)
            
        case .trace:
            self.router.trace(path, handler:handler)
            
        case .copy:
            self.router.copy(path, handler:handler)
            
        case .lock:
            self.router.lock(path, handler:handler)
            
        case .mkCol:
            self.router.mkCol(path, handler:handler)
            
        case .move:
            self.router.move(path, handler:handler)
            
        case .purge:
            self.router.purge(path, handler:handler)
            
        case .propFind:
            self.router.propFind(path, handler:handler)
            
        case .propPatch:
            self.router.propPatch(path, handler:handler)
            
        case .unlock:
            self.router.unlock(path, handler:handler)
            
        case .report:
            self.router.report(path, handler:handler)
            
        case .mkActivity:
            self.router.mkActivity(path, handler:handler)
            
        case .checkout:
            self.router.checkout(path, handler:handler)
            
        case .merge:
            self.router.merge(path, handler:handler)
            
        case .mSearch:
            self.router.mSearch(path, handler:handler)
            
        case .notify:
            self.router.notify(path, handler:handler)
            
        case .subscribe:
            self.router.subscribe(path, handler:handler)
            
        case .unsubscribe:
            self.router.unsubscribe(path, handler:handler)
            
        case .patch:
            self.router.patch(path, handler:handler)
            
        case .search:
            self.router.search(path, handler:handler)
            
        case .connect:
            self.router.connect(path, handler:handler)
            
        default:
            print("Unknown route mode")
        }
    }
}

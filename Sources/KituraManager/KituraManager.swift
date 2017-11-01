import Kitura
import Reflection

public typealias CBMethod = (RouterRequest, RouterResponse) -> Bool
public protocol KMModel {  }

public class KituraManager {
    internal let _router: Router
    public init(_ port: Int = 8080, router: Router? = nil) {
        _router = router ?? Router()
        if router == nil {
            Kitura.addHTTPServer(onPort: port, with: _router)
        }
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
            _router.all(path, handler:handler)
            
        case .get:
            _router.get(path, handler:handler)
            
        case .post:
            _router.post(path, handler:handler)
            
        case .put:
            _router.put(path, handler:handler)
            
        case .head:
            _router.head(path, handler:handler)
            
        case .delete:
            _router.delete(path, handler:handler)
            
        case .options: 
            _router.options(path, handler:handler)
            
        case .trace:
            _router.trace(path, handler:handler)
            
        case .copy:
            _router.copy(path, handler:handler)
            
        case .lock:
            _router.lock(path, handler:handler)
            
        case .mkCol:
            _router.mkCol(path, handler:handler)
            
        case .move:
            _router.move(path, handler:handler)
            
        case .purge:
            _router.purge(path, handler:handler)
            
        case .propFind:
            _router.propFind(path, handler:handler)
            
        case .propPatch:
            _router.propPatch(path, handler:handler)
            
        case .unlock:
            _router.unlock(path, handler:handler)
            
        case .report:
            _router.report(path, handler:handler)
            
        case .mkActivity:
            _router.mkActivity(path, handler:handler)
            
        case .checkout:
            _router.checkout(path, handler:handler)
            
        case .merge:
            _router.merge(path, handler:handler)
            
        case .mSearch:
            _router.mSearch(path, handler:handler)
            
        case .notify:
            _router.notify(path, handler:handler)
            
        case .subscribe:
            _router.subscribe(path, handler:handler)
            
        case .unsubscribe:
            _router.unsubscribe(path, handler:handler)
            
        case .patch:
            _router.patch(path, handler:handler)
            
        case .search:
            _router.search(path, handler:handler)
            
        case .connect:
            _router.connect(path, handler:handler)
            
        default:
            print("Unknown route mode")
        }
    }
    
    public func registerModel<T: KMModel>(_ clz: T.Type) {
        let clzName = String(describing: T.self)
        print("Class:\(clzName)")
        
        let props = try? properties(T.self)
        for prop in props! {
            print("Type:\(prop.type), Key:\(prop.key)")
        }
    }
}

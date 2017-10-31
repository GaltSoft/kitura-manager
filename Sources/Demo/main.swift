import Kitura
import KituraManager

//////////////////
// Create Manager
let mgr = KituraManager()
mgr.setupRouter("GET", path: "/") { (req, resp) -> Bool in
    resp.send("Hello, World!")
    return true
}

//////////////////
// Loading model
mgr.registerModel(Person.self)
mgr.registerModel(Car.self)

Kitura.run()

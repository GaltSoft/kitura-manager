import KituraManager

let mgr = KituraManager()
mgr.setupRouter("GET", path: "/") { (req, resp) -> Bool in
    resp.send("Hello, World!")
    return true
}
Kitura.run()



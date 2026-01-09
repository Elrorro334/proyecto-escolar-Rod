class UrlMappings {
    static mappings = {
        "/"(controller: "main", action: "index")
        "/save"(controller: "main", action: "save") // Esta es la ruta del form
        "500"(view: '/error')
        "404"(view: '/notFound')
    }
}
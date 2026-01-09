package proyecto.escolar.rod

class UrlMappings {

    static mappings = {
        // Rutas principales apuntando al MainController
        "/"(controller: "main", action: "index")
        "/save"(controller: "main", action: "save")

        // Páginas de error
        "500"(view: '/error')
        "404"(view: '/notFound')
    }
}
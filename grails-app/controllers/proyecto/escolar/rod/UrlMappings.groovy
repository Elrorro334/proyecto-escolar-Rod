package proyecto.escolar.rod

class UrlMappings {

    static mappings = {
        // Mapeo para la raíz (Home)
        "/"(controller: "main", action: "index")

        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // Aquí puedes poner restricciones si fueran necesarias
            }
        }

        "404"(view: '/notFound')
        "500"(view: '/error')
    }
}
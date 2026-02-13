package proyecto.escolar.rod

class UrlMappings {

    static mappings = {

        "/"(controller: "main", action: "index")

        "/$controller/$action?/$id?(.$format)?"{
        }
        "404"(view: '/notFound')
        "500"(view: '/error')
        
    }
}
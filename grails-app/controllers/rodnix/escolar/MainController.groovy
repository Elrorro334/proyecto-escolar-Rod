package rodnix.escolar

class MainController {

    def index() {
        // La barra "/" al inicio es OBLIGATORIA.
        // Busca en: grails-app/views/index.gsp
        render(view: "/index")
    }

    def save() {
        def nombreUsuario = params.nombre
        if(nombreUsuario) {
            try {
                def nuevo = new Prospecto(nombre: nombreUsuario)
                if(nuevo.save(flush: true)) {
                    render(view: "/index", model: [mensaje: "Guardado OK"])
                } else {
                    render(view: "/index", model: [error: "Error: " + nuevo.errors])
                }
            } catch (Exception e) {
                render(view: "/index", model: [error: "Error BD: " + e.message])
            }
        } else {
            render(view: "/index", model: [error: "Pon nombre"])
        }
    }
}
package rodnix.escolar

class MainController {

    def index() {
    }

    def save() {
        def nombreUsuario = params.nombre
        
        if(nombreUsuario) {
            try {
                def nuevo = new Prospecto(nombre: nombreUsuario)
                if(nuevo.save(flush: true)) {
                    render(view: "index", model: [mensaje: "¡Guardado exitosamente en Neubox!"])
                } else {
                    render(view: "index", model: [error: "Error al guardar: " + nuevo.errors])
                }
            } catch (Exception e) {
                render(view: "index", model: [error: "Error de conexión a BD: " + e.message])
            }
        } else {
            render(view: "index", model: [error: "Debes escribir un nombre"])
        }
    }
}
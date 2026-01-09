package rodnix.escolar

class MainController {

    def index() {
        // Renderiza la vista index.gsp
    }

    def save() {
        // Recibe los datos del formulario
        def nombreUsuario = params.nombre
        // Verificamos el captcha (opcional por ahora para prueba rapida)
        
        if(nombreUsuario) {
            def nuevo = new Prospecto(nombre: nombreUsuario)
            if(nuevo.save(flush: true)) {
                render "<h1>¡Guardado!</h1><p>El usuario ${nombreUsuario} está en la BD de Neubox.</p><a href='/'>Volver</a>"
            } else {
                render "Error al guardar: " + nuevo.errors
            }
        } else {
            render "No enviaste nombre."
        }
    }
}
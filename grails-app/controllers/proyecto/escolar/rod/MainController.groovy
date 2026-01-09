package proyecto.escolar.rod

import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper

@Transactional
class MainController {

    // TU CLAVE SECRETA REAL (La que empieza con 6Lcx...)
    private static final String RECAPTCHA_SECRET = "6LcxNUMsAAAAAPJ3a4-1DND80YVYgPULd7rb8jKB"

    def index() {
        def lista = Prospecto.list(sort: "fechaRegistro", order: "desc")
        render(view: "/index", model: [prospectos: lista])
    }

    def save() {
        def nombreUsuario = params.nombre
        def captchaToken = params["g-recaptcha-response"]

        // 1. Validar Nombre
        if (!nombreUsuario) {
            flash.error = "El nombre es obligatorio"
            redirect(action: "index")
            return
        }

        // 2. Validar Captcha
        if (!verificarCaptcha(captchaToken)) {
            // Si falla, mostramos error en rojo
            def lista = Prospecto.list(sort: "fechaRegistro", order: "desc")
            render(view: "/index", model: [error: "Captcha inválido. Intenta de nuevo.", prospectos: lista])
            return
        }

        // 3. Guardar
        def nuevo = new Prospecto(nombre: nombreUsuario)
        if (nuevo.save(flush: true)) {
            flash.message = "¡Guardado exitosamente!"
            redirect(action: "index")
        } else {
            def lista = Prospecto.list(sort: "fechaRegistro", order: "desc")
            render(view: "/index", model: [error: "Error al guardar: " + nuevo.errors, prospectos: lista])
        }
    }

    // --- CORRECCIÓN AQUÍ: Usamos HttpURLConnection nativo ---
    private boolean verificarCaptcha(String token) {
        if (!token) return false
        
        try {
            String urlStr = "https://www.google.com/recaptcha/api/siteverify"
            String postData = "secret=${RECAPTCHA_SECRET}&response=${token}"
            
            // 1. Abrir la conexión
            def connection = new URL(urlStr).openConnection()
            connection.setRequestMethod("POST")
            connection.setDoOutput(true) // Habilitar envío de datos
            
            // 2. Enviar los parámetros (secret y token)
            connection.outputStream.withWriter { writer ->
                writer.write(postData)
            }
            
            // 3. Leer la respuesta de Google
            String responseText = connection.inputStream.text
            def json = new JsonSlurper().parseText(responseText)
            
            // Debug para ver qué dice Google en tu consola
            println " Google dice: " + json 
            
            return json.success
        } catch (Exception e) {
            println " Error de conexión con Google: ${e.message}"
            return false
        }
    }
}
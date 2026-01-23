package proyecto.escolar.rod

import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper

@Transactional
class MainController {

    private static final String RECAPTCHA_SECRET = "6LcxNUMsAAAAAPJ3a4-1DND80YVYgPULd7rb8jKB"

    def index() {
        render(view: "index") 
    }

    def lista() {
        def lista = Prospecto.list(sort: "fechaRegistro", order: "desc")
        render(view: "lista", model: [prospectos: lista])
    }

    def save() {
        def nombreUsuario = params.nombre
        def captchaToken = params["g-recaptcha-response"]

        if (!nombreUsuario) {
            flash.error = "El nombre es obligatorio"
            redirect(action: "index")
            return
        }

        if (!verificarCaptcha(captchaToken)) {
            render(view: "index", model: [error: "Captcha inválido", nombre: nombreUsuario])
            return
        }

        def nuevo = new Prospecto(nombre: nombreUsuario)
        if (nuevo.hasProperty('fechaRegistro')) {
            nuevo.fechaRegistro = new Date()
        }

        if (nuevo.save(flush: true)) {
            flash.message = "¡Guardado exitosamente!"
            redirect(action: "lista")
        } else {
            flash.error = "Error al guardar"
            render(view: "index", model: [prospecto: nuevo])
        }
    }

    private boolean verificarCaptcha(String token) {
        if (!token) return false
        try {
            String urlStr = "https://www.google.com/recaptcha/api/siteverify"
            String postData = "secret=${RECAPTCHA_SECRET}&response=${token}"
            def connection = new URL(urlStr).openConnection()
            connection.setRequestMethod("POST")
            connection.setDoOutput(true)
            connection.outputStream.withWriter { writer -> writer.write(postData) }
            String responseText = connection.inputStream.text
            def json = new JsonSlurper().parseText(responseText)
            return json.success
        } catch (Exception e) { return false }
    }

    // En grails-app/controllers/.../FormController.groovy

    def probarError() {
        // Esto simula un NullPointerException o cualquier fallo catastrófico
        throw new RuntimeException("¡Simulacro de Explosión Nuclear! ☢️ Testeando la vista 500.")
    }
}
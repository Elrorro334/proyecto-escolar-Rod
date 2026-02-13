package proyecto.escolar.rod

import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper

class ProspectoService {

    private static final String RECAPTCHA_SECRET = '6LcxNUMsAAAAAPJ3a4-1DND80YVYgPULd7rb8jKB'

    boolean validarCaptcha(String token) {
        if (!token) return false
        try {
            def url = "https://www.google.com/recaptcha/api/siteverify"
            def postData = "secret=${RECAPTCHA_SECRET}&response=${token}"
            def connection = new URL(url).openConnection()
            connection.setRequestMethod("POST")
            connection.setDoOutput(true)
            connection.outputStream.withWriter { it.write(postData) }
            
            def json = new JsonSlurper().parseText(connection.inputStream.text)
            return json.success
        } catch (Exception e) {
            log.error "Error en validación reCAPTCHA: ${e.message}"
            return false
        }
    }

    @Transactional
    def guardar(ProspectoCommand cmd) {
        Prospecto p = cmd.id ? Prospecto.get(cmd.id) : new Prospecto()
        if (!p && cmd.id) return null

        p.nombre = cmd.nombre
        p.correo = cmd.correo
        p.telefono = cmd.telefono
        //p.mensaje = cmd.mensaje
        
        if (!p.id) p.fechaRegistro = new Date()

        return p.save(flush: true) 
    }

    @Transactional
    def borrar(Long id) {
        def prospecto = Prospecto.get(id)
        if (!prospecto) {
            throw new IllegalArgumentException("El registro ya no existe")
        }
        prospecto.delete(flush: true)
    }
}
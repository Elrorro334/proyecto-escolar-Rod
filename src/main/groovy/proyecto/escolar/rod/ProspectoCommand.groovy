package proyecto.escolar.rod

import grails.validation.Validateable

class ProspectoCommand implements Validateable {
    Long id
    String nombre
    String correo
    String telefono
    String mensaje
    String recaptchaToken 

    static constraints = {
        nombre blank: false, size: 3..50
        correo blank: false, email: true, unique: true, size: 5..100
        telefono blank: false, size: 10..11, matches: "[0-9]+"
        mensaje nullable: true, maxSize: 500
        recaptchaToken nullable: true
        id nullable: true
    }
}
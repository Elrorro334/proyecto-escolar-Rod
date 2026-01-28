package proyecto.escolar.rod

import grails.validation.Validateable

class FormController {

    // SEGURIDAD 1: Solo permite POST. Bloquea intentos de acceso por URL.
    static allowedMethods = [simular: "POST", index: "GET"]

    def index() {
        render(view: "formulario", model: [cmd: new FormularioCommand()])
    }

    def simular(FormularioCommand cmd) {
        // SEGURIDAD 2: Validación estricta del lado del servidor
        if (cmd.hasErrors()) {
            render(view: "formulario", model: [cmd: cmd])
            return
        }

        // SEGURIDAD 3: Sanitización de Salida (Output Encoding) para prevenir XSS
        // Aunque sanitizamos la entrada, volvemos a codificar al mostrar.
        flash.message = "¡Información recibida para ${cmd.nombre.encodeAsHTML()}!"
        redirect(action: "index")
    }
}

class FormularioCommand implements Validateable {
    String nombre
    String email
    String telefono
    String password
    Integer anosExperiencia
    BigDecimal pretensionSalarial
    String modalidad
    String departamento
    List<String> habilidades
    Boolean aceptaTerminos

    // SEGURIDAD 4: Sanitización Profunda (Input Cleaning)
    // Se ejecuta automáticamente antes de validar. Elimina scripts y basura.
    void setNombre(String val) { this.nombre = val?.replaceAll(/<[^>]*>/, "")?.trim() }
    void setEmail(String val) { this.email = val?.trim()?.toLowerCase() }

    static constraints = {
        // SEGURIDAD 5: Regex Whitelisting (Solo permitimos lo bueno)
        nombre blank: false, size: 5..60, matches: /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/
        
        email blank: false, email: true, size: 5..80
        
        telefono blank: false, matches: /^[0-9]{10}$/
        
        // Pass: Min 8, 1 Mayus, 1 Num, 1 Caracter especial permitido
        password blank: false, size: 8..30, matches: /^(?=.*\d)(?=.*[A-Z]).{8,}$/
        
        anosExperiencia nullable: true, min: 0, max: 50
        
        // Evitamos inyección de números negativos o desbordamientos de buffer
        pretensionSalarial nullable: true, min: 1000.0G, max: 1000000.0G, scale: 2
        
        // SEGURIDAD 6: Strict List Matching
        // Estas listas coinciden EXACTAMENTE con tu HTML. Si envían otra cosa, falla.
        modalidad blank: false, inList: ["Remoto", "Híbrido", "Presencial"]
        
        departamento blank: false, inList: ["Desarrollo", "Infraestructura", "QA", "Ventas", "RH"]
        
        // Validación custom para verificar que cada elemento de la lista sea válido
        habilidades nullable: false, validator: { val, obj ->
            def permitidas = ['Java', 'Groovy', 'Grails', 'Spring Boot', 'React', 'Angular', 'AWS', 'Docker']
            if (!val || val.size() < 1) return 'minSize.notmet'
            // Si intentan inyectar algo que no está en la lista permitida:
            if (val.any { !permitidas.contains(it) }) return 'security.tampering.detected'
        }
        
        aceptaTerminos validator: { val -> val == true }
    }
}
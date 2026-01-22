package proyecto.escolar.rod
import grails.validation.Validateable

class FormController {

    def index() { 
        render(view: "formulario") 
    }

    def simular(FormularioCommand cmd) {
        // 1. Verificar si hay errores de validación
        if (cmd.hasErrors()) {
            render(view: "formulario", model: [cmd: cmd])
            return
        }

        // 2. Simular éxito
        flash.message = "¡Postulación recibida correctamente para ${cmd.nombre}!"
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

    static constraints = {
        // Información Personal
        nombre blank: false, size: 5..60, matches: /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/
        email blank: false, email: true
        telefono blank: false, matches: /^[0-9]{10}$/
        password blank: false, size: 8..30, matches: /^(?=.*[A-Z])(?=.*\d).{8,}$/
        
        // Perfil Profesional
        anosExperiencia nullable: true, min: 0, max: 50
        pretensionSalarial nullable: true, min: 1000.0, scale: 2
        
        // Selecciones
        modalidad blank: false, inList: ["Remoto", "Híbrido", "Presencial"]
        departamento blank: false, inList: ["Desarrollo", "Infraestructura", "QA", "Ventas", "RH"]
        habilidades nullable: false, minSize: 1
        
        // Términos
        aceptaTerminos validator: { val ->
            if (val != true) {
                return ['debe.aceptar.terminos']
            }
        }
    }
}
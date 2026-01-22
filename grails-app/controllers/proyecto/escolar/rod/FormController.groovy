package proyecto.escolar.rod
import grails.validation.Validateable
import java.util.Calendar

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
        render(view: "formulario")
    }
}

class FormularioCommand implements Validateable {
    String nombre, email, telefono, linkedin, password, biografia, modalidad, departamento
    Integer anosExperiencia
    BigDecimal pretensionSalarial
    Date fechaDisponibilidad
    List<String> habilidades
    Boolean aceptaTerminos

    static constraints = {
        // Validaciones de Texto
        nombre blank: false, size: 5..60
        email blank: false, email: true
        telefono matches: /^[0-9]{10}$/
        linkedin nullable: true, url: true
        password size: 8..30, matches: /^(?=.*[A-Z])(?=.*\d).*$/
        biografia maxSize: 2000, nullable: true
        
        // Validaciones Numéricas
        anosExperiencia min: 0, max: 50, nullable: false
        pretensionSalarial min: 1000.0, scale: 2, nullable: false
        
        // CORRECCIÓN CRÍTICA AQUÍ: 
        // Usamos Calendar estándar de Java en lugar de .clearTime()
        fechaDisponibilidad nullable: false, validator: { val, obj ->
            if (val == null) return true
            
            // Creamos una fecha "Hoy" a las 00:00:00 sin usar clearTime()
            Calendar hoy = Calendar.getInstance()
            hoy.set(Calendar.HOUR_OF_DAY, 0)
            hoy.set(Calendar.MINUTE, 0)
            hoy.set(Calendar.SECOND, 0)
            hoy.set(Calendar.MILLISECOND, 0)
            
            // Validamos que la fecha ingresada sea hoy o futuro
            return val >= hoy.getTime()
        }
        
        // Listas y Booleanos
        modalidad inList: ["Remoto", "Híbrido", "Presencial"], nullable: false
        departamento inList: ["Desarrollo", "Infraestructura", "QA", "Ventas", "RH"], nullable: false
        habilidades minSize: 1, nullable: false
        aceptaTerminos validator: { it == true }
    }
}
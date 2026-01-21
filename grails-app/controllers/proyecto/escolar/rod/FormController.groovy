package proyecto.escolar.rod

import grails.validation.Validateable

class FormController {

    def index() {
        // Renderiza la vista vacía inicialmente
        render(view: "formulario")
    }

    // Acción que recibe el formulario
    def simular(FormularioCommand cmd) {
        if (cmd.hasErrors()) {
            // Si hay errores (excepciones de validación), regresamos a la vista
            // Grails automáticamente pasa el objeto 'cmd' con los errores a la vista
            render(view: "formulario", model: [cmd: cmd])
            return
        }

        // Si todo sale bien (Simulación de éxito)
        flash.message = "¡Formulario validado correctamente! Datos recibidos en memoria: ${cmd.nombre}"
        render(view: "formulario")
    }
}

// Command Object: Define los tipos de datos y las reglas
class FormularioCommand implements Validateable {
    
    // 1. Tipos de Texto
    String nombre
    String email
    String password
    String sitioWeb
    String biografia // TextArea
    
    // 2. Tipos Numéricos
    Integer edad
    BigDecimal salario // Moneda/Decimales
    
    // 3. Fechas
    Date fechaNacimiento
    
    // 4. Selección (Enums o Listas)
    String genero // Radio buttons
    String departamento // Select simple
    List<String> habilidades // Select múltiple
    
    // 5. Booleanos
    Boolean aceptaTerminos

    // REGLAS DE VALIDACIÓN (Aquí se generan las "excepciones" si no se cumplen)
    static constraints = {
        nombre blank: false, size: 3..50
        email blank: false, email: true
        password blank: false, minSize: 6
        sitioWeb url: true, nullable: true
        biografia maxSize: 1000, nullable: true
        
        edad range: 18..99, nullable: false
        salario min: 0.0, scale: 2
        
        fechaNacimiento nullable: false, max: new Date() // No fechas futuras
        
        genero inList: ["Masculino", "Femenino", "Otro"], nullable: false
        departamento inList: ["Ventas", "TI", "RH"], nullable: false
        habilidades minSize: 1 // Al menos una habilidad seleccionada
        
        // Validador personalizado: debe ser true
        aceptaTerminos validator: { val, obj ->
            val == true
        }
    }
}
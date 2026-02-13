package proyecto.escolar.rod

import grails.converters.JSON
// ELIMINÉ EL IMPORT DE JAVAX QUE ROMPÍA TODO

class ApiController {

    ProspectoService prospectoService
    
    static allowedMethods = [
        index: "GET",
        show: "GET",
        save: "POST",
        update: "POST",
        delete: "POST"
    ]

    // 1. LISTAR
    def index() {
        def lista = Prospecto.list(sort: 'fechaRegistro', order: 'desc')
        render lista as JSON
    }

    // 2. MOSTRAR UNO (GET)
    def show() {
        def prospecto = Prospecto.get(params.id)
        if (!prospecto) {
            response.status = 404 // Usamos 404 directo sin librerías
            render([exito: false, mensaje: 'No encontrado'] as JSON)
            return
        }
        render([exito: true, data: prospecto] as JSON)
    }

    // POST /api/save
    def save(ProspectoCommand cmd) {
        // 1. Validación de datos (Campos vacíos, formato incorrecto)
        if (cmd.hasErrors()) {
            response.status = 400
            // Usamos el helper para dar un solo mensaje claro en lugar de una lista técnica
            render([exito: false, mensaje: obtenerMensajeError(cmd)] as JSON)
            return
        }

        // 2. Validación de Captcha
        // Nota: cmd.recaptchaToken puede ser nulo si el front falla, validarCaptcha lo maneja
        if (!prospectoService.validarCaptcha(cmd.recaptchaToken)) {
            response.status = 400
            render([exito: false, mensaje: 'Captcha inválido o expirado'] as JSON)
            return
        }

        // 3. Guardar en Base de Datos
        try {
            prospectoService.guardar(cmd)
            render([exito: true, mensaje: 'Guardado correctamente'] as JSON)
        } catch (Exception e) {
            // Logueamos el error en consola del servidor (para ti), pero al usuario le damos un mensaje genérico
            log.error "Error guardando prospecto: ${e.message}"
            
            response.status = 500
            render([exito: false, mensaje: 'Ocurrió un error interno al guardar el registro'] as JSON)
        }
    }

    // --- HELPER PARA MENSAJES AMIGABLES ---
    // Pon esto al final de tu clase ApiController, antes de la última llave }
    private String obtenerMensajeError(def obj) {
        if (!obj.errors.hasErrors()) return "Error desconocido"
        
        def error = obj.errors.allErrors.first()
        
        // Personaliza tus mensajes aquí según el código de error
        switch(error.code) {
            case 'nullable': return "El campo ${error.field} es obligatorio"
            case 'blank':    return "El campo ${error.field} no puede estar vacío"
            case 'email':    return "El formato del correo es inválido"
            case 'matches':  return "El formato del teléfono es incorrecto (Solo números)"
            case 'unique':   return "Este correo ya está registrado"
            case 'size':     return "El tamaño del campo ${error.field} es incorrecto"
            default:         return "Error en el campo ${error.field}"
        }
    }

    // 4. ACTUALIZAR (POST) - YA NO PIDE CAPTCHA
    def update(ProspectoCommand cmd) {
        if (!cmd.id) {
            response.status = 400
            render([exito: false, mensaje: 'ID requerido'] as JSON)
            return
        }

        if (cmd.hasErrors()) {
            response.status = 400
            render([exito: false, mensaje: obtenerMensajeError(cmd)] as JSON)
            return
        }

        try {
            prospectoService.guardar(cmd)
            render([exito: true, mensaje: 'Actualizado correctamente'] as JSON)
        } catch (Exception e) {
            log.error "Error actualizando: ${e.message}"
            response.status = 500
            render([exito: false, mensaje: 'Error interno al actualizar'] as JSON)
        }
    }

    // 5. ELIMINAR (POST)
    def delete() {
        if (!params.id) {
            response.status = 400
            render([exito: false, mensaje: 'ID requerido'] as JSON)
            return
        }

        try {
            // Convertimos el ID a Long para asegurar que sea un número
            Long id = params.long('id') 
            
            // Usamos el servicio (Transactional)
            prospectoService.borrar(id)
            
            render([exito: true, mensaje: 'Eliminado correctamente'] as JSON)
        } catch (IllegalArgumentException e) {
            response.status = 404
            render([exito: false, mensaje: e.message] as JSON)
        } catch (Exception e) {
            // Si hay llave foránea u otro error, esto te dirá EXACTAMENTE qué pasó
            response.status = 409 // Conflict
            render([exito: false, mensaje: "No se pudo eliminar: ${e.message}"] as JSON)
        }
    }
}
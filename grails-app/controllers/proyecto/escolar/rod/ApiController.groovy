package proyecto.escolar.rod

import grails.converters.JSON

class ApiController {

    ProspectoService prospectoService
    
    static allowedMethods = [
        index: "GET",
        show: "GET",
        save: "POST",
        update: "POST",
        delete: "POST"
    ]

def index() {
        int max = params.max ? params.max.toInteger() : 5 // Por defecto 5
        int offset = params.offset ? params.offset.toInteger() : 0

        def criteria = Prospecto.createCriteria()
        def resultados = criteria.list(max: max, offset: offset) {
            if (params.nombre) ilike('nombre', "%${params.nombre}%")
            if (params.correo) ilike('correo', "%${params.correo}%")
            if (params.telefono) ilike('telefono', "%${params.telefono}%")
            order('fechaRegistro', 'desc')
        }

        render([data: resultados, total: resultados.totalCount] as JSON)
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
        if (cmd.hasErrors()) {
            response.status = 400
            render([exito: false, mensaje: obtenerMensajeError(cmd)] as JSON)
            return
        }

        if (!prospectoService.validarCaptcha(cmd.recaptchaToken)) {
            response.status = 400
            render([exito: false, mensaje: 'Captcha inválido o expirado'] as JSON)
            return
        }

        try {
            prospectoService.guardar(cmd)
            render([exito: true, mensaje: 'Guardado correctamente'] as JSON)
        } catch (Exception e) {
            log.error "Error guardando prospecto: ${e.message}"
            
            response.status = 500
            render([exito: false, mensaje: 'Ocurrió un error interno al guardar el registro'] as JSON)
        }
    }

    private String obtenerMensajeError(def obj) {
        if (!obj.errors.hasErrors()) return "Error desconocido"
        
        def error = obj.errors.allErrors.first()
        
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
            Long id = params.long('id') 
            
            prospectoService.borrar(id)
            
            render([exito: true, mensaje: 'Eliminado correctamente'] as JSON)
        } catch (IllegalArgumentException e) {
            response.status = 404
            render([exito: false, mensaje: e.message] as JSON)
        } catch (Exception e) {
            response.status = 409
            render([exito: false, mensaje: "No se pudo eliminar: ${e.message}"] as JSON)
        }
    }
}
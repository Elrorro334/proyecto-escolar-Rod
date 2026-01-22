package proyecto.escolar.rod

import grails.gorm.transactions.Transactional

@Transactional
class ImagenController {

    def index() {
        [listaImagenes: Imagen.list(sort: 'id', order: 'desc')] // Ordenar por más reciente
    }

    def subir() {
        def archivo = request.getFile('fotoPayload')

        // 1. VALIDACIÓN BÁSICA: ¿Hay archivo?
        if (!archivo || archivo.empty) {
            flash.error = "No seleccionaste ningún archivo"
            redirect(action: "index")
            return
        }

        // 2. VALIDACIÓN DE SEGURIDAD: ¿Es realmente una imagen?
        // Verificamos el MIME Type (cabecera del archivo)
        def tiposPermitidos = ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/jpg']
        
        if (!tiposPermitidos.contains(archivo.contentType)) {
            flash.error = "ERROR DE SEGURIDAD: El archivo no es una imagen válida. Tipo detectado: ${archivo.contentType}"
            redirect(action: "index")
            return
        }

        // 3. GUARDADO
        def nuevaImagen = new Imagen(
            nombreOriginal: archivo.originalFilename,
            contentType: archivo.contentType,
            datos: archivo.bytes
        )

        if (!nuevaImagen.save(flush: true)) {
            flash.error = "Error de BD: ${nuevaImagen.errors}"
        } else {
            flash.message = "Imagen guardada correctamente"
        }
        
        redirect(action: "index")
    }

    // NUEVA ACCIÓN: ELIMINAR
    def eliminar(Long id) {
        Imagen img = Imagen.get(id)
        if (img) {
            try {
                img.delete(flush: true)
                flash.message = "Imagen eliminada permanentemente."
            } catch (Exception e) {
                flash.error = "No se pudo eliminar: ${e.message}"
            }
        } else {
            flash.error = "La imagen no existe o ya fue borrada."
        }
        redirect(action: "index")
    }

    def renderizar(Long id) {
        Imagen img = Imagen.get(id)
        if (img) {
            response.contentType = img.contentType
            response.contentLength = img.datos.length
            response.outputStream << img.datos
            response.outputStream.flush()
        }
    }
}
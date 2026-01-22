package proyecto.escolar.rod

class Imagen {
    String nombreOriginal
    String contentType 
    byte[] datos       

    static constraints = {
        nombreOriginal blank: false
        contentType blank: false
        // ACTUALIZADO: Aumentado a 20MB (20 * 1024 * 1024) para coincidir con tu YAML
        datos maxSize: 20971520, nullable: false 
    }
    
    static mapping = {
        datos type: 'binary' 
    }
}
package proyecto.escolar.rod

class Imagen {
    String nombreOriginal
    String contentType // Ej: 'image/jpeg', 'image/png'
    byte[] datos       // Aquí se guarda la imagen binaria

    static constraints = {
        nombreOriginal blank: false
        contentType blank: false
        // maxSize: 5MB aprox (5 * 1024 * 1024). 
        // Importante para que GORM cree una columna tipo LONGBLOB en la BD
        datos maxSize: 5242880, nullable: false 
    }
    
    static mapping = {
        // Aseguramos que no se cargue el array de bytes gigante en listas simples
        // a menos que se pida explícitamente (Lazy loading)
        datos type: 'binary' 
    }
}
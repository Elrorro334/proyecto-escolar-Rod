package proyecto.escolar.rod

class Prospecto {
    String nombre    
    String telefono
    String correo
    Date fechaRegistro = new Date()

    static constraints = {
        nombre blank: false, size: 3..50
        correo blank: false, email: true, unique: true, size: 5..100
        telefono blank: false, size: 10..11, matches: "[0-9]+"
    }
}
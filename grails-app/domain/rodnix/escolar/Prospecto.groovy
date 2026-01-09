package rodnix.escolar

class Prospecto {
    String nombre
    Date fechaRegistro = new Date()

    static constraints = {
        nombre blank: false, size: 3..100
    }
}
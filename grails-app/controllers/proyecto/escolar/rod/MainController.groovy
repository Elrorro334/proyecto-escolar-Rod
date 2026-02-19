package proyecto.escolar.rod

class MainController {

    static allowedMethods = [index: "GET", lista: "GET", edit: "GET"]

    def index() {
        render(view: 'index')
    }
}
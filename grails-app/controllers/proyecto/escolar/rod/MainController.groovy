package proyecto.escolar.rod

class MainController {

    static allowedMethods = [index: "GET", lista: "GET", edit: "GET"]

    def index() {
        render(view: 'index')
    }

    def lista() {
        render(view: 'lista')
    }

    def edit() {
        if (!params.id) {
            redirect(action: 'lista')
            return
        }
        render(view: 'editar', model: [prospectoId: params.id])
    }
}
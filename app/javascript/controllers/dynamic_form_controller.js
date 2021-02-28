import {Controller} from "stimulus"

export default class extends Controller {
    static get targets() {
        return ['template', 'addButton']
    }

    add_field() {
        const template = this.templateTarget.innerHTML
        this.addButtonTarget.insertAdjacentHTML('beforebegin', template)
    }
}
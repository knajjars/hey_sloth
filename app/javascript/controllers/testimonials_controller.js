import {Controller} from "stimulus"

export default class extends Controller {
    click(event) {
        Turbolinks.visit(event.currentTarget.dataset.url)
    }
}
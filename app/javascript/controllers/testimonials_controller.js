import {Controller} from "stimulus"

export default class extends Controller {
    click(event) {
        if (event.target.id === 'toggle-showcase') return;
        
        Turbolinks.visit(event.currentTarget.dataset.url)
    }
}
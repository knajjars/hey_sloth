import {Controller} from "stimulus"

export default class extends Controller {
    static get targets() {
        return ['destination']
    }

    show() {
        this.destinationTarget.setAttribute('tooltip', true)
        setTimeout(() => {
            this.destinationTarget.removeAttribute('tooltip')
        }, 5000)
    }
}
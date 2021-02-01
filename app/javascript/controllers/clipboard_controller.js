import {Controller} from "stimulus"

export default class extends Controller {
    static get targets() {
        return ['source']
    }

    static classes = ['supported', 'success'];

    connect() {
        if (document.queryCommandSupported("copy")) {
            this.element.classList.add(this.supportedClass);
        }
    }

    copy() {
        this.sourceTarget.select();
        document.execCommand('copy');
        this.element.classList.add(this.successClass);
    }
}
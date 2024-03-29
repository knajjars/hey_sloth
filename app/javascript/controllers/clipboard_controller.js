import {Controller} from "stimulus"

export default class extends Controller {
    static get targets() {
        return ['source']
    }

    copy() {
        this.sourceTarget.select();
        document.execCommand('copy');
    }
}
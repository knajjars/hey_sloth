import {Controller} from "stimulus"

import {iframeResize} from 'iframe-resizer'

export default class extends Controller {
    static targets = ["iframe"]

    connect() {
        const element = this.iframeTarget
        iframeResize({log: false}, element)
    }
}
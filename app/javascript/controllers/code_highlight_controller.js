import {Controller} from "stimulus"

import hljs from "highlight.js/lib/core";

export default class extends Controller {

    connect() {
        document.querySelectorAll('div.code-snippet pre code').forEach((block) => {
            hljs.highlightBlock(block);
        });
    }
}
import {Controller} from "stimulus"

import hljs from 'highlight.js/lib/core'
import 'highlight.js/styles/github.css';

hljs.registerLanguage('xml', require('highlight.js/lib/languages/xml'));

export default class extends Controller {

    connect() {
        document.querySelectorAll('div.code-snippet pre code').forEach((block) => {
            hljs.highlightBlock(block);
        });
    }
}
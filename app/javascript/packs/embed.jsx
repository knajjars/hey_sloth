import React from 'react'
import ReactDOM from 'react-dom'

require("stylesheets/tailwind.scss")

import {Testimonials} from "../widget/Testimonials";


document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <Testimonials testimonials={[{content: "some-content"}]}/>,
        document.body.appendChild(document.createElement('div')),
    )
})
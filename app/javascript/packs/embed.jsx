import React from 'react'
import ReactDOM from 'react-dom'

require("stylesheets/tailwind.scss")

import {Testimonials} from "../widget/Testimonials";

const token = document.querySelector("#testimonials").dataset.heywallId

const testimonialsNode = document.querySelector("#testimonials")
const event = (typeof Turbolinks == "object" && Turbolinks.supported) ? "turbolinks:load" : 'DOMContentLoaded'

document.addEventListener(event, () => {
    ReactDOM.render(
        <Testimonials token={token}/>,
        testimonialsNode
    )
})

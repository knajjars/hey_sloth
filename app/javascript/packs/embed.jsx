import React from 'react'
import ReactDOM from 'react-dom'

import {Testimonials} from "../widget/Testimonials";

const token = document.querySelector("#testimonials")?.dataset?.heywallId

const testimonialsNode = document.querySelector("#testimonials")

if (testimonialsNode !== null && testimonialsNode.childNodes.length === 0) {

    ReactDOM.render(
        <Testimonials token={token}/>,
        testimonialsNode
    )
}

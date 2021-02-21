import React, {useState, useEffect} from 'react';

import {LinkTestimonial} from './components/LinkTestimonial'

const test_node = document.querySelector('#is-testimonial-test')
const url = test_node !== null && test_node.dataset.test === "true" ? "http://api.lvh.me:3000" : "http://api.heysloth.com"


export function Testimonials(props) {
    const [testimonials, setTestimonials] = useState([]);

    useEffect(() => {
        fetch(`${url}/${props.token}/testimonials`, {headers: {accept: 'application/json'}})
            .then(response => response.json())
            .then(data => setTestimonials(data))
    }, []);


    if (testimonials.length === 0) {
        return (
            <span className="inline-flex rounded-md shadow-sm bg-purple-600 text-white">
          <button type="button"
                  className="inline-flex items-center px-4 py-2 border border-transparent text-base leading-6 font-medium rounded-md text-white bg-rose-600 hover:bg-rose-500 focus:border-rose-700 active:bg-rose-700 transition ease-in-out duration-150 cursor-not-allowed"
                  disabled="">
            <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none"
                 viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"/>
              <path className="opacity-75" fill="currentColor"
                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"/>
            </svg>
            Loading
          </button>
        </span>
        )
    }

    return (
        <div className="bg-blue-400">
            {testimonials.map((testimonial) => (
                <LinkTestimonial key={testimonial.name} testimonial={testimonial}/>
            ))}
        </div>
    );
}


import React, {useState, useEffect} from 'react';

import {LinkTestimonial} from './components/LinkTestimonial'

export function Testimonials() {
    const [testimonials, setTestimonials] = useState([]);

    useEffect(() => {
        fetch('http://api.lvh.me:3000/NWhuqg7jfoKRLvkJr7u3Hbfk/testimonials', {headers: {accept: 'application/json'}})
            .then(response => response.json())
            .then(data => setTestimonials(data))
    }, []);

    return (
        <div className="bg-blue-400">
            {testimonials.map((testimonial) => (
                <LinkTestimonial testimonial={testimonial}/>
            ))}
        </div>
    );
}


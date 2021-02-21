import React from 'react'

export const LinkTestimonial = props => {
    const {testimonial} = props
    return (
        <div className="bg-white dark:bg-gray-800 border-gray-200 dark:border-gray-800 p-4 rounded-xl border max-w-xl">
            <div className="flex justify-between">
                <div className="flex items-center">
                    <img src={testimonial.image_url} alt="User of testimonial" className="h-12 w-12 rounded-full"/>

                    <div className="ml-1.5 text-sm leading-tight">
                        <a href={testimonial.social_link} target="_blank"
                           className="text-black dark:text-white font-bold block">
                            {testimonial.name}
                        </a>

                        <a href={testimonial.social_link} target="_blank"
                           className="text-gray-500 dark:text-gray-400 font-normal block">
                            {`@${testimonial.social_link.split("/").pop()}`}
                        </a>
                    </div>

                </div>
            </div>
        </div>
    )
}
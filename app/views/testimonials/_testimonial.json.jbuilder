json.extract! testimonial, :id, :user_name, :user_company, :user_role, :user_link, :user_testimonial, :created_at, :updated_at
json.url testimonial_url(testimonial, format: :json)

require 'rails_helper'

RSpec.describe TestimonialPolicy, type: :policy do
  let(:current_user_testimonial) { create(:testimonial, :with_fire_link) }
  let(:other_user_testimonial) { create(:testimonial, :with_fire_link) }
  let(:current_user) { current_user_testimonial.user }
  let(:other_user) { other_user_testimonial.user }

  permissions :show? do
    it 'allows owner of testimonial to see it' do
      expect(TestimonialPolicy).to permit(current_user, current_user_testimonial)
      expect(TestimonialPolicy).to permit(other_user, other_user_testimonial)
    end

    it 'prevents non-owners of testimonial from seeing it' do
      expect(TestimonialPolicy).to_not permit(other_user, current_user_testimonial)
      expect(TestimonialPolicy).to_not permit(current_user, other_user_testimonial)
    end
  end

  permissions :toggle_showcase? do
    it 'allows owner to toggle showcase' do
      expect(TestimonialPolicy).to permit(current_user, current_user_testimonial)
      expect(TestimonialPolicy).to permit(other_user, other_user_testimonial)
    end

    it 'prevents non-owners of testimonial from toggling' do
      expect(TestimonialPolicy).to_not permit(other_user, current_user_testimonial)
      expect(TestimonialPolicy).to_not permit(nil, current_user_testimonial)
    end
  end

  permissions :destroy? do
    it 'allows owner to destroy it' do
      expect(TestimonialPolicy).to permit(current_user, current_user_testimonial)
      expect(TestimonialPolicy).to permit(other_user, other_user_testimonial)
    end

    it 'prevents non-owners of testimonial from destroying it' do
      expect(TestimonialPolicy).to_not permit(current_user, other_user_testimonial)
      expect(TestimonialPolicy).to_not permit(other_user, current_user_testimonial)
    end
  end
end

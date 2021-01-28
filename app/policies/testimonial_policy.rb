class TestimonialPolicy < ApplicationPolicy
  def show?
    user == record.user
  end

  def toggle_showcase?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end

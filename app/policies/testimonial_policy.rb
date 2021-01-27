class TestimonialPolicy < ApplicationPolicy
  def show?
    user == record.user
  end

  def create?
    true
  end

  def new?
    true
  end


  def toggle_showcase?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end

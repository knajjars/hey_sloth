class ShareableLinkPolicy < ApplicationPolicy
<<<<<<< HEAD

  def show?
    user == record.user
  end
  
=======
>>>>>>> 25aca334a649808160b36750cc670ed0e33b3809
  def update?
    user == record.user
  end

  def edit?
    update?
  end

  def destroy?
    user == record.user
  end

  def send_email_new?
    user == record.user
  end

  def send_email_create?
    user == record.user
  end

  def from_shareable_link_new?
    true
  end

  def from_shareable_link_create?
    true
  end

end
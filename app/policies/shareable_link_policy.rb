class ShareableLinkPolicy < ApplicationPolicy
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
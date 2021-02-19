require 'rails_helper'

RSpec.describe FireLinkPolicy, type: :policy do
  let(:current_user_fire_link) { create(:fire_link) }
  let(:other_user_fire_link) { create(:fire_link) }
  let(:current_user) { current_user_fire_link.user }
  let(:other_user) { other_user_fire_link.user }

  permissions :update? do
    it 'allows owner of fire_link to update it' do
      expect(FireLinkPolicy).to permit(current_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(other_user, other_user_fire_link)
    end

    it 'prevents non-owners of fire_link from updating it' do
      expect(FireLinkPolicy).to_not permit(other_user, current_user_fire_link)
      expect(FireLinkPolicy).to_not permit(current_user, other_user_fire_link)
    end
  end

  permissions :edit? do
    it 'allows owner of fire_link to edit it' do
      expect(FireLinkPolicy).to permit(current_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(other_user, other_user_fire_link)
    end

    it 'prevents non-owners of fire_link from editing it' do
      expect(FireLinkPolicy).to_not permit(other_user, current_user_fire_link)
      expect(FireLinkPolicy).to_not permit(current_user, other_user_fire_link)
    end
  end

  permissions :destroy? do
    it 'allows owner of fire_link to destroy it' do
      expect(FireLinkPolicy).to permit(current_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(other_user, other_user_fire_link)
    end

    it 'prevents non-owners of fire_link from destroying it' do
      expect(FireLinkPolicy).to_not permit(other_user, current_user_fire_link)
      expect(FireLinkPolicy).to_not permit(current_user, other_user_fire_link)
    end
  end

  permissions :send_email_new? do
    it 'allows owner of fire_link to send it in email' do
      expect(FireLinkPolicy).to permit(current_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(other_user, other_user_fire_link)
    end

    it 'prevents non-owners of fire_link from sending it in email' do
      expect(FireLinkPolicy).to_not permit(other_user, current_user_fire_link)
      expect(FireLinkPolicy).to_not permit(current_user, other_user_fire_link)
    end
  end

  permissions :send_email_create? do
    it 'allows owner of fire_link to create email' do
      expect(FireLinkPolicy).to permit(current_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(other_user, other_user_fire_link)
    end

    it 'prevents non-owners of fire_link from creating email' do
      expect(FireLinkPolicy).to_not permit(other_user, current_user_fire_link)
      expect(FireLinkPolicy).to_not permit(current_user, other_user_fire_link)
    end
  end

  permissions :from_fire_link_new? do
    it 'allows any user to view testimonial form from fire_link' do
      expect(FireLinkPolicy).to permit(current_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(other_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(nil, current_user_fire_link)
    end
  end

  permissions :from_fire_link_create? do
    it 'allows any user to create testimonial from fire_link' do
      expect(FireLinkPolicy).to permit(current_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(other_user, current_user_fire_link)
      expect(FireLinkPolicy).to permit(nil, current_user_fire_link)
    end
  end
end

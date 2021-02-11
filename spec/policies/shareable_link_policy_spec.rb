require 'rails_helper'

RSpec.describe ShareableLinkPolicy, type: :policy do
  let(:current_user_shareable_link) { create(:shareable_link) }
  let(:other_user_shareable_link) { create(:shareable_link) }
  let(:current_user) { current_user_shareable_link.user }
  let(:other_user) { other_user_shareable_link.user }

<<<<<<< HEAD
  permissions :show? do
    it 'allows owner of shareable_link to see it' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, other_user_shareable_link)
    end

    it 'prevents non-owners of shareable_link from seeing it' do
      expect(ShareableLinkPolicy).to_not permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to_not permit(current_user, other_user_shareable_link)
    end
  end

=======
>>>>>>> 25aca334a649808160b36750cc670ed0e33b3809
  permissions :update? do
    it 'allows owner of shareable_link to update it' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, other_user_shareable_link)
    end

    it 'prevents non-owners of shareable_link from updating it' do
      expect(ShareableLinkPolicy).to_not permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to_not permit(current_user, other_user_shareable_link)
    end
  end

  permissions :edit? do
    it 'allows owner of shareable_link to edit it' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, other_user_shareable_link)
    end

    it 'prevents non-owners of shareable_link from editing it' do
      expect(ShareableLinkPolicy).to_not permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to_not permit(current_user, other_user_shareable_link)
    end
  end

  permissions :destroy? do
    it 'allows owner of shareable_link to destroy it' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, other_user_shareable_link)
    end

    it 'prevents non-owners of shareable_link from destroying it' do
      expect(ShareableLinkPolicy).to_not permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to_not permit(current_user, other_user_shareable_link)
    end
  end

  permissions :send_email_new? do
    it 'allows owner of shareable_link to send it in email' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, other_user_shareable_link)
    end

    it 'prevents non-owners of shareable_link from sending it in email' do
      expect(ShareableLinkPolicy).to_not permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to_not permit(current_user, other_user_shareable_link)
    end
  end

  permissions :send_email_create? do
    it 'allows owner of shareable_link to create email' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, other_user_shareable_link)
    end

    it 'prevents non-owners of shareable_link from creating email' do
      expect(ShareableLinkPolicy).to_not permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to_not permit(current_user, other_user_shareable_link)
    end
  end

  permissions :from_shareable_link_new? do
    it 'allows any user to view testimonial form from shareable_link' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(nil, current_user_shareable_link)
    end
  end

  permissions :from_shareable_link_create? do
    it 'allows any user to create testimonial from shareable_link' do
      expect(ShareableLinkPolicy).to permit(current_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(other_user, current_user_shareable_link)
      expect(ShareableLinkPolicy).to permit(nil, current_user_shareable_link)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Collects', type: :request do
  let(:fire_link) { FactoryBot.create(:fire_link, image_required: false) }
  let(:user) { fire_link.user }
  let(:other_user) { FactoryBot.create(:user) }
  let(:tweet_testimonial) { FactoryBot.create(:testimonial, :tweet) }
  let(:valid_body) do
    FactoryBot.attributes_for(:testimonial).except(:content).merge({ rich_text: '<div><strong>This is awesome!<br></strong><br></div><ul><li>I am a test</li><li><em>and this rocks!</em></li><li><del>truly.</del></li></ul>' })
  end
  let(:invalid_body) { FactoryBot.attributes_for(:testimonial).except(:content) }
  let(:valid_tweet_body) { FactoryBot.attributes_for(:testimonial, :tweet) }
  let(:invalid_tweet_body) { FactoryBot.attributes_for(:testimonial) }

  describe '#from_fire_link_new' do
    it 'renders for unauthenticated user' do
      get collect_from_fire_link_new_url(fire_link.slug)
      expect(response).to have_http_status(200)
      expect(response).to render_template('collect/from_fire_link_new')
    end

    it 'redirects to not found if wrong fire link' do
      get collect_from_fire_link_new_url("#{fire_link.slug}_invalid")
      expect(response).to have_http_status(404)
      expect(response.body).to include("The page you were looking for doesn't exist.")
    end
  end

  describe '#from_fire_link_create' do
    it 'redirects to not found if wrong fire link' do
      post collect_from_fire_link_create_url("#{fire_link.slug}_invalid"), params: { testimonial: valid_body }
      expect(response).to have_http_status(400)
      expect(response.body).to include('Your request has something wrong')
    end

    it 'creates testimonial for owner of fire link' do
      expect do
        post collect_from_fire_link_create_url(fire_link.slug), params: { testimonial: valid_body }
      end.to change(Testimonial, :count).by(1)
      expect(user.testimonials.count).to be(1)
      expect(other_user.testimonials.count).to be(0)
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('Testimonial was successfully created.')
      expect(response).to render_template('page/index')
    end

    it 'renders errors for missing attributes of testimonial' do
      expect do
        post collect_from_fire_link_create_url(fire_link.slug), params: { testimonial: invalid_body }
      end.to_not change(Testimonial, :count)
      expect(user.testimonials.count).to be(0)
      expect(response.body).to include('Content can&#39;t be blank')
      expect(response).to render_template('collect/from_fire_link_new')
    end
  end

  describe '#send_email_new' do
    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      get collect_send_email_new_url(fire_link.slug)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include('Not authorized')
    end

    it 'renders for authenticated user of fire link' do
      sign_in user
      get collect_send_email_new_url(fire_link.slug)
      expect(response).to have_http_status(200)
      expect(response).to render_template('collect/send_email_new')
    end

    it 'redirects to login if not authenticated' do
      get collect_send_email_new_url(fire_link.slug)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end
  end

  describe '#send_email_create' do
    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      post collect_send_email_create_url(fire_link.slug)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include('Not authorized')
    end

    it 'renders bad request if emails addresses are missing' do
      sign_in user
      post collect_send_email_create_url(fire_link.slug)
      expect(response).to have_http_status(400)
      expect(response.body).to include('Your request has something wrong')
    end

    it 'sends emails for authenticated user' do
      sign_in user
      expect do
        post collect_send_email_create_url(fire_link.slug),
             params: { email_addresses: ['example@example.com', 'otherexample@example.com'] }
      end.to change { ActionMailer::Base.deliveries.count }.by(2)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/fire_link")
      follow_redirect!
      expect(response.body).to include('Successfully sent email to recipients!')
    end

    it 'redirects to login if not authenticated' do
      post collect_send_email_create_url(fire_link.slug)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end
  end

  describe '#twitter_search' do
    it 'redirects to login if not authenticated' do
      get collect_twitter_search_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders twitter search for authenticated user' do
      sign_in user
      get collect_twitter_search_url
      expect(response).to have_http_status(200)
      expect(response).to render_template('collect/twitter_search')
    end
  end

  describe '#twitter_post_create' do
    it 'redirects to login if not authenticated' do
      post collect_twitter_post_create_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'collects tweet testimonial for user' do
      sign_in user
      expect do
        post collect_twitter_post_create_url, params: { testimonial: valid_tweet_body }
      end.to change(Testimonial, :count).by(1)

      expect(user.testimonials.tweets.first.tweet_status_id).to eq(valid_tweet_body[:tweet_status_id])
      expect(user.testimonials.tweets.first.social_link).to eq(valid_tweet_body[:social_link])
      expect(user.testimonials.tweets.first.tweet_url).to eq(valid_tweet_body[:tweet_url])
      expect(user.testimonials.tweets.first.tweet_user_id).to eq(valid_tweet_body[:tweet_user_id])
      expect(user.testimonials.tweets.first.content).to eq(valid_tweet_body[:content])
      expect(user.testimonials.tweets.first.tweet_image_url).to eq(valid_tweet_body[:tweet_image_url])

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('Successfully collected twitter post!')
    end
  end

  describe '#delete_tweet' do
    it 'redirects to login if not authenticated' do
      delete collect_delete_tweet_url(tweet_testimonial.tweet_status_id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'if tweet does not exist redirects to bad request' do
      sign_in user
      delete collect_delete_tweet_url('random')
      expect(response).to have_http_status(400)
      expect(response.body).to include('Your request has something wrong')
    end

    it 'it deletes tweet for user' do
      current_user = tweet_testimonial.user
      sign_in current_user
      delete collect_delete_tweet_url(tweet_testimonial.tweet_status_id)
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('Removed twitter post!')
    end
  end

  describe '#twitter_post_new' do
    it 'redirects to login if not authenticated' do
      get collect_twitter_post_new_url(tweet_url: 'https://twitter.com/knajjars/status/1345818236923863041')
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'loads valid tweet and renders view' do
      sign_in user
      get collect_twitter_post_new_url(tweet_url: 'https://twitter.com/knajjars/status/1345818236923863041')
      expect(response).to have_http_status(200)
      expect(response).to render_template('collect/twitter_post_new')
      expect(response.body).to include('It took me 5 hipster years to give it a try to @rails for my side projects.')
    end

    it 'alerts of invalid Twitter post URL' do
      sign_in user
      get collect_twitter_post_new_url(tweet_url: 'random')
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template('collect/twitter_post_new')
      expect(response.body).to include('Please copy a valid twitter post URL.')
    end
  end
end

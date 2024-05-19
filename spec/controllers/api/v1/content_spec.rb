require 'rails_helper'
require 'devise/jwt/test_helpers'


RSpec.describe Api::V1::ContentsController, type: :controller do
  let(:user){FactoryBot.create(:user)}
  let(:other_user){FactoryBot.create(:user)}
  let(:content) { FactoryBot.create(:content, user: user) }
  let(:other_content) { FactoryBot.create(:content, user: other_user) }
  let(:valid_attributes) { { id: content.id, title: Faker::Lorem.sentence, body: Faker::Lorem.sentence } }
  let(:invalid_attributes) { {id: content.id, title: '', body: '' } }
  let(:other_valid_attributes) { { id: other_content.id, title: Faker::Lorem.sentence, body: Faker::Lorem.sentence } }
  let(:other_invalid_attributes) { {id: other_content.id, title: '', body: '' } }

 
  describe "authenticated user" do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge!(auth_headers)
    end
    describe 'GET contents' do
      it 'returns a success response' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /contents' do
      context 'when attributes are valid' do
        it 'creates a new content' do
          post :create, params: valid_attributes 
          expect(response).to have_http_status(:created)
        end
      end

      context 'when attributes are invalid' do
        it 'doesnot create new content' do
          post :create, params: invalid_attributes 
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'PUT /contents/:id' do
      context 'when user owns the content' do
        context 'when updated with valid attributes' do
          it 'updates the content' do
            put :update, params: valid_attributes
            expect(response).to have_http_status(:success)
          end
        end
        context 'when updated with invalid attributes' do
          it 'doesnot updates the content' do
            put :update, params: invalid_attributes
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      context 'when user doesnot owns the content' do
        context 'when updated with valid attributes' do
          it 'doesnot updates the content and returns status forbidden' do
            put :update, params: other_valid_attributes
            expect(response).to have_http_status(:forbidden)
          end
        end

        context 'when updated with invalid attributes' do
          it 'doesnot updates the content and returns status forbidden' do
            put :update, params: other_invalid_attributes
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end

    describe 'DELETE /contents/:id' do
      context 'when user owns the content' do
        it 'deletes the content' do
          delete :destroy, params: {id: content.id}
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when user doesnot own the content' do
        it 'doesnot delete the content and returns forbidden' do
          delete :destroy, params: {id: other_content.id}
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe "unauthenticated user" do
    describe 'GET contents' do
      it 'returns a success response' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'POST /contents' do
      context 'when attributes are valid' do
        it 'creates a new content' do
          post :create, params: valid_attributes 
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when attributes are invalid' do
        it 'doesnot create new content' do
          post :create, params: invalid_attributes 
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    describe 'PUT /contents/:id' do
      context 'when user owns the content' do
        context 'when updated with valid attributes' do
          it 'updates the content' do
            put :update, params: valid_attributes
            expect(response).to have_http_status(:unauthorized)
          end
        end
        context 'when updated with invalid attributes' do
          it 'doesnot updates the content' do
            put :update, params: invalid_attributes
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      context 'when user doesnot owns the content' do
        context 'when updated with valid attributes' do
          it 'doesnot updates the content and returns status forbidden' do
            put :update, params: other_valid_attributes
            expect(response).to have_http_status(:unauthorized)
          end
        end

        context 'when updated with invalid attributes' do
          it 'doesnot updates the content and returns status forbidden' do
            put :update, params: other_invalid_attributes
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end

    describe 'DELETE /contents/:id' do
      context 'when user owns the content' do
        it 'deletes the content' do
          delete :destroy, params: {id: content.id}
          expect(response).to have_http_status(:unauthorized)
        end
      end
      context 'when user doesnot own the content' do
        it 'doesnot delete the content and returns forbidden' do
          delete :destroy, params: {id: other_content.id}
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
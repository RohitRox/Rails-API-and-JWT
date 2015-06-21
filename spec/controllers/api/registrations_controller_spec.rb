require 'rails_helper'

RSpec.describe Api::RegistrationsController, type: :controller do

  describe "Post #create" do

    let(:user_params) do
      {
        email: email,
        password: password
      }
    end

    context "with invalid email and password" do
      let(:email){ "bad@email" }
      let(:password){ "pass" }
      it "returns proper error message with response code 422" do
        post :create, { user: user_params, format: :json }
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(422)
        expect(json["errors"]).to be_present
      end
    end

    context "with valid email and password" do
      let(:email){ "good@email.com" }
      let(:password){ "password" }
      it "returns user json with response code 201" do
        post :create, { user: user_params, format: :json }
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(201)
        expect(json["errors"]).not_to be_present
        expect(json["data"]["email"]).to eq(email)
      end
    end

  end
end

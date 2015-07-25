require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do

  describe "GET #show" do

    let(:user){ create(:user) }

    it "returns profile" do
      get :show, {user_id: user}, format: :json
      json = JSON.parse response.body
      expect(json['data']).to be_present
      expect(json['data']).to be_kind_of(Hash)
      expect(json['data'].keys).to eql(['user_id', 'email', 'first_name', 'last_name', 'gender', 'avatar_url', 'bio', 'location'])
    end
  end

  describe "PUT #update" do

    let(:user){ create(:user) }

    let(:profile_params) do
      {
        first_name: "NewFirstName",
        last_name: "NewLastName"
      }
    end

    subject{ put :update, { profile: profile_params, user_id: user }, format: :json }

    context "user auth-token is not present" do
      it "return appropriate error message" do
        subject
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(401)
        expect(json["errors"]).to be_present
      end
    end

    context "user auth-token is present and user is not the current_user" do
      before{ authenticate }
      it "return appropriate error message" do
        subject
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(401)
        expect(json["errors"]).to be_present
      end
    end

    context "user auth-token is present and user is the current_user" do
      before{ authenticate(user) }
      it "update user profile" do
        subject
        json = JSON.parse response.body
        expect(json['data']).to be_present
        expect(json['data']).to be_kind_of(Hash)
        expect(json['data'].keys).to eql(['user_id', 'email', 'first_name', 'last_name', 'gender', 'avatar_url', 'bio', 'location'])
      end
    end
  end

end

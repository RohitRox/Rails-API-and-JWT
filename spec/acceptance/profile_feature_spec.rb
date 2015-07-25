require 'rails_helper'
require 'rspec_api_documentation/dsl'
include RspecApiHelpers

resource "Profile" do

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/api/users/:id/profile" do

    let(:profile){ create(:profile) }
    let(:user){ create(:user, profile: profile) }
    let(:id) { user.id }

    example "Get user profile" do
      do_request
      status.should == 200
    end

  end

  put "/api/users/:id/profile" do

    parameter :first_name, "First Name", required: false, scope: :profile
    parameter :last_name, "Last Name", required: false, scope: :profile
    parameter :gender, "Gender", required: false, scope: :profile
    parameter :bio, "Bio", required: false, scope: :profile
    parameter :location, "Location/Address", required: false, scope: :profile

    let(:profile){ create(:profile) }
    let(:user){ create(:user, profile: profile) }
    let(:id) { user.id }

    let(:first_name){ "Roxxy" }
    let(:last_name){ "Poxxy" }
    let(:gender){ "Male" }
    let(:bio){ "About myself ..." }
    let(:location){ "NYC" }

    context "Unauthorized" do
      example "Update user profile (by other user)" do
        set_auth_headers
        do_request
        status.should == 200
      end
    end

    context "Authorized" do
      example "Update user profile (by user him/herself)" do
        set_auth_headers(user)
        do_request
        status.should == 200
      end
    end

  end
end

require 'rails_helper'
require 'rspec_api_documentation/dsl'
include RspecApiHelpers

resource "Protected Resource" do

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  delete "api/posts/:id" do
    let(:post){ create(:post) }
    let(:id) { post.id }

    example "Request without authentic user" do
      do_request
      expect(status).to eq 200
    end

    example "Request with authentic user" do
      set_auth_headers
      do_request
      expect(status).to eq 200
    end

  end
end

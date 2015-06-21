require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  post "/api/users" do
    parameter :email, "Email", required: true, scope: :user
    parameter :password, "Password", required: true, scope: :user

    context "Valid user params" do

      let(:email) { "email@example.com" }
      let(:password) { "password" }
      let(:password_confirmation) { "password" }

      example "Creating a new user with valid params" do
        do_request
        status.should == 200
      end
    end

    context "Blank user params" do

      let(:email) { "" }
      let(:password) { "" }

      example "Creating a new user with blank params" do
        do_request
        status.should == 200
      end
    end

    context "Invalid user params" do

      let(:email) { "email@examplecom" }
      let(:password) { "123456" }

      example "Creating a new user with invalid params" do
        do_request
        status.should == 200
      end
    end

  end

  post "/api/users/sign_in" do
    parameter :email, "Email", required: true, scope: :user
    parameter :password, "Password", required: true, scope: :user

    context "Blank username and password" do
      let(:email) { "" }
      let(:password) { "" }

      example "Signing in user with blank params" do
        do_request
        status.should == 200
      end
    end

    context "Improper user email and password" do
      let(:email) { "nopes@example" }
      let(:password) { "password" }

      example "Signing in user with improper params" do
        do_request
        status.should == 200
      end
    end

    context "Invalid password" do
      let(:email) { "email@example.com" }
      let(:password) { "password" }

      before do
        User.create!(
          email: email,
          password: "nopenope",
          password_confirmation: "nopenope"
        )
      end

      example "Signing in user with invalid password" do
        do_request
        status.should == 200
      end
    end

    context "Valid user email and password" do
      let(:email) { "email@example.com" }
      let(:password) { "password" }

      before do
        User.create!(
          email: email,
          password: password,
          password_confirmation: password
        )
      end

      example "Signing in user with valid email and password" do
        do_request
        status.should == 200
      end
    end

  end

end

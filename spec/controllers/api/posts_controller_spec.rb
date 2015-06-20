require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do

  describe "GET #index" do

    before do
      10.times{ create(:post) }
    end

    it "returns posts with in standard json format that contains data, meta and links" do
      get :index, format: :json
      json = JSON.parse response.body
      expect(json['data']).to be_present
      expect(json['data']).to be_kind_of(Array)
      expect(json['meta']).to be_present
    end

    it "returns meta information in meta attribute" do
      get :index, format: :json
      json = JSON.parse response.body
      expect(json['meta']).to eq(
        {
          "current_page"=>1,
          "next_page"=>nil,
          "prev_page"=>nil,
          "total_pages"=>1,
          "total_count"=>10,
          "sort"=>"created_at", "order"=>"desc"
        })
    end

    it "returns posts limited by parameter per_page" do
      get :index, { per_page: 5, format: :json }
      json = JSON.parse response.body
      expect(json["data"].size).to eq(5)
      expect(json['meta']).to eq(
        {
          "current_page"=>1,
          "next_page"=>2,
          "prev_page"=>nil,
          "total_pages"=>2,
          "total_count"=>10,
          "sort"=>"created_at", "order"=>"desc"
        })
    end

    it "returns posts at given page specified by parameter page" do
      get :index, { per_page: 5, page: 2, format: :json }
      json = JSON.parse response.body
      expect(json["data"].size).to eq(5)
      expect(json['meta']).to eq(
        {
          "current_page"=>2,
          "next_page"=>nil,
          "prev_page"=>1,
          "total_pages"=>2,
          "total_count"=>10,
          "sort"=>"created_at", "order"=>"desc"
        })
    end

    it "returns posts sorted and ordered specified by parameter sort and order" do
      get :index, { sort: "id", order: "asc", format: :json }
      json = JSON.parse response.body
      expect(json["data"].size).to eq(10)
      expect(json["data"][0]["id"]).to eq(Post.first.id)
      expect(json['meta']).to eq(
        {
          "current_page"=>1,
          "next_page"=>nil,
          "prev_page"=>nil,
          "total_pages"=>1,
          "total_count"=>10,
          "sort"=>"id", "order"=>"asc"
        })
    end

  end

  describe "GET #show" do

    let!(:post) { create(:post) }

    it "returns specified post in standard json format" do
      get :show, { id: post.id, format: :json }
      json = JSON.parse response.body
      expect(json['data']).to be_present
      expect(json['data']).to be_kind_of(Hash)
      expect(json['data']['title']).to eq(post.title)
    end
  end

  describe "POST #create" do

    context "with valid params" do
      let(:valid_attributes) do
        {
          title: "Some title",
          content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit obcaecati architecto nostrum pariatur quasi culpa distinctio sit. Corrupti suscipit, quod alias sed voluptatum, error sunt laboriosam nulla libero, tenetur saepe."
        }
      end
      it "creates a new Post" do
        expect {
          post :create, { post: valid_attributes, format: :json }
        }.to change(Post, :count).by(1)
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(201)
        expect(json['data']).to be_kind_of(Hash)
        expect(json["links"]).to be_present
      end
    end

    context "with invalid params" do
      context "empty title" do
        let(:invalid_attributes) do
          {
            title: "",
            content: "Some content"
          }
        end
        it "returns a proper error message with response code 422" do
          post :create, { post: invalid_attributes, format: :json }
          json = JSON.parse response.body
          expect(json["response"]["code"]).to eq(422)
          expect(json["errors"]).to be_present
        end
      end
      context "duplicate title" do
        before { create(:post, title: "title") }
        let(:invalid_attributes) do
          {
            title: "title",
            content: "Some Content"
          }
        end
        it "returns a proper error message with response code 422" do
          post :create, { post: invalid_attributes, format: :json }
          json = JSON.parse response.body
          expect(json["response"]["code"]).to eq(422)
          expect(json["errors"]).to be_present
        end
      end
    end
  end

  describe "PUT #update" do

    let!(:post){ create(:post) }

    context "with valid params" do
      let(:new_attributes) do
         {
          title: "changed title"
         }
      end

      it "updates the requested post" do
        put :update, { id: post.id, post: new_attributes, format: :json }
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(200)
        expect(json["errors"]).not_to be_present
        expect(json['data']).to be_kind_of(Hash)
        expect(json["links"]).to be_present
      end
    end
    context "with invalid params" do
      let(:invalid_attributes) do
         {
          title: ""
         }
      end

      it "returns a proper error message with response code 422" do
        put :update, { id: post.id, post: invalid_attributes, format: :json }
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(422)
        expect(json["errors"]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post){ create(:post) }
    context "delete is successful" do
      it "destroys the requested post and returns empty body with response code 204" do
        expect {
          delete :destroy, { id: post.id, format: :json }
        }.to change(Post, :count).by(-1)
        json = JSON.parse response.body
        expect(json["response"]["code"]).to eq(204)
        expect(json["data"]).not_to be_present
      end
    end
  end

end

if @post.errors.present?
  json.errors @post.errors.messages
  json.response do
    json.code 422
  end
else
  json.data do
    json.id   @post.id
    json.title @post.title
    json.content @post.content
    json.upvotes @post.upvotes.to_i
    json.downvotes @post.downvotes.to_i
  end
  json.response do
    json.code 201
  end
  json.links do
    json.self api_post_url(@post)
  end
end

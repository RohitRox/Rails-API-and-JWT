json.data @posts do |post|
  json.id   post.id
  json.title post.title
  json.content post.content
  json.upvotes post.upvotes.to_i
  json.downvotes post.downvotes.to_i
end
json.meta @meta

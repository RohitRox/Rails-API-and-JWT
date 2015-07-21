json.data do
  json.id  @post.id
  json.upvotes @post.upvotes.to_i
end
json.response do
  json.code 200
end

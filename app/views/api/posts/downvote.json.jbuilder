json.data do
  json.id  @post.id
  json.downvotes @post.downvotes.to_i
end
json.response do
  json.code 200
end

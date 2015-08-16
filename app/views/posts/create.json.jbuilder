json.extract! @post, :content, :created_at
json.author @post.user.name

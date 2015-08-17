json.extract! @post, :content, :id
json.created_at format_date_comments(@post.created_at)
json.author @post.user.name

# app/jobs/charge_credit_card.rb
class NewCommentNotification < Que::Job
  # Default settings for this job. These are optional - without them, jobs
  # will default to priority 100 and run immediately.
  @priority = 10
  @run_at = proc { Time.now }

  def run(user, comment, options)
    puts "new comment notification"

    owner_name = comment.homework.user.name
    user_name = user.name

    puts "----------------------------"
    puts "Dear, #{owner_name}"
    puts "User #{user_name} has commented your homework."
    puts comment.text
    puts "----------------------------"

    # Destroy the job.
    destroy
  end
end

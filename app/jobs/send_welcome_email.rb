# app/jobs/charge_credit_card.rb
class SendWelcomeEmail < Que::Job
  # Default settings for this job. These are optional - without them, jobs
  # will default to priority 100 and run immediately.
  @priority = 10
  @run_at = proc { 1.minute.from_now }

  def run(options)
    @user = User.find(20)
    UserMailer.welcome_email(@user).deliver_now

    # Destroy the job.
    destroy
  end
end

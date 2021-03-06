# app/jobs/charge_credit_card.rb
class ChargeCreditCard < Que::Job
  # Default settings for this job. These are optional - without them, jobs
  # will default to priority 100 and run immediately.
  @priority = 10
  @run_at = proc { 1.minute.from_now }

  def run(user_id, options)
    # Do stuff.
    user = User[user_id]
    card = CreditCard[options[:credit_card_id]]

    ActiveRecord::Base.transaction do
      # Write any changes you'd like to the database.
      user.update_attributes :charged_at => Time.now

      # It's best to destroy the job in the same transaction as any other
      # changes you make. Que will destroy the job for you after the run
      # method if you don't do it yourself, but if your job writes to the
      # DB but doesn't destroy the job in the same transaction, it's
      # possible that the job could be repeated in the event of a crash.
      destroy
    end
  end
end

# The default priority is 100, and a lower number means a higher priority. 5 would be very important.
# ChargeCreditCard.enqueue current_user.id, :credit_card_id => card.id, :run_at => 1.day.from_now, :priority => 5
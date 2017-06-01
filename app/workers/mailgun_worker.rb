class MailgunWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'mailgun', retry: 5, backtrace: true

  def perform(email_id)
    @email = Email.find(email_id)
    mg = MailgunMailer.new(@email.to_hash)
    create_recipients_emails
    # Should check if email is sent but in sandbox mode I have to authorize each email so probably the email won't be sent
    resp = mg.send_mail
    @email.update_attributes!(mailgun_id: resp['id'], mailgun_response: resp['message']) if resp.present?
  end

  def self.execute(email_id)
    perform_async(email_id)
  end

  private

  def create_recipients_emails
    %i[to cc bcc].each do |recipient_type|
      @email.send(recipient_type).each do |recipient|
        user = User.find_by_email(recipient)
        next unless user.present?
        Mailbox.create(user: user, email: @email)
      end
    end
  end
end

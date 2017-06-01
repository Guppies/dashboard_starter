class MailgunMailer
  def initialize(options = {})
    @from    = options[:from].split('@').first
    @subject = options[:subject]
    @body    = options[:body]
    @to      = options[:to]
    @cc      = options[:cc] || []
    @bcc     = options[:bcc] || []
    @id      = options[:id]
  end

  def send_mail
    logger = ActiveSupport::Logger.new('log/mailgun.log')
    mg_client = Mailgun::Client.new
    @mb_obj = Mailgun::MessageBuilder.new
    @mb_obj.from("#{@from}@#{Mailgun.domain}")

    add_recipients

    @mb_obj.subject(@subject)
    @mb_obj.body_html(@body)
    JSON.parse(mg_client.send_message(Mailgun.domain, @mb_obj).body)
  rescue => e
    logger.error e
    return false
  end

  private

  def add_recipients
    [@to, @cc, @bcc].each do |reipient_type|
      reipient_type.each do |recipient|
        @mb_obj.add_recipient(:to, recipient)
      end
    end
  end
end

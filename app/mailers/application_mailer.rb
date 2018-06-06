class ApplicationMailer < ActionMailer::Base
  default from: 'info@happyseat.fr'
  layout 'mailer'
end

class TestMailer < ActionMailer::Base
  def message
    mail(
      :subject => 'Hello from Postmark',
      :to  => 'info@happyseat.fr',
      :from => 'info@happyseat.fr',
      :html_body => '<strong>Hello</strong> dear Postmark user.',
      :track_opens => 'true')
  end
end

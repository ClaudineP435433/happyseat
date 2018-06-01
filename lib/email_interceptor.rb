class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "Test"
    message.to = [ 'info@happyseat.fr' ]
  end
end

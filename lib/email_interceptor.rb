class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "Test"
    message.to = [ 'claudinecartailler@gmail.com' ]
  end
end

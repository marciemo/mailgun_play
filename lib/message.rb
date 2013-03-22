class Message

  def initialize(attributes)
    @from = attributes[:from]
    @to = attributes[:to]
    @subject = attributes[:subject]
    @text = attributes[:text]
  end
  
  def send_it
    faraday_response = Faraday.post do |request|
      request.url "https://api.mailgun.net/v2/play.epicodus.com.mailgun.org/messages"
      request.headers['Authorization'] = "Basic " + Base64.strict_encode64("api:#{API_KEY}")
      request.body = URI.encode_www_form(:from => @from, :to => @to, :subject => @subject, :text => @text)
    end
  end

end
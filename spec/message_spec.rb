require 'spec_helper'

describe Message do

  context '#initialize' do
    it 'creates an instance of message with an argument' do
      message = Message.new(:from => 'me@icloud.com', :to => 'you@icould.com', :subject => 'hello', :text => 'test')
      message.should be_an_instance_of Message
    end
  end

  context '#valid?' do
    it 'is not valid if to email is not provided' do
      message = Message.new(:from => 'me@icloud.com', :subject => 'hello', :text => 'test')
      message.valid?.should be_false
    end
  end

  context '#send_it' do
    it 'sends an email message using the Mailgun API' do
      stub = stub_request(:post, "https://#{'api'}:#{API_KEY}@api.mailgun.net/v2/play.epicodus.com.mailgun.org/messages").to_return(:body => "[{\n  \"message\": \"Queued. Thank you.\",\n  \"id\": \"<20130322180015.1278.14541@play.epicodus.com.mailgun.org>\"\n}]")
      message = Message.new(:from => 'me@icloud.com', :to => 'you@icould.com', :subject => 'hello', :text => 'test')
      message.send_it
      stub.should have_been_requested
    end
  end

end

# Faraday.get("https://api:#{API_KEY}@api.mailgun.net/v2/play.epicodus.com.mailgun.org/log")

# request.headers['Authorization'] = "Basic " + Base64.strict_encode64("api:#{API_KEY}")

# faraday_response = Faraday.get do |request|
#   request.url "https://api.mailgun.net/v2/play.epicodus.com.mailgun.org/log"
#   request.headers['Authorization'] = "Basic " + Base64.strict_encode64("api:#{API_KEY}")
# end
# # request.body = URI.encode_www_form({'From' => attributes[:from], 'To' => attributes[:to], 'Body' => attributes[:body]})

# faraday_response = Faraday.post do |request|
#   request.url "https://api.mailgun.net/v2/play.epicodus.com.mailgun.org/messages"
#   request.headers['Authorization'] = "Basic " + Base64.strict_encode64("api:#{API_KEY}")
#   request.body = URI.encode_www_form({:from => "Exited User <me@icloud.com>", :to => "you@icloud.com", :subject => "hello", :text => "testing some mailgun awesomness!!"})
# end

# "{\n  \"message\": \"Queued. Thank you.\",\n  \"id\": \"<20130322180015.1278.14541@play.epicodus.com.mailgun.org>\"\n}" 

# Twilio example: stub = stub_request(:post, "https://#{ACCOUNT_SID}:#{AUTH_TOKEN}@api.twilio.com/2010-04-01/Accounts/#{ACCOUNT_SID}/SMS/Messages.json").with(:body => URI.encode_www_form('From' => from, 'To' => to, 'Body' => body))

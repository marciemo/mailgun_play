require './ui_helper'

def welcome
  puts "Welcome to Mailgun Play, a simple tool for email communications."
  send_message
end

def send_message
  puts "Type the address you would like to email."
  to = gets.chomp
  puts "Type your subject line."
  subject = gets.chomp
  puts "Type your message."
  text = gets.chomp
  message = Message.new(:from => USER, :to => to, :subject => subject, :text => text)
  sent_it = message.send_it
  if sent_it != nil
    puts "Your message has been sent."
  else
    puts "Message send failed. Sorry."
  end
end

welcome

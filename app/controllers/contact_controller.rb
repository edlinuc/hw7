require 'aws-sdk'

class ContactController < ApplicationController
	def index

		AWS.config(:credential_provider => AWS::Core::CredentialProviders::EC2Provider.new)
    db = AWS::SimpleDB.new
    s3 = AWS::S3.new

    bucket = s3.buckets.create bucket_name
    domain = db.domains.create domain_name

    flag = false
    begin
      domain.items.each_with_index do |it,i|
        flag = true
        @contacts << it
        puts "#{i}-#{it.name}"
        #puts ": #{it.attributes['lname'].values.join(' ')},#{it.attributes['fname'].values.join(' ')}"
      end
      puts 'Contact list is currently empty.' if !flag
    rescue Exception => e
      puts "Error: #{e}"
    end
	end
end
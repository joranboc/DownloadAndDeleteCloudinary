# frozen_string_literal: true

require 'json'
require 'cloudinary'
require 'csv'

params = {
  cloud_name: ENV["CLOUD_NAME"],
  api_key: ENV["API_KEY"],
  api_secret: ENV["API_SECRET"],
  max_results: "100",
  prefix: "",
  type: "upload",
  next_cursor: ""
}

i = 1

while i < 100
  response = Cloudinary::Api.resources(options = params)

  puts 'request ' + i.to_s + ' of 1645'

  CSV.open('data.csv', 'a+') do |csv|
    response['resources'].each do |hash|
      csv << hash.values
    end
  end

  CSV.open('cursor.csv', 'a+') do |csv|
    csv << [i, response['next_cursor']]
  end

  params[:next_cursor] = response['next_cursor']
  i += 1
end



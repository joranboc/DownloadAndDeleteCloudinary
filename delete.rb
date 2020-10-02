
# frozen_string_literal: true

require 'json'
require 'cloudinary'
require 'csv'

params = {
    cloud_name: ENV["CLOUD_NAME"],
    api_key: ENV["API_KEY"],
    api_secret: ENV["API_SECRET"],
    type: 'upload'
}

initial = 0
final = 99
i = 0


rows = CSV.open('11.csv').each.to_a.flatten


while i < 496
  puts initial
  puts final
  Cloudinary::Api.delete_resources(public_ids = rows[initial...final], options = params)
  initial = final + 1
  final += 100
  i += 1
end

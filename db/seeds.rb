require 'rest-client'
require 'pry'
require 'json'

brickset_key =  ENV["brickset_key"]
brickset_username =  ENV["brickset_username"]
brickset_password =  ENV["brickset_password"]
brickset_user_hash =  ENV["brickset_user_hash"]

base_url = "https://brickset.com/api/v3.asmx"
themes_url = base_url + "/getThemes?"
sets_url = base_url + "/getSets?"
additional_images_url = base_url + "/getAdditionalImages?"

years = "'" + (2012..2020).to_a.join(",")+"'"

get_sets_url_params = [
    "apiKey=#{brickset_key}",
    "userHash=#{brickset_user_hash}",
    "params={'theme':'technic', 'year':#{years}, 'pageSize': 200}"
].join("&")

additional_images_url_params = [
        "apiKey=#{brickset_key}",
        "setId=7575"
    ].join("&")

# response = RestClient.get(sets_url+get_sets_url_params) 
# response_hash = JSON.parse(response.body)

# response_hash["sets"].each do |set|
#     image = set["image"]["imageURL"]
#     Ad.create(img: image)
#     print "."
# end



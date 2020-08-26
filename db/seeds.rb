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

years = "'" + (2010..2020).to_a.join(",")+"'"

get_sets_url_params = [
    "apiKey=#{brickset_key}",
    "userHash=#{brickset_user_hash}",
    "params={'theme':'technic', 'year':#{years}, 'pageSize': 200}"
].join("&")

additional_images_url_params = [
        "apiKey=#{brickset_key}",
        "setId=7575"
    ].join("&")

# response = RestClient.get(additional_images_url+additional_images_url_params) 
# response_hash = JSON.parse(response.body)

# User.create(
#     name: "greg",
#     username: "greg",
#     avatar: "https://media-exp1.licdn.com/dms/image/C5603AQFb-SyZRxKFnQ/profile-displayphoto-shrink_400_400/0?e=1603929600&v=beta&t=g0edTpUYarx7iS-t8C1UX715vHDZc6z9WfI2-2Ge6gA",
#     bio: "I am the coolest instructor ever"
# )


User.all.each do |u|
    3.times do |i|
        u.posts.create(text: "postech number #{i}")
    end



end
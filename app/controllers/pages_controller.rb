class PagesController < ApplicationController
	def index
		current_date = Time.now.to_s[0...10]
		specials_response = Unirest.get("https://www.shopevergreenkosher.com/v2/retailers/1120/branches/883/specials?appId=4&filters=%7B%22must%22:%7B%22lessThan%22:%7B%22startDate%22:%22#{current_date}T04:17:29.594Z%22%7D,%22greaterThan%22:%7B%22endDate%22:%22#{current_date}T04:17:29.594Z%22%7D,%22term%22:%7B%22displayOnWeb%22:true,%22isCoupon%22:false%7D%7D%7D&from=0&size=25&sort=%7B%22priority%22:%22desc%22%7D&sort=%7B%22sort%22:%22asc%22%7D&sort=%7B%22id%22:%22desc%22%7D").body['specials']

		@specials = []

		specials_response.each do |special|
		# 	image_response = Unirest.get("https://storage.googleapis.com/sp-public/items/medium/#{special['item']['productId']}.jpg?v=1")
		# p "*" * 50
		# p "Here is image_response.code: "
		# p image_response.code
		# p "*" * 50
		# 	if image_response.code == 403
		# 		image = "https://storage.googleapis.com/sp-public/items/medium/#{special['item']['id']}.jpg?v=1"
		# 	else
		# 		image = "https://storage.googleapis.com/sp-public/items/medium/#{special['item']['productId']}.jpg?v=1"
		# 	end

		if special['item']['image'] != nil
			image_url = special['item']['image']['url'].gsub("{{size}}","medium").gsub("{{extension||'jpg'}}", "jpg")
		else
			image_url = "https://www.freeiconspng.com/uploads/no-image-icon-15.png"
		end

		if special['item']['unitOfMeasure'] != nil
			weight_unit = special['item']['unitOfMeasure']['names']['2']
		else
			weight_unit = nil
		end

		if special['item']['brand'] != nil
			brand = special['item']['brand']['names']['2']
		else
			brand = nil
		end

			special_object = {
				name: special['item']['names']['2']['long'],
				image_url: image_url,
				description: special['description'],
				regular_price: special['item']['branch']['regularPrice'],
				brand: brand,
				weight: special['item']['weight'],
				weight_unit: weight_unit
			}
			# p "*" * 50
			# p "Here is image: "
			# p image_url
			# p "*" * 50

			# p "*" * 50
			# p "Here is product weight_unit: "
			# p special_object[:weight_unit]
			# p "*" * 50
		

			@specials << special_object
		end
		
	end

	def specials
		
	end
end

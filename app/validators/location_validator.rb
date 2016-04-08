class LocationValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		local = [record.street_address, record.city].compact.join('+ ')
		men = "https://maps.googleapis.com/maps/api/geocode/json?address=#{local}&components=country:#{record.country}|postal_code:#{record.zip_code}&key=#{ENV[GOOGLE_GEOCODE_API]}"
		response = open(men).read
		data = JSON.parse(response)
		if data["status"] == "ZERO_RESULTS" && 	data['status'] != "OVER_QUERY_LIMIT"
			record.errors[attribute] << (options[:message] || "could not be found! Try another address")
		end
	end
end
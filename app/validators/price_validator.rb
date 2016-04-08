class PriceValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		if record.length >= 0 and record.length <= 250
			if record.price < 25
				record.errors[attribute] << (options[:message] || "The minimum price for an article of 250 words is 25$")
			end
		elsif record.length > 250 and record.length <= 500
			if record.price < 50 
				record.errors[attribute] << (options[:message] || "The minimum price for an article of 500 words is 50$")
			end
		elsif record.length > 500
			if record.price < 100
				record.errors[attribute] << (options[:message] || "The minimum price for an article over 500 words is 100$")
			end
		end
	end
end
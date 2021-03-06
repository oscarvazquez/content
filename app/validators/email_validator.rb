class EmailValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		unless BounceBack.check_email(value)
			record.errors[attribute] << (options[:message] || "syntax is wrong")
		end
	end
end


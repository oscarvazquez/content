class WriterValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		job = record.job
		if job.reviews.count > 2
			puts 'its going in here'
			record.errors[attribute] << (options[:message] || "You can't make a review for this job at this time")
		end
	end
end
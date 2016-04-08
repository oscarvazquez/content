module TokenProvider
	class << self
		def encode payload exp=48.hours.from_now
			payload[:exp] = exp.to_i
			JWT.encode payload, ENV['OSCAR_SECRET'], ENV['OSCAR_TYPE']
		end

		def decode token
			begin
				payload = JWT.DECODE token, ENV['OSCAR_SECRET'], true, { :algorithm => ENV['OSCAR_TYPE'] }
			end
		end
	end
end

class DecodedAuthToken < HashWithIndifferentAccess
	def expired?
		self[:exp] <= Time.now.to_i
	end
end
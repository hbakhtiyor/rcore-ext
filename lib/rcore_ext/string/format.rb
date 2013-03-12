require 'base64'
require 'base32'

class String
	@@common_formats = {bin: 'B*', hex: 'H*'}
	
	# Decode string with various formats.
	# Supported formats: :bin, :hex, :base32, :base64
	#
	# You can also pass options for Base64 to use
	# * :strict
	# * :url_safe
	#
	# 	"hello world!".decode_string(:hex) 	#=> 68656c6c6f20776f726c6421
	# 	"hi".decode_string(:bin)						#=> 0110100001101001
	#
	#   "NBSWY3DPEB3W64TMMQQQ====".decode_string(:base32) 	#=> hello world!
	#   "aGVsbG8gd29ybGQh\n".decode_string(:base64) 				#=> hello world!  
	#
	#   "aGVsbG8gd29ybGQh".decode_string(:base64, strict: true)	#=> hello world!
	def decode_string(format, options={})
		raise ArgumentError, "Format can't be empty" if format.nil? 
		format = format.to_sym		
		@options = options || {}

		case format
		when :base32
			base32_decode
		when :base64
			base64_decode
		else
			raise ArgumentError, "Unsupported format: #{format}" unless @@common_formats.has_key?(format)
			common_decode(format)
		end
	end

	# Encode string with various formats.
	# Supported formats: :bin, :hex, :base32, :base64
	#
	# You can also pass options for Base64 to use
	# * :strict
	# * :url_safe
	#
	# 	"68656c6c6f20776f726c6421".decode_string(:hex) 	#=> hello world!
	# 	"0110100001101001".decode_string(:bin)					#=> hi
	#
	#   "hello world!".decode_string(:base32) 	#=> NBSWY3DPEB3W64TMMQQQ====
	#   "hello world!".decode_string(:base64) 	#=> aGVsbG8gd29ybGQh\n  
	#
	#   "hello world!".decode_string(:base64, strict: true)	#=> aGVsbG8gd29ybGQh
	def encode_string(format, options={})
		raise ArgumentError, "Format can't be empty" if format.nil?
		format = format.to_sym
		@options = options || {}

		case format
		when :base32
			base32_encode
		when :base64
			base64_encode
		else
			raise ArgumentError, "Unsupported format: #{format}" unless @@common_formats.has_key?(format)
			common_encode(format)
		end
	end

	private
		def common_encode(format)
			[self].pack(@@common_formats[format])
		end

		def common_decode(format)
			self.unpack(@@common_formats[format]).first
		end

		def base32_encode
			Base32.encode(self)
		end

		def base32_decode
			Base32.decode(self)
		end

		def base64_encode
			if @options[:strict]
				Base64.strict_encode64(self)
			elsif @options[:url_safe]
				Base64.urlsafe_encode64(self)
			else
				Base64.encode64(self)
			end
		end

		def base64_decode
			if @options[:strict]
				Base64.strict_decode64(self)
			elsif @options[:url_safe]
				Base64.urlsafe_decode64(self)
			else
				Base64.decode64(self)
			end
		end

end
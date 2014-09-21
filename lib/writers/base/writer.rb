module Writers
	class Writer
		#attr_reader :file_to_write

		def write(content)
			raise Exception.new "Method write not implemented yet."
		end
	end
end

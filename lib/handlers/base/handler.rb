module Handlers
	class Handler
		attr_reader :file_to_process

		def read(file_path)
			raise Exception.new "Method read not implemented yet"
    end

    def write(file_path, content)
      raise Exception.new "Method write not implemented yet"
    end
	end
end

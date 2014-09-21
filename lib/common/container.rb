module Common
	module Container
		class Container
			def initialize(fields)
				fields.each do |field|
					create_attr field
				end
			end

			private
			
			def create_attr(name)
				create_method("#{name}=".to_sym) do |val| 
					instance_variable_set("@" + name, val)
				end

				create_method(name.to_sym)  do 
					instance_variable_get("@" + name) 
				end
			end

			def create_method(name, &block)
				self.class.send(:define_method, name, &block)
			end
		end
	end
end

class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |attr|
      define_method(attr) { instance_variable_get("@#{attr}") }

      define_method("#{attr}=") do |arg|
        instance_variable_set("@#{attr}", arg)
      end

    end
  end
end

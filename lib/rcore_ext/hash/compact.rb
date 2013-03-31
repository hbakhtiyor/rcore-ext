require 'active_support/core_ext/object/blank'

class Hash
  # Returns a copy of self with all nil, 
  # empty and blank elements removed.
  #
  # You can also pass option to use
  # * <tt>:keys</tt> - Only remove blank keys from a hash
  # * <tt>:values</tt> - Only remove blank values from a hash
  # * <tt>:both</tt> - Remove blank values or keys from a hash
  # * <tt>:pair</tt> - Remove blank values and keys from a hash if both are blank 
  #  
  #   {1 => 2}.compact              #=> {1 => 2}
  #   {1 => 2, nil => ''}.compact   #=> {1 => 2}
  #   {1 => 2, nil => '  '}.compact #=> {1 => 2}
  #
  #   {1 => 2, nil => 1, 2 => nil}.compact(:keys)   #=> {1 => 2, 2 => nil}
  #   {1 => 2, nil => 1, 2 => nil}.compact(:values) #=> {1 => 2, nil => 1}
  #   {1 => 2, nil => 1, 2 => nil}.compact(:both)   #=> {1 => 2}
  #   {1 => 2, nil => 1, 2 => nil}.compact(:pair)   #=> {1 => 2, nil => 1, 2 => nil}
  def compact(option = nil)
    @option = option
    result = {}
    each_pair do |key, value|
      result[key] = value unless check_for_blank?(key, value)      
    end
    result
  end
 
  # Removes nil, empty and blank elements from the hash. 
  # Returns nil if no changes were made, otherwise returns hash.
  #
  # You can also pass option to use
  # * <tt>:keys</tt> - Only remove blank keys from a hash
  # * <tt>:values</tt> - Only remove blank values from a hash
  # * <tt>:both</tt> - Remove blank values or keys from a hash
  # * <tt>:pair</tt> - Remove blank values and keys from a hash if both are blank 
  #  
  #   {1 => 2}.compact!              #=> nil
  #   {1 => 2, nil => ''}.compact!   #=> {1 => 2}
  #   {1 => 2, nil => '  '}.compact! #=> {1 => 2}
  #
  #   {1 => 2, nil => 1, 2 => nil}.compact!(:keys)   #=> {1 => 2, 2 => nil}
  #   {1 => 2, nil => 1, 2 => nil}.compact!(:values) #=> {1 => 2, nil => 1}
  #   {1 => 2, nil => 1, 2 => nil}.compact!(:both)   #=> {1 => 2}
  #   {1 => 2, nil => 1, 2 => nil}.compact!(:pair)   #=> {1 => 2, nil => 1, 2 => nil}    
  def compact!(option = nil)
    @option = option; changed = false
    each_pair do |key, value|
      (self.delete(key); changed = true) if check_for_blank?(key, value)      
    end
    changed ? self : nil
  end

  # Returns a copy of self with all nil, 
  # empty and blank nested elements removed.
  #
  # You can also pass option to use
  # * <tt>:keys</tt> - Only remove blank keys from a hash
  # * <tt>:values</tt> - Only remove blank values from a hash
  # * <tt>:both</tt> - Remove blank values or keys from a hash
  # * <tt>:pair</tt> - Remove blank values and keys from a hash if both are blank 
  #  
  #   {1 => 2}.deep_compact                       #=> {1 => 2}
  #   {1 => 2, nil => {nil => ''}}.deep_compact   #=> {1 => 2}
  #   {1 => 2, nil => {nil => '  '}}.deep_compact #=> {1 => 2}
  #
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact(:keys)   #=> {1 => 2}
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact(:values) #=> {1 => 2, {nil => 1} => {nil => 1}}
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact(:both)   #=> {1 => 2}
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact(:pair)   #=> {1 => 2, {nil => 1} => {2 => nil, nil => 1}}
  def deep_compact(option = nil)
    @option = option
    result = {}
    each_pair do |key, value|
      key   = key.deep_compact(option)    if key.is_a?(Hash)
      value = value.deep_compact(option)  if value.is_a?(Hash)

      result[key] = value unless check_for_blank?(key, value)
    end
    result
  end

  # Removes nil, empty and blank nested elements from the hash. 
  # Returns nil if no changes were made, otherwise returns hash.
  #
  # You can also pass option to use
  # * <tt>:keys</tt> - Only remove blank keys from a hash
  # * <tt>:values</tt> - Only remove blank values from a hash
  # * <tt>:both</tt> - Remove blank values or keys from a hash
  # * <tt>:pair</tt> - Remove blank values and keys from a hash if both are blank 
  #  
  #   {1 => 2}.deep_compact!                       #=> {1 => 2}
  #   {1 => 2, nil => {nil => ''}}.deep_compact!   #=> {1 => 2}
  #   {1 => 2, nil => {nil => '  '}}.deep_compact! #=> {1 => 2}
  #
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact!(:keys)   #=> {1 => 2}
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact!(:values) #=> {1 => 2, {nil => 1} => {nil => 1}}
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact!(:both)   #=> {1 => 2}
  #   {1 => 2, {nil => 1} => {2 => nil, nil => 1}}.deep_compact!(:pair)   #=> nil
  def deep_compact!(option = nil)
    @option = option; changed = false
    each_pair do |key, value|
      (changed = true unless key.deep_compact!(option).nil?)   if key.is_a?(Hash)
      (changed = true unless value.deep_compact!(option).nil?) if value.is_a?(Hash)

      (self.delete(key); changed = true) if check_for_blank?(key, value)
    end
    changed ? self : nil
  end

  private
    def check_for_blank?(key, value)
      @option ||= :pair
      case @option.to_sym
      when :keys
        key.blank?
      when :values
        value.blank?
      when :both
        key.blank? || value.blank?
      else :pair
        key.blank? && value.blank?
      end
    end
end
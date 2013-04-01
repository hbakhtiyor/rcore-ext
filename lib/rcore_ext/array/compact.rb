require 'active_support/core_ext/object/blank'

class Array
  # Returns a copy of self with all nil, 
  # empty and blank nested elements removed.
  #
  #   [1, 2, nil, [3, 4, nil, [5, nil], []], {}].deep_compact   #=> [1, 2, [3, 4, [5]]]
  #   [1, 2].deep_compact         #=> [1, 2]
  #   [1, 2, ['']].deep_compact   #=> [1, 2]
  #   [1, 2, ['  ']].deep_compact #=> [1, 2]  
  def deep_compact
    result = []
    each do |item|
      item = item.deep_compact if item.is_a?(Array)
      result << item unless item.blank?
    end
    result
  end

  # Removes nil, empty and blank nested elements from the array. 
  # Returns nil if no changes were made, otherwise returns array.
  #
  #   [1, 2, nil, [3, 4, nil, [5, nil], []], {}].deep_compact!   #=> [1, 2, [3, 4, [5]]]
  #   [1, 2].deep_compact!         #=> nil
  #   [1, 2, ['']].deep_compact!   #=> [1, 2]
  #   [1, 2, ['  ']].deep_compact! #=> [1, 2]    
  def deep_compact!
    index = 0; changed = false
    while size > index
      item = at(index)
      (changed = true unless item.deep_compact!.nil?) if item.is_a?(Array)
      (self.delete_at(index); changed = true; next) if item.blank? 
      index += 1
    end
    changed ? self : nil
  end
end
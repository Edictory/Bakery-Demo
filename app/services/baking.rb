class Baking
  def self.create_baking_list_for(category)
    # returns a hash of item name and quantity to be baked for a 
    # particular category of items like bread, muffins, etc.

    # First, get all items in the category
    all_items = Item.where(category: category.to_s).map(&:name).sort

    # Next, get all unshipped items and their quantities, then add them to the baking list hash
    baking_list = Hash[all_items.map{|name| [name, 0]}]
    unshipped_items = OrderItem.unshipped.map{|oi| [oi.item.name, oi.quantity] if all_items.include?(oi.item.name)}.compact
    unshipped_items.each{|name, quant| baking_list[name] += quant} unless unshipped_items.empty?
    baking_list.delete_if{|key, value| value == 0}
    return baking_list
  end
end  
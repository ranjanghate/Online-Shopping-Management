module CartItemsHelper
  def added_to_cart?(course_id)
    return true if !Current.cart.nil? && Current.cart.courses.find_by(id: course_id)
    false
  end
end

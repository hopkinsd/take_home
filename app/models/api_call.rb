require 'json'

class ApiCall

  attr_reader :action, :params

  VALID_ACTIONS = %i|add remove purchase cart history|
  REQUIRED_KEYS = %i|user_id|

  REQUIRED_KEYS_FOR_ACTION = {
    add: %i|user_id product_id quantity|,
    remove: %i|user_id product_id|,
    purchase: %i|user_id|,
    cart: %i|user_id|,
    history: %i|user_id|
  }
  ERRORS = {
    action: 'not a valid action',
    params: "not all required keys provided: #{REQUIRED_KEYS}"
  }

  def initialize(argv)
    @action = argv[0].to_sym
    @params = JSON.parse argv[1], symbolize_names: true
  end

  def process
    return unless valid?
    send "process_#{action}"
  end

  def valid?
    valid_action? && valid_params?
  end

  def errors
    @errors ||= [].tap do |error_array|
      error_array << 'not a valid action' unless valid_action?
      error_array <<
        "not all required keys provided: #{REQUIRED_KEYS_FOR_ACTION[action]}" unless valid_params?
    end
  end

  def error_string
    errors.join '; '
  end

  private
  def process_add
    value = user.add_item params
    errors << value if value
    process_cart
  end

  def process_remove
    value = user.remove_item(params)
    errors << value if value
    process_cart
  end

  def process_cart
    puts user.current_shopping_cart.to_item_list.to_json
  end

  def process_history
    puts user.purchase_hisotry_hash.to_json
  end

  def process_purchase
    value = user.current_shopping_cart.purchase
    errors << value if value
  end

  def user_id
    @user_id ||= params[:user_id]
  end

  def user
    @user ||= User.new user_id
  end

  def valid_action?
    VALID_ACTIONS.include? action
  end

  def valid_params?
    REQUIRED_KEYS.all? { |key| params.keys.include? key }
  end
end

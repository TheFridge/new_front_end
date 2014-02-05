class ListBuilder

  attr_reader :user, :recipes

  def initialize(user, recipes)
    @user = user
    @recipes = recipes
  end

  def format_user_information
    {"user_id" => user.id, "email" => user.email}
  end

  def prepared_to_send
    {"user" => format_user_information, "recipes" => recipes}
  end

  def to_send
    prepared_to_send.to_json
  end

end

class ListTalker
  attr_reader :conn
  LIST_TOKEN = ENV['SUPER_SECRET_TOKEN']
  def new
  end

  def send(built_list)
    post_list(built_list)
  end

  def setup_connection
    if Rails.env.development?
      url = 'http://localhost:6666'
    else
      url = 'https://list-makr.herokuapp.com'
    end

    Faraday.new(:url => url) do |faraday|
      faraday.request  :url_encoded
      faraday.token_auth(LIST_TOKEN)
 #     faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def post_list(built_list)
    conn = setup_connection
    conn.post do |req|
      req.url '/shopping-lists'
      req.headers['Content-Type'] = 'application/json'
      req.body = built_list
    end
  end

  def find(id)
    response = setup_connection.get do |req|
      req.url "/shopping-lists/#{id}"
      req.headers['Content-Type'] = 'application/json'
    end

    JSON.parse(response.body)
  end

  def get_recipes(id)
    response = setup_connection.get do |req|
      req.url "/user-recipes/#{id}"
      req.headers['Content-Type'] = 'application/json'
    end
    JSON.parse(response.body)
  end

  def destroy_item(id)
    response = setup_connection.delete do |req|
      req.url "/list-ingredients/#{id}"
      req.headers['Content-Type'] = 'application/json'
    end

    JSON.parse(response.body)
  end

  def empty_list(id)
    setup_connection.post do |req|
      req.url "/shopping-list/clear-list"
      req.params[:user_id] = id
    end
  end

  def email_list(id)
    setup_connection.post do |req|
      req.url "/shopping-list/email-list"
      req.params[:user_id] = id
    end
  end
end

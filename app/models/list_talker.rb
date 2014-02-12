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
      url = 'http://salty-scrubland-3582.herokuapp.com'
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

  def destroy_item(id)
    response = setup_connection.delete do |req|
      req.url "/list-ingredients/#{id}"
      req.headers['Content-Type'] = 'application/json'
    end

    JSON.parse(response.body)
  end
end

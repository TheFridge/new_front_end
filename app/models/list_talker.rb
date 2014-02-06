class ListTalker
  attr_reader :conn
  def new
  end

  def send(built_list)
    post_list(built_list)
  end

  def setup_connection
    Faraday.new(:url => 'http://list-makr.herokuapp.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def post_list(built_list)
    setup_connection.post do |req|
      req.url '/shopping-lists'
      req.headers['Content-Type'] = 'application/json'
      req.body = built_list
    end
  end
end

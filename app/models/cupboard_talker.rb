class CupboardTalker

  #build faraday connection
  def self.conn
    conn = Faraday.new(:url => 'http://list-makr.herokuapp.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def self.save_to_cupboard(list_id, user_id)
    # get list based on id
    list = conn.get {|req| req.url "/shopping-lists/#{list_id}"}.body

    # Post items and quantities in list to cupboard using Faraday post request
    conn.post do |req|
     req.url '/cupboards'
     req.headers['Content-Type'] = 'application/json'
     req.params['user_id'] = user_id
     req.body = list
   end
  end

  def self.get_cupboard_for_user(user_id)
    response = conn.get do |req|
      req.url "/cupboards/#{user_id}"
    end

    JSON.parse(response.body)
  end
end

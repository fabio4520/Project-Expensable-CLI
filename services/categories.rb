

module Services

  class Categories
    include HTTParty
    base_uri('https://expensable-api.herokuapp.com/')

    def self.index(token)
      header = {
        headers: { "Authorization": "Token token=#{token}" }
      }
      response = post('/categories', header)
      # raise HTTParty::ResponseError.new(response) unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end

    

  end

end

module Services

  class Categories
    include HTTParty
    base_uri('https://expensable-api.herokuapp.com/')

    def self.index(token)
      header = {
        headers: { "Authorization": "Token token=#{token}" }
      }
      response = get('/categories', header)
      raise HTTParty::ResponseError.new(response) unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.create(token, category_data)
      options = {
        headers: { 
          Authorization: "Token token=#{token}",
          "Content-Type": "application/json"
        },
        body: category_data.to_json
      }
      response = post('/categories', options)
      raise HTTParty::ResponseError.new(response) unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.destroy(token, id)
      header = {
        headers: { "Authorization": "Token token=#{token}" }
      }
      response = delete("/categories/#{id}", header)
      raise HTTParty::ResponseError.new(response) unless response.success?
      # JSON.parse(response.body, symbolize_names: true)
    end

    def self.update(token, id, category_data)
      options = {
        headers: { 
          Authorization: "Token token=#{token}",
          "Content-Type": "application/json"
        },
        body: category_data.to_json
      }
      response = patch("/categories/#{id}", options)
      raise HTTParty::ResponseError.new(response) unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.show(token, id)
      header = {
        headers: { "Authorization": "Token token=#{token}" }
      }
      response = get("/categories/#{id}", header)
      raise HTTParty::ResponseError.new(response) unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end

  end

end

module Services

  class Transactions
    include HTTParty
    base_uri('https://expensable-api.herokuapp.com/categories')

    def self.create(token, transaction_data, id)
      options = {
        headers: { 
          Authorization: "Token token=#{token}",
          "Content-Type": "application/json"
        },
        body: transaction_data.to_json
      }
      response = post("/#{id}/transactions", options)
      raise HTTParty::ResponseError.new(response) unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.destroy(token, id, id_show)
      header = {
        headers: { "Authorization": "Token token=#{token}" }
      }
      response = delete("/#{id}/transactions/#{id_show}", header)
      raise HTTParty::ResponseError.new(response) unless response.success?
      # JSON.parse(response.body, symbolize_names: true)
    end

    def self.update(token, id, id_show, category_data)
      options = {
        headers: { 
          Authorization: "Token token=#{token}",
          "Content-Type": "application/json"
        },
        body: category_data.to_json
      }
      response = patch("/#{id}/transactions/#{id_show}", options)
      raise HTTParty::ResponseError.new(response) unless response.success?
      JSON.parse(response.body, symbolize_names: true)
    end

    

  end

end
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      #new route cart
      if @@cart.empty?
      # if cart is empty
        resp.write "Your cart is empty"
      else @@cart.each do |cart|
      # if cart is not empty
          resp.write "#{cart}\n"
         end
      end

    elsif req.path.match(/add/)
      #new route add
      input_item = req.params["item"]
      if @@items.include? input_item
        @@cart << input_item
        resp.write "added #{input_item}"
      else
        resp.write "We don't have that item"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end

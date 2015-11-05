module ApplicationModel

    def random
      order("RANDOM()").first
    end

end

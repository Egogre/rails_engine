module ApplicationModel

    def random
      order("random()").first
    end

end

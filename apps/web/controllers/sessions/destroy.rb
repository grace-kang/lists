module Web::Controllers::Sessions
  class Destroy
    include Web::Action

    def call(_params)
      logout
    end
  end
end

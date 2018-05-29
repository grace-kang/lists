module Web::Controllers::Sessions
  class Destroy
    include Web::Action

    def call(params)
      logout
    end
  end
end

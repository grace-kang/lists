module Web::Controllers::Sessions
  class Destroy
    include Web::Action

    def call(_)
      logout
    end
  end
end

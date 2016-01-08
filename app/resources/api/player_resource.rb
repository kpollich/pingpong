module Api
  class PlayerResource < JSONAPI::Resource
    attributes :name, :wins, :losses

    def self.records(options = {})
      Player.find_all
    end
  end
end

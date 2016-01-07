module Api
  class PlayerResource < JSONAPI::Resource
    attributes :name, :wins, :losses
  end
end

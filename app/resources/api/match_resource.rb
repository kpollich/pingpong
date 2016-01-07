class Api::MatchResource < JSONAPI::Resource
  attributes :player1_id, :player2_id
  has_many :games
end

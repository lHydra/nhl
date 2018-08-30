class Player < ApplicationRecord
  enum position: [:LW, :C, :RW, :LD, :RD, :G, :D]
end

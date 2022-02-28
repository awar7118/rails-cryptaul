class OrderProduct < ApplicationRecord
  belongs_to :basket
  belongs_to :crypto
end

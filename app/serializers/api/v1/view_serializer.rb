class Api::V1::ViewSerializer < ActiveModel::Serializer
  attributes :id, :post

  belongs_to :post
end

class ViewSerializer < ActiveModel::Serializer

  attribute :locked_view, if: :locked?

  attribute :unlocked_view, if: -> {object.locked == "ad" }

  attribute :unlocked_view, if: -> {object.locked == "unlocked" }

  def locked?
    object.locked == "locked" 
  end


  def data
    case object.locked
    when "locked"
      return object.locked_view
    when "ad"
      return object.unlocked_view
    when "unlocked"
      return object.unlocked_view
    else
      return object.locked_view
    end
  end
end

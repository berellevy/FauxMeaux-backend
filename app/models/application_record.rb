class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def json_render(*args)
    args.map do |arg|
      [arg, send(arg)]
    end.to_h
  end
  
end

require 'youtube'
require 'vimeo'

module Acts
  module Embeddable
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_embeddable(field)
      cattr_accessor :embeddable_text_field
      self.embeddable_text_field = field.to_s
        define_method "#{self.embeddable_text_field}" do
          value = embed_embeddables(self[field])
        end 
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
  def embed_embeddables(text)
    #video = text.match(/\[(youtube|vimeo)[width="\d*"\s?|height="\d*"\s?]*\](\w*)\[\/\1\]/)
    test = /\[(youtube|vimeo)[width="\d*"\s?|height="\d*"\s?]*\](\S*v=|\s?|[[a-z:\/{1,}\.]*)(\w*)\[\/\1\]/
    video = text.match(test)
    if video
    case video[1]
      when "youtube"    then Youtube.new(video[3], text).text
      when "vimeo"    then Vimeo.new(video[3], text).text
      else text
    end
    end
  end
  
  end
end
end

ActiveRecord::Base.send :include, Acts::Embeddable

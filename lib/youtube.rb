module Acts
  module Embeddable
    class Youtube
      
      def initialize(id, text)
        test = /\[(youtube)[width="\d*"\s?|height="\d*"\s?]*\](\S*v=|\s?)(.*)\[\/\1\]/
        @id = id
        @text = text
        @text.gsub!(test, embed_code.gsub(/\{video\}/, @id).gsub(/\{width\}/, width_and_height(text)[:width]).gsub(/\{height}/, width_and_height(text)[:height]))
      end
      
      def embed_code
        embed = '<object width="{width}" height="{height}">'
        embed += '<param name="movie" value="http://www.youtube.com/v/{video}"></param>'
        embed += '<param name="allowFullScreen" value="true"></param>'
        embed += '<param name="allowscriptaccess" value="always"></param>'
        embed += '<embed src="http://www.youtube.com/v/{video}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="{width}" height="{height}"></embed>'
        embed += '</object>'
      end
      
      def width_and_height(text)
        test = /\[(youtube|vimeo)\s((width)=\\?"(\d*)\\?"\s?|(height)=\\?"(\d*)\\?"\s?)*/
        dimensions = @text.match(test) || []
        dimensions_obj = {}
        dimensions_obj[:width] = dimensions[4] || 300.to_s
        dimensions_obj[:height] = dimensions[6] || 243.to_s
        dimensions_obj
      end
      
      def text
        @text
      end
      
    end
  end
end
module Acts
  module Embeddable
    class Vimeo
      
      def initialize(id, text)
        test = /\[(vimeo)[width="\d*"\s?|height="\d*"\s?]*\](\S*v=|\s?)(\w*)\[\/\1\]/
        @id = id
        @text = text
        @text.gsub!(test, embed_code.gsub(/\{video\}/, @id).gsub(/\{width\}/, width_and_height(text)[:width]).gsub(/\{height}/, width_and_height(text)[:height]))
      end
      
      def embed_code
        embed = '<object width="{width}" height="{height}">'
        embed += '<param name="allowfullscreen" value="true" />'
        embed += '<param name="allowscriptaccess" value="always" />'
        embed += '<param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id={video}&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" />'
        embed += '<embed src="http://vimeo.com/moogaloop.swf?clip_id={video}&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="{width}" height="{height}"></embed>'
        embed += '</object>'
        embed
      end
      
      def width_and_height(text)
        test = /\[(vimeo)\s((width)=\\?"(\d*)\\?"\s?|(height)=\\?"(\d*)\\?"\s?)*/
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
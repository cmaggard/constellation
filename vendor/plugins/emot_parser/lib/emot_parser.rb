# Emot-parser
module EmotParser
  def emot_parse(string)
    string.gsub( /:(\w+):/, image_tag('emots/emot-\1.gif') )
  end
end
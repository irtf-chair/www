# replace any mention of an IRTF RG with a link to its charter

class RGFilter < Nanoc3::Filter
  identifier :rg
  type :text

  def run(content, params={})
    a = Regexp.new($boundary + '(' + $rgs.keys.join('|').upcase +
                   ')' + $boundary);
    content.gsub!(a) {
      |rg| $1 + '<a href="' + $2.downcase + '">' + $2 + '</a>' + $3
    }
    
    c = Regexp.new($boundary + '(' + $oldrgs.keys.join('|').upcase +
                   ')' + $boundary);
    content.gsub!(c) {
      |rg| $1 + '<a href="concluded/' + $2.downcase + '">' + $2 + '</a>' + $3
    }    

    return content
  end
end
# strip .html from irtf.org URLs

class ExtensionStripperFilter < Nanoc3::Filter
  identifier :extensionstripper
  type :text

  def run(content, params={})
    content.gsub(/(irtf\.org.*)\.html/i, '\1')
  end
end
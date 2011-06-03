# replace any mention of an IETF meeting with a link to its web site

class MeetingFilter < Nanoc3::Filter
  identifier :meeting
  type :text

  def run(content, params={})
    content.gsub(/IETF-([0-9]{1,3})/i) {
      |rfc| link_to("IETF-#{$1}", "http://ietf.org/meeting/#{$1}/index")
    }
  end
end
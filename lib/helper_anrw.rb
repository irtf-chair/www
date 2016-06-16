require "json"
require "active_support/core_ext/string/inflections"
require "active_support/core_ext/array/conversions"

module ANRW
  def htmlify_paper(json, nr)
    papers = JSON.parse(File.read(json))
    p = papers.select{ |p| p["pid"] == nr }[0]
    if p["options"]["type"] =~ /full/
      label = "success"
    else
      label = "default"
    end
    # XXX use this for camera ready
    # <b><a href="#">#{p["title"]}.</a></b>
    html = %{
      <div class="col-xs-9">
        <p>
          <b>#{p["title"]}.</b>
          <span class="label label-#{label}">#{p["options"]["type"].titleize}</span>
          <br>
    }
    names = p["authors"].map { |a|
      n = a["first"] + " " + a["last"]
      if a.key?("affiliation")
        n += " <em class=\"text-muted\">(" + a["affiliation"] + ")</em>"
      end
      n
    }
    html += names.to_sentence + "."
    html += %{
        </p>
      </div>
      <div class="col-xs-3">
        <p class="btn-toolbar pull-right">
          <a href="#" class="btn btn-default btn-sm" disabled="disabled" role="button">Paper</a>
          <a href="#" class="btn btn-default btn-sm" disabled="disabled" role="button">Slides</a>
        </p>
      </div>
    }
    return html
  end
end

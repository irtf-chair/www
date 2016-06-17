require "json"
require "active_support/core_ext/string/inflections"
require "active_support/core_ext/array/conversions"

module ANRW
  def htmlify_paper(json, nr)
    papers = JSON.parse(File.read(json))
    p = papers.select{ |p| p["pid"] == nr }[0]
    label =  p["options"]["type"] =~ /full/ ? "success" : "default"
    names = p["authors"].map { |a|
      a["first"] + " " + a["last"] + (a.key?("affiliation") ?
        " <em class=\"text-muted\">(" + a["affiliation"] + ")</em>" : "")
    }

    # XXX use this for camera ready
    # <b><a href="#">#{p["title"]}.</a></b>
    html = %{
      <div class="modal" id="modal#{nr}" tabindex="-1" role="dialog" aria-labelledby="modallabel#{nr}">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" id="modallabel#{nr}"><b>#{p["title"]}</b></h4>
              #{names.to_sentence}
            </div>
            <div class="modal-body">
              #{p["abstract"]}
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>

      <div class="col-xs-9">
        <p>
          <b>#{p["title"] =~ /[[:punct:]]$/ ? p["title"] : p["title"] + "."}</b>
          <span class="label label-#{label}">#{p["options"]["type"].titleize}</span>
          <br>
          #{names.to_sentence + "."}
        </p>
      </div>
      <div class="col-xs-3">
        <p class="btn-toolbar pull-right">
          <button class="btn btn-default btn-sm" type="button" data-toggle="modal" data-target="#modal#{nr}">Abstract</button>
          <a href="#" class="btn btn-default btn-sm" disabled="disabled" role="button">Paper</a>
          <a href="#" class="btn btn-default btn-sm" disabled="disabled" role="button">Slides</a>
        </p>
      </div>
    }
    return html
  end
end

require "json"
require "active_support/core_ext/string/inflections"
require "active_support/core_ext/array/conversions"
require 'active_support/core_ext/hash'
# require 'pp'

module ANRW
  def htmlify_paper(file, nr)
    p = case File.extname(file)
    when ".json"
      JSON.parse(File.read(file)).select{ |x| x["pid"] == nr }[0]
    when ".xml"
      p = Hash.from_xml(File.read(file))["proceeding"]["content"]["section"].each{ |s|
        # pp nr, s["section_title"]
        a = s["article_rec"].find{ |x| x["seq_no"].to_i == nr }
        # pp nr, a["title"]
        return a
      }
      # pp nr, p
      {
        "options": { "type": (p["pages"].to_i > 4 ? "Full" : "Short") + " Paper" },
        "final": { "content_file": p["fulltext"]["file"]["fname"] },
        "authors": p["authors"]["au"].map { |a|
          {
            "first": a["first_name"],
            "last": a["last_name"],
            "affiliation": a["affiliation"]
          }
        },
        "title": p["title"],
        "abstract": p["abstract"].values.join(" ")
      }.deep_stringify_keys
    else
      raise "Don't know how to handle #{file}"
    end
    label = p["options"]["type"] =~ /full/i ? "success" : "default"
    names = p["authors"].map { |a|
      a["first"] + " " + a["last"] + (a.key?("affiliation") ?
        " <em class=\"text-muted\">(" + a["affiliation"] + ")</em>" : "")
    }

    paper = File.join(File.dirname(file), p["final"]["content_file"])
    slides = File.join(File.dirname(file), "slides-" + p["final"]["content_file"])

    html = %{
      <div class="modal" id="modal#{nr}" tabindex="-1" role="dialog"
           aria-labelledby="modallabel#{nr}">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                      aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
              <h4 class="modal-title" id="modallabel#{nr}">
                <b>#{p["title"]}</b>
              </h4>
              #{names.to_sentence}
            </div>
            <div class="modal-body">
              #{p["abstract"].gsub(/([[:alpha:]])-[[:space:]]+/, '\1')}
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default"
                      data-dismiss="modal">
                Close
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-8">
        <p>
          <b>
            #{p["title"] =~ /[[:punct:]]$/ ? p["title"] : p["title"] + "."}
          </b>
          <span class="label label-#{label}">#{p["options"]["type"].titleize}</span>
          <br>
          #{names.to_sentence + "."}
        </p>
      </div>
      <div class="col-lg-4">
        <p class="btn-toolbar">
          <button class="btn btn-default btn-xs" type="button"
                  data-toggle="modal" data-target="#modal#{nr}">
            <span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span>
            Abstract
          </button>
    }

    if File.exist?(paper)
      html += %{
            <a href="#{File.basename(paper)}"
               class="btn btn-default btn-xs" role="button">
              <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
              Paper
            </a>
      }
    end

    if File.exist?(slides)
      html += %{
          <a href="#{File.basename(slides)}"
             class="btn btn-default btn-xs" role="button">
            <span class="glyphicon glyphicon-picture" aria-hidden="true"></span>
            Slides
          </a>
      }
    end

    html += "</p></div>"
    return html
  end

  def htmlify_paper_new(file, nr)
    p = case File.extname(file)
    when ".json"
      JSON.parse(File.read(file)).select{ |x| x["pid"] == nr }[0]
    when ".xml"
      p = Hash.from_xml(File.read(file))["proceeding"]["content"]["section"].each{ |s|
        # pp nr, s["section_title"]
        a = s["article_rec"].find{ |x| x["seq_no"].to_i == nr }
        # pp nr, a["title"]
        return a
      }
      # pp nr, p
      {
        "options": { "type": (p["short-paper"] == true ? "Short" : "Full") + " Paper" },
        "final": { "content_file": p["fulltext"]["file"]["fname"] },
        "authors": p["authors"]["au"].map { |a|
          {
            "first": a["first_name"],
            "last": a["last_name"],
            "affiliation": a["affiliation"]
          }
        },
        "title": p["title"],
        "abstract": p["abstract"].values.join(" ")
      }.deep_stringify_keys
    else
      raise "Don't know how to handle #{file}"
    end
    label = p["options"]["short-paper"] == true ? "default" : "success"
    names = p["authors"].map { |a|
      a["first"] + " " + a["last"] + (a.key?("affiliation") ?
        " <em class=\"text-muted\">(" + a["affiliation"] + ")</em>" : "")
    }

    paper = File.join(File.dirname(file), p["final"]["content_file"])
    slides = File.join(File.dirname(file), "slides-" + p["final"]["content_file"])

    html = %{
      <div class="modal" id="modal#{nr}" tabindex="-1" role="dialog"
           aria-labelledby="modallabel#{nr}">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                      aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
              <h4 class="modal-title" id="modallabel#{nr}">
                <b>#{p["title"]}</b>
              </h4>
              #{names.to_sentence}
            </div>
            <div class="modal-body">
              #{p["abstract"].gsub(/([[:alpha:]])-[[:space:]]+/, '\1')}
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default"
                      data-dismiss="modal">
                Close
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-8">
        <p>
          <b>
            #{p["title"] =~ /[[:punct:]]$/ ? p["title"] : p["title"] + "."}
          </b>
          <span class="label label-#{label}">#{(p["options"]["short-paper"] == true ? "Short" : "Full") + " Paper"}</span>
          <br>
          #{names.to_sentence + "."}
        </p>
      </div>
      <div class="col-lg-4">
        <p class="btn-toolbar">
          <button class="btn btn-default btn-xs" type="button"
                  data-toggle="modal" data-target="#modal#{nr}">
            <span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span>
            Abstract
          </button>
    }

    if File.exist?(paper)
      html += %{
            <a href="#{File.basename(paper)}"
               class="btn btn-default btn-xs" role="button">
              <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
              Paper
            </a>
      }
    end

    if File.exist?(slides)
      html += %{
          <a href="#{File.basename(slides)}"
             class="btn btn-default btn-xs" role="button">
            <span class="glyphicon glyphicon-picture" aria-hidden="true"></span>
            Slides
          </a>
      }
    end

    html += "</p></div>"
    return html
  end

  def htmlify_paper_new2(file, nr)
    p = case File.extname(file)
    when ".json"
      JSON.parse(File.read(file)).select{ |x| x["pid"] == nr }[0]
    else
      raise "Don't know how to handle #{file}"
    end
    label = p["options"]["paper-talk"] == "Paper" ? "success" : "primary"
    names = p["authors"].map { |a|
      a["first"] + " " + a["last"] + (a.key?("affiliation") ?
        " <em class=\"text-muted\">(" + a["affiliation"] + ")</em>" : "")
    }

    # paper = File.join(File.dirname(file), p["final"]["content_file"])
    slides = File.join(File.dirname(file), p["slides"])

    html = %{
      <div class="modal" id="modal#{nr}" tabindex="-1" role="dialog"
           aria-labelledby="modallabel#{nr}">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                      aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
              <h4 class="modal-title" id="modallabel#{nr}">
                <b>#{p["title"]}</b>
              </h4>
              #{names.to_sentence}
            </div>
            <div class="modal-body">
              #{p["abstract"].gsub(/([[:alpha:]])-[[:space:]]+/, '\1')}
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default"
                      data-dismiss="modal">
                Close
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-8">
        <p>
          <b>
            #{p["title"] =~ /[[:punct:]]$/ ? p["title"] : p["title"] + "."}
          </b>
          <span class="label label-#{label}">#{(p["options"]["paper-talk"] == "Paper" ? "Short paper" : "Talk")}</span>
          <br>
          #{names.to_sentence + "."}
        </p>
      </div>
      <div class="col-lg-4">
        <p class="btn-toolbar">
          <button class="btn btn-default btn-xs" type="button"
                  data-toggle="modal" data-target="#modal#{nr}">
            <span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span>
            Abstract
          </button>
    }

    if File.exist?(slides)
      html += %{
          <a href="#{File.basename(slides)}"
             class="btn btn-default btn-xs" role="button">
            <span class="glyphicon glyphicon-picture" aria-hidden="true"></span>
            Slides
          </a>
      }
    end

    html += "</p></div>"
    return html
  end

  def htmlify_poster(file, nr)
    p = case File.extname(file)
    when ".json"
      JSON.parse(File.read(file)).select{ |x| x["pid"] == nr }[0]
    else
      raise "Don't know how to handle #{file}"
    end
    label = p["options"]["paper-talk"] == "Paper" ? "success" : "primary"
    names = p["authors"].map { |a|
      a["first"] + " " + a["last"] + (a.key?("affiliation") ?
        " <em class=\"text-muted\">(" + a["affiliation"] + ")</em>" : "")
    }

    # paper = File.join(File.dirname(file), p["final"]["content_file"])
    # slides = File.join(File.dirname(file), "slides-" + p["final"]["content_file"])

    html = %{
      <div class="modal" id="modal#{nr}" tabindex="-1" role="dialog"
           aria-labelledby="modallabel#{nr}">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                      aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
              <h4 class="modal-title" id="modallabel#{nr}">
                <b>#{p["title"]}</b>
              </h4>
              #{names.to_sentence}
            </div>
            <div class="modal-body">
              #{p["abstract"].gsub(/([[:alpha:]])-[[:space:]]+/, '\1')}
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default"
                      data-dismiss="modal">
                Close
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-8">
        <p>
          <b>
            #{p["title"] =~ /[[:punct:]]$/ ? p["title"] : p["title"] + "."}
          </b>
          <br>
          #{names.to_sentence + "."}
        </p>
      </div>
      <div class="col-lg-4">
        <p class="btn-toolbar">
          <button class="btn btn-default btn-xs" type="button"
                  data-toggle="modal" data-target="#modal#{nr}">
            <span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span>
            Abstract
          </button>
    }

    # if File.exist?(paper)
    #   html += %{
    #         <a href="#{File.basename(paper)}"
    #            class="btn btn-default btn-xs" role="button">
    #           <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
    #           Paper
    #         </a>
    #   }
    # end

    # if File.exist?(slides)
    #   html += %{
    #       <a href="#{File.basename(slides)}"
    #          class="btn btn-default btn-xs" role="button">
    #         <span class="glyphicon glyphicon-picture" aria-hidden="true"></span>
    #         Slides
    #       </a>
    #   }
    # end

    html += "</p></div>"
    return html
  end

end

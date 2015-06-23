module ApplicationHelper
  def format_date date
    if date 
      date.strftime "%m/%d/%Y %H:%M"
    else 
      "No date specified"
    end
  end

  def format_date_comments date
    if date 
      date.strftime "%m %B of %Y at %H:%M"
    else 
      I18n.t("helpres.app.no_date")
    end
  end

  def modal_button(target, text)
    '<button type="button" class="btn btn-link btn-xs"
            data-toggle="modal"
            data-target=".' + target + '">
            ' + text + '
    </button>'
  end

  def modal_large_body(target, title, data)
    '<div class="modal fade ' + target + '" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" id="gridSystemModalLabel">' + title + '</h4>
          </div>
          <div class="modal-body">
            <div class="container-fluid">' +
    raw(data) +
            '</div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">'
            +
            I18n.t("helpres.app.close")
            +
            '</button>
          </div>
        </div>
      </div>
    </div>'
  end

  def italics_decorator(text) 
    "<i> #{text} </i>"
  end

end

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
      "No date specified"
    end
  end

  def modal_button target
    '<button type="button" class="btn btn-link btn-xs"
            data-toggle="modal"
            data-target=".' + target + '">
            Read more...
    </button>'
  end

  def modal_large_body(target, data)
    '<div class="modal fade ' + target + '" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title" id="gridSystemModalLabel">Course description</h4>
          </div>
          <div class="modal-body">
            <div class="container-fluid">' +
    raw(data) +
            '</div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>'
  end

  def italics_decorator(text) 
    "<i> #{text} </i>"
  end

end

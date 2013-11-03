var TwitterBootstrapConfirmBox;

$.fn.twitter_bootstrap_confirmbox = {
  defaults: {
    fade: true,
    title: null,
    cancel: "Cancel",
    proceed: "OK",
    proceed_class: "btn proceed btn-primary"
  }
};

TwitterBootstrapConfirmBox = function(message, element, callback) {
  $(document.body).append($('<div class="modal hide" id="confirmation_dialog">\
        <div class="modal-header"><button type="button" class="close" data-dismiss="modal">×</button><h3>...</h3></div>\
        <div class="modal-body"></div>\
        <div class="modal-footer"><a href="#" class="btn cancel" data-dismiss="modal">...</a><a href="#" class="btn proceed btn-primary">...</a></div>\
      </div>'));
  if (element.data("confirm-fade") || $.fn.twitter_bootstrap_confirmbox.defaults.fade) {
    $("#confirmation_dialog").addClass("fade");
  }
  $("#confirmation_dialog .modal-body").html(message);
  $("#confirmation_dialog .modal-header h3").html(element.data("confirm-title") || $.fn.twitter_bootstrap_confirmbox.defaults.title || window.top.location.origin);
  $("#confirmation_dialog .modal-footer .cancel").html(element.data("confirm-cancel") || $.fn.twitter_bootstrap_confirmbox.defaults.cancel);
  $("#confirmation_dialog .modal-footer .proceed").html(element.data("confirm-proceed") || $.fn.twitter_bootstrap_confirmbox.defaults.proceed).attr("class", $.fn.twitter_bootstrap_confirmbox.defaults.proceed_class).addClass(element.data("confirm-proceed-class"));
  $("#confirmation_dialog").modal("show").on("hidden", function() {
    return $(this).remove();
  });
  $("#confirmation_dialog .proceed").click(function(event) {
    event.preventDefault();
    $("#confirmation_dialog").modal("hide");
    callback();
    return false;
  });
  return $("#confirmation_dialog .cancel").click(function(event) {
    event.preventDefault();
    $("#confirmation_dialog").modal("hide");
    return false;
  });
};

$.rails.allowAction = function(element) {
  var answer, message;
  message = element.data("confirm");
  answer = false;
  if (!message) {
    return true;
  }
  if ($.rails.fire(element, "confirm")) {
    TwitterBootstrapConfirmBox(message, element, function() {
      var allowAction, evt;
      if ($.rails.fire(element, "confirm:complete", [answer])) {
        allowAction = $.rails.allowAction;
        $.rails.allowAction = function() {
          return true;
        };
        if (element.get(0).click) {
          element.get(0).click();
        } else if ($.isFunction(document.createEvent)) {
          evt = document.createEvent("MouseEvents");
          evt.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, document.body.parentNode);
          element.get(0).dispatchEvent(evt);
        } else {
          element.trigger("click");
        }
        return $.rails.allowAction = allowAction;
      }
    });
  }
  return false;
};

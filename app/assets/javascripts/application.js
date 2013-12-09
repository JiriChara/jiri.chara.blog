// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery-2.0.3.min
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.cookie
//= require turbolinks
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require dataTables/jquery.dataTables.api.fnReloadAjax
//= require dataTables/extras/TableTools
//= require_tree .

var Spinner = (function() {
    return {
        show: function() {
            $('#spinner').css('top', $(window).scrollTop() + 10);
            $('#spinner').show();
        },
        hide: function() {
            $('#spinner').hide();
        }
    }
}());

$(function() {
    // Loader
    $(document).on("page:fetch", Spinner.show);
    $(document).on("page:receive", Spinner.hide);
    $(document).on('click', 'a[data-remote="true"]', Spinner.show);
    $(document).on('submit', 'form[data-remote="true"]', Spinner.show);
    $(document).ajaxComplete(Spinner.hide);

    $(document).on('click', '[data-submit-form]', function(e) {
      e.preventDefault();
      $(this).closest('form').submit();
    });

    function setTimezoneOffset() {
      var currentTime = new Date();
      $.cookie('time_zone', currentTime.getTimezoneOffset());
    }
    setTimezoneOffset();
}());

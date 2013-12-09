$(function() {
  $('#access_info').dataTable({
    sPaginationType: "full_numbers",
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('#access_info').data('source'),
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap"
  });
});

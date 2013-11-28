$(function () {
    $('#new_image').fileupload({
        dataType: "json",
        add: function(e, data) {
            if($('#article-images').is(':hidden')) {
                $('#article-images').show();
            }

            var file = data.files[0];

            data.context = $(tmpl("template-upload", file));

            $('#article-images').prepend(data.context);

            data.submit();
        },
        progress: function(e, data) {
            if(data.context) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                data.context.find('.bar').css('width', progress + '%')

            }
        },
        done: function(e, data) {
            data.context.remove();
            var result = $(tmpl("template-download", data.result[0]));
            $('#article-images table.download').show();
            $('#article-images table.download tbody').append(result);
        }
    });
});

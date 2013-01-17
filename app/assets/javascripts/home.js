$(function () {
    function capFirst(string) {
        var s = string.split(' '), r = '';
        $(s).each(function () {
            r += this.charAt(0).toUpperCase() + this.toLowerCase().slice(1) + ' ';
        });
        return r;
    }

    $('#people_count').bind('keyup', function () {
        var count = parseInt($(this).val().replace(/[^\d+]/, '')),
            base_price = 175,
            tax_rate = 0.135,
            total = 175;

        if (!count) count = 2;
        if (count != 1 && count != 2) base_price = base_price + ((count - 2) * 25);
        total = base_price + (base_price * tax_rate);
        $('#rate_result').text(accounting.formatMoney(total));
    });

    $('button[data-dismiss]').bind('click', function () {
        $(this).parent().fadeOut(200).removeClass('in');
    });

    $('#new_contact')
        .bind('ajax:success', function (evt, data, status, xhr) {
            if ($('div.field_with_errors').length) $('div.field_with_errors').children().unwrap('<div class="field_with_errors" />');
            $('#form_error_box').hide().removeClass('in');
            $('.form-text').html('');
            $(this).slideUp(200, function () {
                $('#form_success_box').fadeIn(200);
            });
        })
        .bind('ajax:error', function (evt, xhr, status, error) {
            var errors = $.parseJSON(xhr.responseText);
            $('#form_error_box').show().addClass('in');
            if ($('div.field_with_errors').length) $('div.field_with_errors').children().unwrap('<div class="field_with_errors" />');
            var errorText = "<ul>";
            var error_count = 0;
            for (error in errors) {
                $('input[name="contact[' + error + ']"]').wrap('<div class="field_with_errors" />');
                errorText += "<li>" + $.trim(capFirst(error.split('_').join(' '))) + ' ' + errors[error] + "</li> ";
                error_count++;
            }
            errorText += "</ul>";
            $('.error-message').html(errorText);
        });

    $('#contact_arrival_date, #contact_departure_date').datepicker()
});
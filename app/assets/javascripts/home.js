function capFirst(string) {
    var s = string.split(' '), r = '';
    $(s).each(function () {
        r += this.charAt(0).toUpperCase() + this.toLowerCase().slice(1) + ' ';
    });
    return r;
}
function tailorLinks() {
    var links = $('a');
    for (var i = 0; i < links.length; i++) {
        var $this = $(links[i]), title = $this.attr("title"), content = $this.html(), img_alt = $this.find('img').attr("alt");
        if (img_alt) $this.attr("title", img_alt);
        else if (!title) $this.attr("title", content);
    }
}
$(function () {
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
            $('#form_error_box').find('.error-message').html(errorText);
        });
    $('#front').css('background-image', "url('assets/frontx3.jpg')").show();
    $('.dp').datepicker();
    $('#page_nav li a, .send_inquiry').bind('click', function () {
        $.scrollTo($(this).attr('href'), 500);
    });
    $('#logo h1').bind('click', function () {
        $.scrollTo('#front', 500);
    });

    // check availability
    var $available = $('.available'), $unavailable = $('.unavailable'), $ebox = $('#error_box');

    $('#check_avail').bind('ajax:complete', function (evt, data, status, xhr) {
        $ebox.removeClass('in');
        if (status == 'success') {
            $ebox.hide().removeClass('in');
            if (data.responseText == 'true') {
                $unavailable.hide();
                $available.fadeIn(200);
            } else {
                $available.hide();
                $unavailable.fadeIn(200);
            }
        } else {
            $available.hide();
            $unavailable.hide();
            $ebox.show().addClass('in').find('.error-message').html(data.responseText);
        }
    });

    $('.send_inquiry').bind('click', function () {
        $('#contact_arrival_date').val($('#arrival_date_r').val());
        $('#contact_departure_date').val($('#departure_date_r').val());
        $('#contact_number_of_people').val($('#people_count').val())
    });

    $('#view_entire_calendar').bind('click', function () {
        var $cal = $('#hac');
        $(this).toggleClass('shown');
        if ($(this).hasClass('shown')) {
            if (!$cal.length) {
                $cal = $(document.createElement('iframe'));
                $cal.css({width: '100%', height: '990px'});
                $cal.attr({
                    id: 'hac',
                    src: 'https://www.homeawayconnect.com/calendar.aspx?propertyid=51970&culturename=en-US&mode=1'
                });
                $cal.insertAfter($('#check_avail').addClass('hidden').slideUp(200));
            } else {
                $cal.slideDown(200);
                $('#check_avail').slideUp(200);
            }
            $(this).text('hide the entire calendar');
        } else {
            $cal.slideUp(200);
            $('#check_avail').slideDown(200);
            $(this).text('view the entire calendar');
        }
    });

    tailorLinks();
});
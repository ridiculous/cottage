$(function () {
    $('#people_count').bind('keyup', function () {
        var count = parseInt($(this).val().replace(/[^\d+]/, '')),
            base_price = 175,
            tax_rate = 0.135,
            total = 175;

        if (!count) count = 2;
        switch (count) {
            case 1:
            case 2:
                break;
            default:
                base_price = base_price + ((count - 2) * 25);
        }
        total = base_price + (base_price * tax_rate);
        $('#rate_result').text(accounting.formatMoney(total));
    });
});
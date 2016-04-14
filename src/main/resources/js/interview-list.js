;(function () {

    var $tempCard = null;

    $("#hide-chip-btn").click(function () {
        $.get(global.rewriteUrl("/user/hide-chip"), null, global.ajaxCallback);
    });

    $(document).on("click", ".delete-btn", function () {
        var $interviewId = $(this).attr("data-interview-id");

        $("#submit-delete-btn").attr("data-temp-id", $interviewId);
        $tempCard = $(this).closest(".card");

        $("#delete-interview-modal").openModal();
    });

    $("#submit-delete-btn").click(function (event) {
        var data = {
            data: JSON.stringify({id: $(this).attr("data-temp-id")})
        };

        $.post(global.rewriteUrl("/interview/delete"), data, global.ajaxCallback)
            .done(function () {
                $tempCard.remove();

                /*Clean link*/
                $tempCard = null;

                $("#delete-interview-modal").closeModal();
                Materialize.toast("Анкета успешно удалена", 2000);
            });
    });

    $(document).on("click", ".lock-btn", function () {
        var that = $(this);
        $.get(global.rewriteUrl("/interview/lock/" + $(this).attr("data-interview-id")), global.ajaxCallback)
            .done(function () {
                var $icon = $(that).find("i");
                var lock = ($icon.html() == "lock");

                var msg;
                if (lock) {
                    $icon.html("lock_open");
                    msg = "Анкета открыта для прохождения";
                } else {
                    $icon.html("lock");
                    msg = "Анкета закрыта для прохождения";
                }

                $icon.attr("title", msg);
                Materialize.toast(msg, 2000);
            });
    });

}());
/**
 Core script to handle the entire layout and base functions
 **/
var MouseDown = function () {



    return {

        //main function to initiate template pages
        init: function () {
            $(".table.vxnets").bind("contextmenu", (function (e) {

                if (e.which == 3) {

                    var x = e.clientX + document.body.scrollLeft - document.body.clientLeft;
                    var y = e.clientY + document.body.scrollTop - document.body.clientTop;

                    $(".contextmenu").show();
                    $(".contextmenu").css("top", y);
                    $(".contextmenu").css("left", x);
                    return false;
                }

            }));

            $(".table.vxnets").bind("mousedown", (function (e) {
                if (e.which == 1) {
                    $(".contextmenu").hide();
                }
            }));
        }
    };



}();
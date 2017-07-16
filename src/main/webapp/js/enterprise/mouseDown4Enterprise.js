/**
 Core script to handle the entire layout and base functions
 **/
var MouseDown = function () {



    return {

        //main function to initiate template pages
        init: function () {
            $(".table.vxnets tr").live("contextmenu", (function (e) {
                $(this).parent().children().css("backgroundColor","");
                $("#selectedId").val("");
                if (e.which == 3) {
                    $(this).css("backgroundColor","gray");
                    var x = e.clientX + document.body.scrollLeft - document.body.clientLeft;
                    var y = e.clientY + document.body.scrollTop - document.body.clientTop;
                    var status = $(this).find(".icon-status").parent().text();
                    $("#mouse-active").css("display","");
                    $("#mouse-stop").css("display","");
                    $("#mouse-failed").css("display","");
                    $("#selectedId").val($(this).find(".dbIdValue").val());

                    if(status=="启用"){
                        $("#mouse-active").css("display","none");
                        $("#mouse-failed").css("display","none");
                    }else if(status=="停用"){
                        $("#mouse-stop").css("display","none");
                        $("#mouse-failed").css("display","none");
                    }else if(status=="待审核"){
                        $("#mouse-stop").css("display","none");
                    }else{
                        $(this).parent().children().css("backgroundColor","");
                        $(".contextmenu").hide();
                        return false;
                    }
                    $(".contextmenu").show();
                    $(".contextmenu").css("top", y);
                    $(".contextmenu").css("left", x);
                    return false;
                }
            }));

            $(".table.vxnets").live("mousedown", (function (e) {
               $(this).find("tr").css("backgroundColor","");
                if (e.which == 1) {
                    $(".contextmenu").hide();
                }
            }));
        }
    };



}();
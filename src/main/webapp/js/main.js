var Main = function () {

    var points = null;
    var st = null;
    var currentIndex = null;
    var inAnimation = null;
    var controller = null;
    var options = {
        auto: 1,
        interval:3000,
        defaultIndex:0
    };
    var stageItems = null;

    return {
        init: function () {
            controller = $(".timeline-controller");
            stageItems = $(".stage-item");
            points = $(".timeline-controller .dot");
            points.on("click", $.proxy(this.doOnDotClick, this));

            var length = stageItems.length;
            currentIndex = length - options.defaultIndex;

            Main.startAutoPlay();

        },
        doOnDotClick: function (b) {
            if (b.preventDefault(), this.stopAutoPlay(), inAnimation) return !1;
            var c = b.currentTarget,
                d = points.index(c);
            currentIndex !== d && this.changeStage(d);
        },
        doOnArrowClick: function (b) {
/*
            if (this.stopAutoPlay(), inAnimation) return !1;
*/
            var c = -1;
            if (b) {
                b.preventDefault();
                var d = b.currentTarget;
                c = 0 | d.attr("data-dir")
            }
            var e = currentIndex + c;
            0 > e && (e = stageItems.length - 1),
            e === stageItems.length && (e = 0),
                this.changeStage(e)
        },
        stopAutoPlay: function() {
            clearInterval(st);
            options.auto = 0;
        },
        startAutoPlay: function() {
            return inAnimation ? !1 : (options.auto = !0, void(st = setInterval(function() {
                    Main.doOnArrowClick()
                },
                options.interval)))
        },
        changeStage: function(a) {
            this.hideStage(currentIndex);
            this.showStage(a);
            currentIndex = a;
            controller.trigger("stage:changed");
        },
        hideStage: function(b) {
            var item = stageItems[b];
            var bg =  $(".timeline-wrapper").find(".timeline-bg");
            if(bg!=null) {
                bg.remove();
            }
            $(item).hide();
            $(".timeline-wrapper").addClass("loading");
        },
        showStage: function(b) {
            var item = stageItems[b];
            var ani = $(item).attr("data-animation");
            var bg = $(item).attr("data-bg");
            if(inAnimation!=0 && bg!=null) {
                var bgUrl = $('#context').val() + "/images/" + bg;
                $(".timeline-wrapper").removeClass("loading");
            }

            $("<div/>", {
                "class": "timeline-bg"
            }).insertBefore($(".timeline-arrows")).css({
                backgroundImage: "url(" + bgUrl + ")"
            }).animate({
                    opacity: 1
                },
                1e3,
                function () {
                });
            $(ani).show();

        }
    };
}();
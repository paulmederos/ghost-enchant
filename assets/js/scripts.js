(function() {
  $(function() {
    return $("a.scrollable-anchor").click(function() {
      var target;
      if (location.pathname.replace(/^\//, "") === this.pathname.replace(/^\//, "") && location.hostname === this.hostname) {
        target = $(this.hash);
        target = (target.length ? target : $("[name=" + this.hash.slice(1) + "]"));
        if (target.length) {
          $("html,body").animate({
            scrollTop: target.offset().top
          }, 800, "materialEase");
          return false;
        }
      }
    });
  });

  $.easing.jswing = $.easing.swing;

  $.extend($.easing, {
    def: "easeOutQuad",
    materialEase: function(x, t, b, c, d) {
      if ((t /= d / 2) < 1) {
        return c / 2 * t * t + b;
      }
      return -c / 2 * ((--t) * (t - 2) - 1) + b;
    }
  });

}).call(this);

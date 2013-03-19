// usage: $(document).lazyload2('img')

(function ($) {
  $.fn.lazyload2 = function(selector, options) {
    if (!selector) selector = 'img';
    var images = this.find(selector).get();
    var margin = 100;
    var lazyload = function() {
      var notLoaded = [];
      var bottom = $(window).scrollTop() + $(window).height();
      $.each(images, function() {
        var $this = $(this);
        if (!$this.data('src')) return;
        if ($this.offset().top < bottom + margin) {
          if (this.nodeName == 'IMG') {
            $this.attr('src', $this.data('src'));
          }
          else {
            $this.replaceWith($('<img />').attr($this.data()));
          }
        }
        else {
          notLoaded.push(this);
        }
      });
      images = notLoaded;
    }
    setInterval(lazyload, 500);
    lazyload();
    return this;
  }
})(jQuery);

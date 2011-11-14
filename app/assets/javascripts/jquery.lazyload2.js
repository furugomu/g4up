// usage: $(document).lazyload2('img')

(function ($) {
  $.fn.lazyload2 = function(selector, options) {
    if (!selector) selector = 'img';
    var images = this.find(selector).get();
    var margin = 100;
    $(window).on('scroll', function() {
      var notLoaded = [];
      $(images).each(function(i) {
        if (!$(this).data('src')) return;
        var bottom = $(window).scrollTop() + $(window).height();
        if ($(this).offset().top < bottom + margin) {
          if (this.nodeName == 'IMG') {
            $(this).attr('src', $(this).data('src'));
          }
          else {
            $(this).replaceWith($('<img />').attr($(this).data()));
          }
        }
        else {
          notLoaded.push(this);
        }
      });
      images = notLoaded;
    });
    $(window).trigger('scroll');
    return this;
  }
})(jQuery);

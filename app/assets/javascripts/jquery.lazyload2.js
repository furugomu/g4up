// usage: $(document).lazyload2('img')

(function ($) {
  $.fn.lazyload2 = function(selector, options) {
    if (!selector) selector = 'img';
    var images = this.find(selector).get();
    var margin = 10;
    $(window).on('scroll', function() {
      var notLoaded = [];
      $(images).each(function(i) {
        if (!$(this).data('src')) return;
        var bottom = $(window).scrollTop() + $(window).height();
        if ($(this).offset().top < bottom + margin) {
          console.log($(this).offset().top, $(this).data('src'));
          $(this).attr('src', $(this).data('src'));
        }
        else {
          notLoaded.push(this);
        }
      });
      images = notLoaded;
    });
    $(window).trigger('scroll');
  }
  function autopagerHandler(e) {
    console.log('autopagerHandler');
    $(e.target).lazyload2();
  }
  /*
  $('body')
    .on('AutoPagerize_DOMNodeInserted', autopagerHandler)
    .on('AutoPatchWork.DOMNodeInserted', autopagerHandler)
    .on('AutoPagerAfterInsert', autopagerHandler);
   */
})(jQuery);

// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require entries
//= require jquery.lazyload2
//= require ga
//= require_self
if (!window.console) console = {log: function(){}};
jQuery(function($) {
  $(document).lazyload2('.lazyload');
  function autopagerHandler(e) {
    $(e.target).lazyload2('.lazyload');
  }
  if (document.body && document.body.addEventListener) {
    $([
      'AutoPagerize_DOMNodeInserted',
      'AutoPagerAfterInsert',
      'AutoPatchWork.DOMNodeInserted'
    ]).each(function() {
      document.body.addEventListener(this, autopagerHandler, false);
    });
  }
});

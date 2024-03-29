(function($, document, window) {
  "use strict";

  return $(function() {

    $.fn.exists = function() {
      return $(this).length > 0;
    };

    return $(document).ready(function() {

      // Alerts
      // --------------------------------------------------

      $(".alert").alert();

      // Carousel
      // --------------------------------------------------

      $(".carousel").carousel({
        interval: 6000
      });

      // Teaching Tabs
      // --------------------------------------------------

      $('#teachingTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
      });

      $('#teachingTab a[href="#video"]').tab('show');

      // Media Element
      // --------------------------------------------------

      $('audio').mediaelementplayer({
        videoWidth: '100%',
        videoHeight: '100%',
        audioWidth: '100%',
        features: ['playpause', 'progress', 'tracks', 'volume'],
        videoVolume: 'horizontal'
      });

      // FitVids
      // --------------------------------------------------

      $("#video, #ustream").fitVids({ customSelector: "iframe[src^='http://www.ustream.tv']"});

      // Joey Special
      // --------------------------------------------------

      $('#joey-meador').prepend('<div class="center"><a href="#joey-meador" id="joey-click">&nbsp;</a></div>');
      $('#joey-meador .content').append('<audio id="joey-special" src="/workspace/assets/img/my-beloved.mp3"></audio>');

      $('#joey-click').click(function(){
        $('#joey-special').trigger("play");
      });

      // Home Group Hashing
      // --------------------------------------------------

      if (window.location.hash.length > 0) {
          $('.hg-box ul.nav-tabs > li > a[href="' + window.location.hash + '"]').tab('show');
      } else {
          $('.hg-box ul.nav-tabs > li > a:first').tab('show');
      }

    });

  });
})(jQuery, document, window);

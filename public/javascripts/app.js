// When page read, load chrome.css
// Addresses a google web fonts bug
$(document).ready(function () {
      $('head').append('<link href="/chrome.css" rel="stylesheet" />');
   });

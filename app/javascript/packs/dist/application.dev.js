"use strict";

require("bootstrap");

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start();

require("turbolinks").start();

require("@rails/activestorage").start();

require("channels"); // Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


require("trix");

require("@rails/actiontext"); // Disable image uploads in Action Text
// window.addEventListener("trix-file-accept", function(event) {
//   event.preventDefault()
//   alert("File attachment not supported!")
// })
// External links open in new tab


$(document).on('turbolinks:load', function () {
  $(".article-show-description").on('click', 'a', function (e) {
    console.log('Clicked');
    e.preventDefault();
    var url = $(this).attr('href');
    window.open(url, '_blank');
  });
}); // Clickable Category cards with styling on hover

$(document).on('turbolinks:load', function () {
  $(".card-container").on('click', function (e) {
    if (!$(e.target).is("i") && !$(e.target).is("a") && !$(e.target).is(".thumbnail")) window.location = $(this).data('link');
  }).on('mouseenter', function () {
    $(this).addClass("shadow-lg");
  }).on('mouseleave', function () {
    $(this).removeClass("shadow-lg");
  });
});
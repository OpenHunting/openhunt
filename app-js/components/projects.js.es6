$(document).ready(() => {
  $( "input[type=text]" ).on('focus', function(e) {
    $(e.target).prev().animate({'font-size':'1rem'});
  });
  $( "input[type=text]" ).on('blur', function(e) {
    $(e.target).val() === '' ? $(e.target).prev().animate({'font-size':'2rem'}) : null
  })
});

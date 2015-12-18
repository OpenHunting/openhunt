(() => {
  $(document).ready(() => {
    $("#new-product input[type=text]" ).on('focus', function(e) {
      $(e.target).prev().css({'color':'rgb(80, 143, 230)'});
    });

    $("#new-product input[type=text]" ).on('blur', function(e) {
      $(e.target).val() === '' ? $(e.target).prev().css({'color':'#000'}) : null
    })

    if ($('#new-product .form-group').hasClass('has-error')) {
      $( "input[type=text]" ).on('focus', function(e) {
        $(e.target).next('p.help-block').fadeOut();
      });
    }
  });
})();

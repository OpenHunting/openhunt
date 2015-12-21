(() => {
  var $ = jQuery;

  var hideFlash = (flashElement) => {
    $(flashElement).slideUp()
  };


  $(document).on("click touchstart", ".flash-hide-btn", (e) => {
    e.preventDefault();

    var flashElement = $(this).closest(".flash-message");
    hideFlash();
  });

  $(document).ready(() => {
    $(".flash-message").each((i, el) => {
      setTimeout(() => {
        hideFlash(el)
      }, 5000);
    });
  });

})();

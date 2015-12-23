(() => {
  var $ = jQuery;

  var hideFlash = (flashElement) => {
    $(flashElement).slideUp()
  };


  $(document).on("click touchstart", ".flash-hide-btn", (e) => {
    e.preventDefault();

    var flashElement = $(e.target).closest(".flash-message");
    hideFlash(flashElement);
  });

  $(document).ready(() => {
    $(".flash-message").each((i, el) => {
      setTimeout(() => {
        hideFlash(el)
      }, 5000);
    });
  });

})();

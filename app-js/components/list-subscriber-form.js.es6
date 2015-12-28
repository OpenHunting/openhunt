(() => {

  $(document).on("click", ".close-subscribe-form", (e) => {
    e.preventDefault();
    Cookies.set('hide_subscribe', true, { expires: 90 });
    $(e.target).closest(".list-subscriber-form").slideUp("fast")
  });

})();

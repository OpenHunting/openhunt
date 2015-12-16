(() => {
  $(document).ready(() => {
    var aboutScreen = $("#about-screen")

    var openAbout = () => {
      aboutScreen.slideDown("fast", () => {
        aboutScreen.scrollTop(0);
      });
    };
    var closeAbout = () => {
      aboutScreen.slideUp("fast");
    };

    $(document).on("click", ".close-about", (e) => {
      e.preventDefault();
      closeAbout();
    });

    $(document).on("click", ".open-about", (e) => {
      e.preventDefault();
      openAbout();
    });

    $(document).on("click", ".toggle-about", (e) => {
      e.preventDefault();

      if(aboutScreen.is(":visible")) {
        closeAbout();
      }
      else {
        openAbout();
      }
    });

  });
})();

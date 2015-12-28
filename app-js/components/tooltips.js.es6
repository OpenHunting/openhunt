(() => {
  $(document).on("initalizeTooltips", () => {
    $('[data-toggle="tooltip"]').tooltip({
      'animation': false,
      'delay': 0,
      'placement': 'left'
    });
  });

  $(document).ready(() => {
    $(document).trigger("initalizeTooltips");
  });

})();

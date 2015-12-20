(() => {

  $(document).on("click touchstart", ".more-projects-btn", (e) => {
    e.preventDefault();

    $(e.target).closest(".project-list").addClass("expanded");
  });

})();

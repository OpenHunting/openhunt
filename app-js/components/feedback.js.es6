(() => {
  $(document).ready(() => {

    var openFeedback = (slug) => {
      if(!slug){ return; }

      console.log("opening feedback: "+slug);
      window.location.hash = `open=${slug}`;

      $(".project-listing").removeClass("selected");
      $(`.project-listing[data-project-slug='${slug}']`).addClass("selected");

      var detailPanel = $("#detail-panel");
      detailPanel.fadeIn();

      // return if its already loaded
      if(detailPanel.data("current-project-slug") === slug) {
        return;
      }
      detailPanel.data("current-project-slug", slug);

      detailPanel.addClass("loading");
      console.log("LOADING FROM AJAX...");
      $.ajax({
        type: "GET",
        url: `/detail/${slug}`,
        data: {partial: true},
        success: (html) => {
          detailPanel.find(".project-feedback").replaceWith(html);
          initializeTooltips();
        },
        error: (xhr) => {
          console.error("Unable to load feedback:", slug, xhr);
          closeFeedback();
        },
        complete: (json) => {
          detailPanel.removeClass("loading");
        }
      });
    };

    var initializeTooltips = () => {
      $('[data-toggle="tooltip"]').tooltip({
        'animation':false,
        'delay':0,
        'placement':'left'
      });
    };

    var closeFeedback = () => {
      history.replaceState("", document.title, "/");

      $("#detail-panel").fadeOut();
      $(".project-listing").removeClass("selected");
    };

    var initialHash = (window.location.hash || "");
    if(initialHash.indexOf("open=") >= 0) {
      var val = _.last(initialHash.split("="));
      openFeedback(val);
    }

    $(document).on("click", ".project-listing", (e) => {
      var target = $(e.target);

      // skip links
      if(target.closest("a").length > 0) { return; }

      var projectListing = target.closest(".project-listing");

      openFeedback(projectListing.data("project-slug"));
    });

    // TODO: wire up saving feedback (on focus out)
    // TODO: wire up focus out feedback textarea if they press cmd+enter

    $(document).on("click touchstart", ".close-feedback", (e) => {
      e.preventDefault();
      var detailPanel = $("#detail-panel");
      var slug = detailPanel.data("current-project-slug");

      $.ajax({
        type: "POST",
        url: `/feedback/${slug}`,
        dataType: "json",
        data: {
          body: detailPanel.find("textarea[name=body]").val(),
          anonymous: detailPanel.find("input[name=anonymous]").is(":checked")
        },
        success: (json) => {

        },
        error: (xhr) => {
          var json = xhr.responseJSON;
          if(json){
            console.error(json);
          }
        },
        complete: (json) => {}
      });

      closeFeedback();
    });

    $(document).on("keyup", (e) => {
      if (e.which == 27) {
        closeFeedback();
      }
    });

    $(document).on("click touchstart", ".close-feedback-button", (e) => {
      closeFeedback();
    });

  });
})();

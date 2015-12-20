(() => {
  $(document).ready(() => {

    var openFeedback = (slug) => {
      if(!slug){ return; }

      console.log("opening feedback: "+slug);
      window.location.hash = `open=${slug}`;

      $(".project-listing").removeClass("selected");
      $(`.project-listing[data-project-slug='${slug}']`).addClass("selected");

      var feedbackPanel = $("#feedback-panel");
      feedbackPanel.fadeIn();

      // return if its already loaded
      if(feedbackPanel.data("current-project-slug") === slug) {
        return;
      }
      feedbackPanel.data("current-project-slug", slug);

      feedbackPanel.addClass("loading");
      console.log("LOADING FROM AJAX...");
      $.ajax({
        type: "GET",
        url: `/feedback/${slug}`,
        data: {partial: true},
        success: (html) => {
          feedbackPanel.find(".project-feedback").replaceWith(html);
        },
        error: (xhr) => {
          console.error("Unable to load feedback:", slug, xhr)
          closeFeedback();
        },
        complete: (json) => {
          feedbackPanel.removeClass("loading");
        }
      });
    };

    var closeFeedback = () => {
      history.replaceState("", document.title, "/");

      $("#feedback-panel").fadeOut();
      $(".project-listing").removeClass("selected");
    };

    var initialHash = (window.location.hash || "");
    if(initialHash.indexOf("open=") >= 0) {
      var val = _.last(initialHash.split("="));
      openFeedback(val);
    }

    $(document).on("click touchstart", ".project-listing", (e) => {
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
      var feedbackPanel = $("#feedback-panel");
      var slug = feedbackPanel.data("current-project-slug");

      $.ajax({
        type: "POST",
        url: `/feedback/${slug}`,
        dataType: "json",
        data: {
          body: feedbackPanel.find("textarea[name=body]").val(),
          anonymous: feedbackPanel.find("input[name=anonymous]").is(":checked")
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

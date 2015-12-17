(() => {
  $(document).ready(() => {

    var openFeedback = (id) => {
      if(!id){ return; }

      console.log("opening feedback: "+id)
      window.location.hash = `open=${id}`;
    };

    var closeFeedback = () => {
      window.location.hash = "";
    };


    // for debugging purposes
    window.openFeedback = openFeedback;
    window.closeFeedback = closeFeedback;

    var initialHash = (window.location.hash || "");
    if(initialHash.indexOf("open=") >= 0) {
      var val = _.last(initialHash.split("="));
      openFeedback(val);
    }
  });
})();

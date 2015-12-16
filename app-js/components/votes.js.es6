(() => {
  $(document).ready(() => {

    $(document).on("click", ".item-vote.ajax", (e) => {
      e.preventDefault();

      var voteElement = $(e.target).closest(".item-vote");
      var type = voteElement.is(".on") ? "DELETE" : "POST"
      voteElement.toggleClass("on")

      $.ajax({
        type: type,
        url: voteElement.attr("href"),
        dataType: "json",
        success: (json) => {
          console.log("Success:", json)
          voteElement.find(".counter").text(json.project.votes_count)
        },
        error: (xhr) => {
          var json = xhr.responseJSON;
          if(json){
            console.error(json);
          }
        },
        complete: (json) => {

        }
      });

    });

  });
})();

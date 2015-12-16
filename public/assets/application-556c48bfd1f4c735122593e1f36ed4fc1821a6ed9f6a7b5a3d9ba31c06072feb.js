'use strict';

$(document).ready(function () {
  $('[data-toggle="tooltip"]').tooltip({
    'animation': false,
    'delay': 0,
    'placement': 'left'
  });
});
"use strict";

(function () {
  $(document).ready(function () {

    $(document).on("click", ".item-vote.ajax", function (e) {
      e.preventDefault();

      var voteElement = $(e.target).closest(".item-vote");
      var type = voteElement.is(".on") ? "DELETE" : "POST";
      voteElement.toggleClass("on");

      $.ajax({
        type: type,
        url: voteElement.attr("href"),
        dataType: "json",
        success: function success(json) {
          console.log("Success:", json);
          voteElement.find(".counter").text(json.project.votes_count);
        },
        error: function error(xhr) {
          var json = xhr.responseJSON;
          if (json) {
            console.error(json);
          }
        },
        complete: function complete(json) {}
      });
    });
  });
})();
"use strict";

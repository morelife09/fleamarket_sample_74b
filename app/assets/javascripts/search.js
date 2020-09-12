$(function () {
  $("#price_range").on("change", function () {
    var priceRange = $("#price_range").val();
    if (priceRange != "") {
      $.ajax({
        url: "/items/search",
        type: "GET",
        data: { id: priceRange },
        dataType: "json",
      })
        .done(function (data) {
          var min = `${data.min}`;
          var max = `${data.max}`;
          $("#q_price_gteq").val(min);
          $("#q_price_lteq").val(max);
        })
        .fail(function () {
          alert("error");
        });
    } else {
      $("#q_price_gteq").val("");
      $("#q_price_lteq").val("");
    }
  });
});

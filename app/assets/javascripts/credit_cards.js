$(document).on("turbolinks:load", function () {
  if (!$("#regist_card")[0]) return false;

  Payjp.setPublicKey("pk_test_7359c79f1304d35944f10fbb");

  $("#regist_card").on("click", function (e) {
    e.preventDefault();
    var card = {
      number: $("#number").val(),
      exp_month: $("#exp_month").val(),
      exp_year: $("#exp_year").val(),
      cvc: $("#cvc").val(),
    };

    Payjp.createToken(card, function (status, response) {
      if (status === 200) {
        $("#number").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        $("#cvc").removeAttr("name");
        var token = response.id;
        $("#card_form").append(
          `<input type="hidden" name="card_token" value=${token}>`
        );
        $("#card_form").get(0).submit();
      } else {
        alert("カード情報が正しくありません。");
        $("#regist_card").prop("disabled", false);
      }
    });
  });
});

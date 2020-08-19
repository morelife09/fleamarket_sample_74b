$(document).on("turbolinks:load", function () {
  function appendOption(category) {
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML) {
    var childSelectHtml = "";
    childSelectHtml = `<div class="category__form" id= "children_wrapper">
                        <div class="category__form__box">
                          <select id= "children_category" class= "products__condition" name= "item[category_id]">
                            <option value="">選択して下さい</option>
                              ${insertHTML}
                           </select>
                        </div>
                      </div>`;

    $(".category").append(childSelectHtml);
  }
  function appendGrandChildrenBox(insertHTML) {
    var grandchildSelectHtml = "";
    grandchildSelectHtml = `<div class="category__form" id= "grandchildren_wrapper">
                              <div class="category__form__box">
                                <select id= "grandchildren_category" class= "products__condition" name= "item[category_id]">
                                  <option value="">選択して下さい</option>
                                    ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $(".category").append(grandchildSelectHtml);
  }
  $("#parents_category").on("change", function () {
    var parentValue = $("#parents_category option:selected").val();
    if (parentValue != "") {
      $.ajax({
        url: "/items/get_category",
        type: "GET",
        data: { parent_id: parentValue },
        dataType: "json",
      })
        .done(function (children) {
          $("#children_wrapper").remove();
          $("#grandchildren_wrapper").remove();
          var insertHTML = "";
          children.forEach(function (child) {
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function () {
          alert("error");
        });
    } else {
      $("#children_wrapper").remove();
      $("#grandchildren_wrapper").remove();
    }
  });
  $(document).on("change", "#children_category", function () {
    var childValue = $("#children_category option:selected").val();
    if (childValue != "") {
      $.ajax({
        url: "/items/get_category",
        type: "GET",
        data: { child_id: childValue },
        dataType: "json",
      })
        .done(function (grandchildren) {
          if (grandchildren.length !== 0) {
            $("#grandchildren_wrapper").remove();
            var insertHTML = "";
            grandchildren.forEach(function (grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandChildrenBox(insertHTML);
          } else {
            $("#grandchildren_wrapper").remove();
          }
        })
        .fail(function () {
          alert("error");
        });
    } else {
      $("#grandchildren_wrapper").remove();
    }
  });
});

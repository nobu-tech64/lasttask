$(function(){
  $(document).on('turbolinks:load', function() {
    function appendOption(category){
      var html = `<option value="${category.id}">${category.name}</option>`;
      return html;
    }

    // 子カテゴリーの表示作成
    function appendChildrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<div class='selectwrapper' id= 'children_wrapper'>
                          <div class="selectwrapper__box">
                            <select class="selectwrapper__box--select" id="child_category" name="category_id">
                              <option value>選択してください</option>
                                ${insertHTML}
                            </select>
                          </div>
                        </div>`
      $('.Eform__productdetailsboxes').append(childSelectHtml);
    }

    // 孫カテゴリーの表示作成
    function appendGrandchildrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class='selectwrapper' id= 'grandchildren_wrapper'>
                                <div class="selectwrapper__box">
                                  <select class="selectwrapper__box--select" id="grandchild_category" name="product[category_id]">
                                    <option value>選択してください</option>
                                      ${insertHTML}
                                  </select>
                                </div>
                              </div>`
      $('.Eform__productdetailsboxes').append(grandchildSelectHtml);
    }
    // 親カテゴリー選択後のイベント
    $('#parent_category').on('change', function(){
      var parentCategory = document.getElementById('product_category').value;
      if (parentCategory != "選択してください") {//親カテゴリーが初期値でないことを確認
        $.ajax({
          url: 'get_category_children',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove();
          $('#grandchildren_wrapper').remove();
          $('#size-wrapper').remove();
          $('#brand-wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      } else {
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        $('#size-wrapper').remove();
        $('#brand-wrapper').remove();
      }
    });
    // 子カテゴリー選択後のイベント
    $('.Eform__productdetailsboxes').on('change', '#child_category', function(){
      var childId = document.getElementById('child_category').value
      if (childId != "選択してください"){
        $.ajax({
          url: 'get_category_grandchildren',
          type: 'GET',
          data: { child_id: childId },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0){
            $('#grandchildren_wrapper').remove();
            $('#size-wrapper').remove();
            $('#brand-wrapper').remove();
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchildrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      } else {
        $('#grandchildren_wrapper').remove();
        $('#size-wrapper').remove();
        $('#brand-wrapper').remove();
      }
    });
  });
});
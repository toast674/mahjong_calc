// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(function(){

    //初期表示は収支戦
    $('#junisen').hide();
    $('#shuushisen').show();

    //ゲームタイプ変更時
    $('#game_type').change(function(){
        //順位戦の場合
        if ($('#game_type').val() === '順位戦'){
            $('#uma').hide();
            $('.genten').hide();
            $('.kaesiten').hide();
            $('#shuushisen').hide();
            $('#junisen').show();

            $("#shuushisen_score1").prop("disabled", true);
            $("#shuushisen_score2").prop("disabled", true);
            $("#shuushisen_score3").prop("disabled", true);
            $("#shuushisen_score4").prop("disabled", true);
            $("#shuushisen_count1").prop("disabled", true);
            $("#shuushisen_count2").prop("disabled", true);
            $("#shuushisen_count3").prop("disabled", true);
            $("#shuushisen_count4").prop("disabled", true);

            //順位戦のバリデーションを設定
        } else {
            $('#uma').show();
            $('.genten').show();
            $('.kaesiten').show();
            $('#junisen').hide();
            $('#shuushisen').show();

            $("#shuushisen_score1").prop("disabled", false);
            $("#shuushisen_score2").prop("disabled", false);
            $("#shuushisen_score3").prop("disabled", false);
            $("#shuushisen_score4").prop("disabled", false);
            $("#shuushisen_count1").prop("disabled", false);
            $("#shuushisen_count2").prop("disabled", false);
            $("#shuushisen_count3").prop("disabled", false);
            $("#shuushisen_count4").prop("disabled", false);

            //収支戦のバリデーションを設定
            required_and_number_check_shuushisen();
        }
    });

});

//収支戦の数値と必須バリデーション
function required_and_number_check_shuushisen(){
    var flug = 0;

    if($("#shuushisen_score1").val().match(/^\d+$/)){
        flug = 1;
    }

    if(flug){
        alert('数字以外が入力されています');
    }
    
}

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

    //ゲームタイプ変更時
    $('#game_type').change(function(){
        //順位戦の場合
        if ($('#game_type').val() === '順位戦'){
            $('#tenhou_rank').hide();
            $('#uma').hide();
            $('#genten').hide();
            $('#kaesiten').hide();
        } else if($('#game_type').val() === '天鳳'){
            $('#tenhou_rank').show();
            $('#uma').hide();
            $('#genten').hide();
            $('#kaesiten').hide();
        } else if($('#game_type').val() === '収支戦'){
            $('#tenhou_rank').hide();
            $('#uma').show();
            $('#genten').show();
            $('#kaesiten').show();
        }
    });

});

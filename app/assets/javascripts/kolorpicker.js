$(document).ready(function() {
  var preInput = ''; // for communicating between event handlers
  var paletteHTML = generateHTML(); //cached array of fully printed html for the palettes
  var selection = 1; //default palette selected

  function fetchPalette() {
    var palettes = new Array();

    palettes[0] = [
              ["E3E3E7","E5E5E6","ECDFEC","E6DFEC","DFDFE6","DFE6E6","DFE6DF","E8E8E0","F9F2DF","F4E9DF","ECDFDF","E5E4E2"],
              ["C7C7CF","CACBCD","D9BFD9","CCBFD9","BFBFCC","BFCCCC","BFCCBF","D1D1C0","F2E6BF","E9D4BF","D9BFBF","CCC8C5"],
              ["ABABB7","B0B1B4","C69FC6","B39FC6","9F9FB3","9FB3B3","9FB39F","BABAA1","ECD99F","DDBE9F","C69F9F","B2ADA7"],
              ["8F8F9F","96979B","B380B3","9980B3","808099","809999","809980","A4A481","E6CC80","D2A980","B38080","99928A"],
              ["727287","7B7D81","9F609F","80609F","606080","608080","608060","8D8D62","DFBF60","C79360","9F6060","7F766D"],
              ["56566F","616368","8C408C","66408C","404066","406666","406640","767642","D9B340","BC7D40","8C4040","655B50"],
              ["3A3A57","46494F","792079","4D2079","20204D","204D4D","204D20","5F5F23","D2A620","B06820","792020","4C3F32"],
              ["1E1E3F","2C2F36","660066","330066","000033","003333","003300","484803","CC9900","A55200","660000","322415"]
            ];

    palettes[1] = [
              ["F2DFEC","ECE6F2","DFDFF2","E6ECF9","DFECEC","E6ECE6","F2F2DF","FFF9DF","FCEDDF","F2DFDF","ECE6DF","FFFFFF"],
              ["E6BFD9","D9CCE6","BFBFE6","CCD9F2","BFD9D9","CCD9CC","E6E6BF","FFF2BF","F8DABF","E6BFBF","D9CCBF","D8D8D8"],
              ["D99FC6","C6B3D9","9F9FD9","B3C6EC","9FC6C6","B3C6B3","D9D99F","FFEC9F","F5C89F","D99F9F","C6B39F","B6B6B6"],
              ["CC80B3","B399CC","8080CC","99B3E6","80B3B3","99B399","CCCC80","FFE680","F2B580","CC8080","B39980","929292"],
              ["BF609F","9F80BF","6060BF","809FDF","609F9F","809F80","BFBF60","FFDF60","EEA360","BF6060","9F8060","6D6D6D"],
              ["B3408C","8C66B3","4040B3","668CD9","408C8C","668C66","B3B340","FFD940","EB9040","B34040","8C6640","494949"],
              ["A62079","794DA6","2020A6","4D79D2","207979","4D794D","A6A620","FFD220","E77E20","A62020","794D20","242424"],
              ["990066","663399","000099","3366CC","006666","336633","999900","FFCC00","E46B00","990000","663300","000000"]
            ];
                
    palettes[2] = [
              ["FBDBEE","FFDFFF","F2DFFF","ECDFFF","DFDFF9","E6ECFF","DFF2F2","DFF2DF","F2F9DF","FFFFDF","FFECDF","FFDFDF"],
              ["FFBFE6","FFBFFF","E6BFFF","D9BFFF","BFBFF2","CCD9FF","BFE6E6","BFE6BF","E6F2BF","FFFFBF","FFD9BF","FFBFBF"],
              ["FF9FD9","FF9FFF","D99FFF","C69FFF","9F9FEC","B3C6FF","9FD9D9","9FD99F","D9EC9F","FFFF9F","FFC69F","FF9F9F"],
              ["FF80CC","FF80FF","CC80FF","B380FF","8080E6","99B3FF","80CCCC","80CC80","CCE680","FFFF80","FFB380","FF8080"],
              ["FF60BF","FF60FF","BF60FF","9F60FF","6060DF","809FFF","60BFBF","60BF60","BFDF60","FFFF60","FF9F60","FF6060"],
              ["FF40B3","FF40FF","B340FF","8C40FF","4040D9","668CFF","40B3B3","40B340","B3D940","FFFF40","FF8C40","FF4040"],
              ["FF20A6","FF20FF","A620FF","7920FF","2020D2","4D79FF","20A6A6","20A620","A6D220","FFFF20","FF7920","FF2020"],
              ["FF0099","FF00FF","9900FF","6600FF","0000CC","3366FF","009999","009900","99CC00","FFFF00","FF6600","FF0000"]
             ];

    return palettes;
  }

  function generateHTML() {
    var palettes = fetchPalette();
    var html = new Array();

    for (var palette in palettes) {
      html[palette] = '<div class="kolorpicker-palette">\
             <ul class="palette-select">\
              <li id="0">dark</li>\
              <li id="1">neutral</li>\
              <li id="2">bright</li>\
             </ul>\
            </div>\
            <div class="x-close-box">X</div>\
            <table id="palette-table" cellpadding="0" cellspacing="2" style="border-collapse: separate; border-spacing: 2px; padding: 0px;margin:0; width: 290px;">';

      for (var row in palettes[palette]) {
        html[palette] += '<tr>';
        for (var col in palettes[palette][row]) {
          html[palette] += "<td class='tile' style='font-size:12px;padding:0;margin:0;border:1px solid #333333;cursor:pointer;background:#"+palettes[palette][row][col]+"' id='"+palettes[palette][row][col]+"'>&nbsp</td>";
        }
        html[palette] += '</tr>';
      }

      html[palette] += '</tbody></table>';
    }

   return html;
  }
	
  function displayPicker(input) {
    var parent = $(input).parent();

    if ($(parent).find('div').filter('#kolorPicker').size() == 0) {

      $(input).css('z-index','100');

      $(input).wrap('<div class="kolorPicker-wrapper" style="z-index: 10;" />');

      $('.kolorPicker-wrapper').append('<div id="kolorPicker"></div>');

      $('#kolorPicker').html(paletteHTML[selection]);

      $('li#' + selection).addClass('kolorpicker-palette-select');

      //reset the default auto value that IE sets (0) to 10 so that the picker works in IE
      $(parent).css('z-index','10');

      $('.kolorPicker-wrapper .kolorPicker').focus();

      $('<div/>').attr('class','kolorPickerUI').appendTo('body');
    }
  }

  function cleanPicker() {
    $('.kolorPicker').removeAttr('style'); 
            
    $('#kolorPicker').unwrap();

    $('.kolorPicker-wrapper').remove();
    $('#kolorPicker').remove();
    $('.kolorPickerUI').remove();

    $('.kolorPicker').parent().removeAttr('style');

    $('body').unbind('click.kp');
  }

  $(document).on("click", '.kolorPicker', function () { 
    $('body').bind('click.kp', function (ev) {
      if (!($(ev.target).parents().is(".kolorPicker-wrapper") || $(ev.target).is(".kolorPicker-wrapper"))) {
        cleanPicker();
      }
    });

    displayPicker(this);
  });

  $(document).on("keyup", '.kolorPicker', function () {
    if ($(this).val().charAt(0) != '#') {
      $(this).val('#' + $(this).val());
    }

    var check = /^#[0-9A-Fa-f]*$/;

    if (!check.test($(this).val())) {
      $(this).val(preInput); // if this value is invalid, restore it to what was valid
    }

    // call the change event on $(this) if you may have an assumed valid hex code
    if ( ($(this).val().length != preInput.length) && ($(this).val().length ==  7) ) {
      $(this).change();
    }
  });

  $(document).on("keypress", '.kolorPicker', function (e) {
    preInput = $(this).val(); //catch this value for comparison in keyup

    return true;
  });

  $(document).on("click", '.tile', function(){	
    //get a handle to the div that wraps the input field
    var wrap_div = $(this).parent().parent().parent().parent().parent();

    //get handle to input field to propogate update event
    var input = $(wrap_div).find('input').filter('.kolorPicker');

    //grab from the tile's id
    var color = '#' + $(this).attr('id');

    //unhook ourselves from the page
    cleanPicker();

    $(input).val(color);

    $(input).change();
  });

  $(document).on("click", 'ul.palette-select li', function(){
    selection = $(this).attr('id'); //note which palette we selected

    $('#kolorPicker').html(paletteHTML[selection]);
    $('li#' + selection).addClass('kolorpicker-palette-select');
  });

  $(document).on("click", '.x-close-box', function(){
    cleanPicker();
  });
});

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function ddH() {
  $( $.fn.cycle.defaults.autoSelector ).cycle();
}

function setCookie (name, value)
{
  document.cookie = name + "=" + escape(value);
}
function getCookie(name)
{
  var cookie = " " + document.cookie;
  var search = " " + name + "=";
  var setStr = null;
  var offset = 0;
  var end = 0;
  if (cookie.length > 0)
  {
    offset = cookie.indexOf(search);
    if (offset != -1)
    {
      offset += search.length;
      end = cookie.indexOf(";", offset)
      if (end == -1)
      {
        end = cookie.length;
      }
      setStr = unescape(cookie.substring(offset, end));
    }
  }
  return(setStr);
}

function getXmlHttp(){
  var xmlhttp;
  try {
    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
  } catch (e) {
    try {
      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (E) {
      xmlhttp = false;
    }
  }
  if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
    xmlhttp = new XMLHttpRequest();
  }
  return xmlhttp;
}

function send_filter(id, type) {
  switch (type) {
    case ('country'):
    vote('/filter/'+id+'/country')
    break;
    case ('region'):
    vote('/filter/'+id+'/region')
    break;
    case ('color'):
    vote('/filter/'+id+'/color')
    break;
    case ('manufacturer'):
    vote('/filter/'+id+'/manufacturer')
    break;
    case ('price'):
    vote('/filter/'+id+'/price')
    break;
    default:
    alert('>41');
  }

}

function remove_filter(id, type) {
  switch (type) {
    case ('country'):
    vote('/filter_destroy/'+id+'/country')
    break;
    case ('region'):
    vote('/filter_destroy/'+id+'/region')
    break;
    case ('color'):
    vote('/filter_destroy/'+id+'/color')
    break;
    case ('manufacturer'):
    vote('/filter_destroy/'+id+'/manufacturer')
    break;
    case ('price'):
    vote('/filter_destroy/'+id+'/price')
    break;
    default:
    alert('>41');
  }
}

function kp_select(type1, type2, showF) {
  $("."+type1).attr("hidden", "");
  $("."+type2).removeAttr("hidden");
  if (showF) {
    $('.xlsx').show()
  } else {
    $('.xlsx').hide()
  }
}

//Отправка json со странами
var updateSortingCountry = function(e)
{
  var list   = e.length ? e : $(e.target),
  output = list.data('output');
  if (window.JSON) {
    var arr_country = window.JSON.stringify(list.nestable('serialize'))
    var request = $.ajax({
      url: "/send_country_sortable",
      type: "POST",
      data: { arr_country : arr_country },
      dataType: "script"
    });
  } else {
    alert('JSON browser support required for this.');
  }
};

//Отправка json с регионами
var updateSortingRegion = function(e)
{
  var list   = e.length ? e : $(e.target),
  output = list.data('output');
  if (window.JSON) {
    var arr_region = window.JSON.stringify(list.nestable('serialize'))
    var request = $.ajax({
      url: "/send_region_sortable",
      type: "POST",
      data: { arr_region : arr_region },
      dataType: "script"
    });
  } else {
    alert('JSON browser support required for this.');
  }
};

//Отправка json с цветом
var updateSortingColor = function(e)
{
  var list   = e.length ? e : $(e.target),
  output = list.data('output');
  if (window.JSON) {
    var arr_color = window.JSON.stringify(list.nestable('serialize'))
    var request = $.ajax({
      url: "/send_color_sortable",
      type: "POST",
      data: { arr_color : arr_color },
      dataType: "script"
    });
  } else {
    alert('JSON browser support required for this.');
  }
};

//Отправка json с новостями
var updateSortingStory = function(e)
{
  var list   = e.length ? e : $(e.target),
  output = list.data('output');
  if (window.JSON) {
    var arr_region = window.JSON.stringify(list.nestable('serialize'))
    var request = $.ajax({
      url: "/send_story_sortable",
      type: "POST",
      data: { arr_region : arr_region },
      dataType: "script"
    });
  } else {
    alert('JSON browser support required for this.');
  }
};

//Отправка json с производителями
var updateSortingManufacturer = function(e)
{
  var list   = e.length ? e : $(e.target),
  output = list.data('output');
  if (window.JSON) {
    var arr_manufacturer = window.JSON.stringify(list.nestable('serialize'))
    var request = $.ajax({
      url: "/send_manufacturer_sortable",
      type: "POST",
      data: { arr_manufacturer : arr_manufacturer },
      dataType: "script"
    });
  } else {
    alert('JSON browser support required for this.');
  }
};

//Отправка json с каталогом
var updateSortingCatalog = function(e)
{
  var list   = e.length ? e : $(e.target),
  output = list.data('output');
  if (window.JSON) {
    var arr_catalog = window.JSON.stringify(list.nestable('serialize'))
    var request = $.ajax({
      url: "/send_catalog_sortable",
      type: "POST",
      data: { arr_catalog : arr_catalog },
      dataType: "script"
    });
  } else {
    alert('JSON browser support required for this.');
  }
};

//Отправка json с Search Category
var updateSortingSearchCategory = function(e)
{
  var list   = e.length ? e : $(e.target),
  output = list.data('output');
  if (window.JSON) {
    var arr_search_category = window.JSON.stringify(list.nestable('serialize'))
    var request = $.ajax({
      url: "/send_search_category_sortable",
      type: "POST",
      data: { arr_search_category : arr_search_category },
      dataType: "script"
    });
  } else {
    alert('JSON browser support required for this.');
  }
};

//Работа с винами
function initCatalog() {
  $(document).ready(function () {
    $('.wine .wine__check__area').on('click', function() {

      $(this).parents('.wine').toggleClass('is-selected');

      if ($('.wine').hasClass('is-selected')) {
        $('.choosed_list_container').fadeIn(400);
        $('.choosed_list_container').addClass('show');
      }
      else {
        $('.choosed_list_container').fadeOut('400');
        $('.choosed_list_container').removeClass('show');
      }
    });

    $('.is-checkbox').on('click', function() {
      $(this).addClass('is-active');
    });

    $('.search__switcher a').click(function () {
      $('.search__switcher a').removeClass('is-active');
      $(this).addClass('is-active');
      return false;
    });

    if ($.cookie('CLickYesClass') === 'click_yes') {
      closeBlur();
    }

  });
}

function closeBlur() {
  $('body > .blur').addClass('blur_-allow');
  $('body > .blur').removeClass('blur_-disallow');
  $('#popup').css('display', 'none');
  $('#popup__content').css('display', 'none');
}

// Отображение дополнительного поля
function showKPfields() {
  thisField = $(this);
//  nextField = $(this).parent().next().children('input')
nextField = $(this).parent().next();
if (thisField.val().length > 7) {
  nextField.show();
} else {
  nextField.hide();
}
}

function checkSymbol() {
  alert('asd');
  if (((event.keyCode < 48) || (event.keyCode > 57)) && (event.keyCode != 46 ) && (event.keyCode != 44 ) )
  {
    event.returnValue = false;
  }
  else
  {
    stringTest = document.getElementById ('account_amount').value + String.fromCharCode(event.keyCode)
    test = /^(\w*)?(\.|\,)?(\w*)?$/.test(stringTest);
    if (test)
      true;
    else
      event.returnValue = false;
  }
}

function showCatalogInMain() {
  $('.open-filter a').click(function () {$('.page .b').hide();$('.page .c').show();})
}

//Добавление активности в каталоге Админки
function addActive(id) {
  $('.dd-item').removeClass('is-active');
  $('[data-id='+id+']').addClass('is-active')
}

// Подгон высоты на странице с контактами
if ($(".map").length) {
  $('.top').css('min-height', '950px');
}

// Открытие новотей на главной
$(document).ready(function() {
  $(".entry").on("click", function() {
    $(this).toggleClass("is-large")
  })
})

function checkClickFilter() {
//  $('a.search__switcher1').click( function() {hideF();})
//  $('a.search__switcher2').click( function() {hideF();})
//  $('a.destroy_marker').click( function() {hideF();})
//  $('div a.is-checkbox').click( function() {hideF();})
//  $('.search__reset a').click( function() {hideF();})
//  $('a.search__showall').click( function() {hideF();})

  $('.search_wide').click( function() {hideF();})
  $('a.destroy_marker').click( function() {hideF();})

}

function hideF() {
  document.getElementsByClassName("spinner")[0].style.display="block";
}

function showF() {
  document.getElementsByClassName("spinner")[0].style.display="none";
}
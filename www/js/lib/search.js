/*!
* jQuery Cycle2; build: v20131005
* http://jquery.malsup.com/cycle2/
* Copyright (c) 2013 M. Alsup; Dual licensed: MIT/GPL
*/

/*! core engine; version: 20131003 */


    var country = [
            {
                name: "Италия",
                id: 'it'
            },
            {
                name: "Франция",
                id: "fr"
            },
            {
                name: 'Испания',
                id: 'sp'
            },
            {
                name: 'Чили',
                id: 'chili'
            }

        ],
        region = [
            {
                name:'Бордо',
                id:'br'
            },
            {
                name:'Долина бла',
                id:'bl'
            },
            {
                name:'Долина блю',
                id:'blu'
            },
            {
                name:'Долина бло',
                id:'blo'
            }
        ],
        category = [
            {
                name:'белые',
                id:'white',
                icon_class: 'search__categicon1'
            },
            {
                name:'Красные',
                id:'white',
                icon_class: 'search__categicon2'
            },
            {
                name:'Розовые',
                id:'white',
                icon_class: 'search__categicon3'
            },
            {
                name:'Игристые',
                id:'white',
                icon_class: 'search__categicon4'
            }
        ],
        produce = [
            {
                name:'Люсьен',
                id:'ls'
            },
            {
                name:'Лосьон',
                id:'lsn'
            },
            {
                name:'Большая Арнаутская',
                id:'blu'
            },
            {
                name:'Парень из соседнего парадного',
                id:'blo'
            }
        ],
        price = [
            {
                from:'0',
                to:'550',
                id:'1'
            },
            {
                from:'551',
                to:'1550',
                id:'2'
            }
        ]
        ;

    var app = {
        country: country,
        region: region,
        category: category,
        produce: produce,
        price: price
    };



$.fn.search = function(options) {
    // fix mistakes with the ready state
    var o;


    return this.each(function() {

        function resizeS(o){
            var wh = $(window).height() - 80,
                sh = $ts.height() ,
                len = $search__options.length,
                count = [],
                min = 50,
                max = 0,
                $current_item, minn, maxx;

                if(o){
                    $search__options.each(function(){
                        var $li = $(this).find(">li");
                            $li.data('height',$li.height());

                    })
                }


                $search__options.each(function(index){
                    count.push({"order":index, "count": $(this).find(">:not(.hide)").size()})
                });

                for(var i=0; i < count.length; i++) {
                    min = Math.min(count[i].count, min);
                    minn = (count[i].count == min)?count[i]:minn;
                }
                for(var i=0; i < count.length; i++) {
                    max = Math.max(count[i].count, max);
                    maxx = (count[i].count == max)?count[i]:maxx;
                }


                    //if($($search__options[minn.order]).)

                    if (($(window).height()-80) > $ts.height()) { //show

                        $current_item = $($search__options[minn.order]);

                        var $li = $current_item.find(">.hide").last();
                        if($ts.height() + $li.data('height') < $(window).height()-80){
                            $li.removeClass('hide');
                        }


                    }else{  //hide

                        $current_item = $($search__options[maxx.order]);

                        var $li = $current_item.find(">:not(.hide)").last();
                        if($ts.height() - $li.data('height') > $(window).height()-80){
                            $li.addClass('hide')
                        }

                    }






         //   while(i > 0){
      /*          $search__options.each(function(index){
                    if(wh < sh) {
                        $(this).find(">:not(.hide)").last().addClass('hide')
                        console.log("wh ->"+wh +"---sh --->"+ sh );

                    }else{
                        $(this).find(">.hide").last().removeClass('hide')
                        console.log(2)
                    }
                    if((wh - sh) > 0 &&  (wh - sh)< 20) return false;
                })

             */

        }

        var $ts = $(this),
            $search__filters = $ts.find('.search__filters'),
            $temp = $($search__filters.attr('data-template'))
            ;
            $search__filters.html($temp.render(app));

            var $search__options = $ts.find('.search__options');

        $(window).on('resize',resizeS)
        resizeS(1);

    });
};

$('.search').search();


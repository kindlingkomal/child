		var todayDate = new Date();
        var date ;
        var day ;
        var year ;
        var month;

		var curr_selected_day;
		var curr_selected_date;
		var curr_selected_month;
		var curr_selected_year;

        var monthonlyshow = false;
        $$$size = 7;
        $countItemrendered = 0;

        var wdays = [];
        var nodays = [];
        var name_of_month_full = [];
        initDates();
        //initSlider(todayDate);


        function initSlider(d){
            date = d.getDate();
            day = d.getDay()+1;
            year = d.getFullYear();
            month = d.getMonth()+1;


			curr_selected_day = d.getDay()+1;
            curr_selected_date = d.getDate();
            curr_selected_month = d.getMonth()+1;
            curr_selected_year = d.getFullYear();

            $("#dateslider").html("");
            manageNext(day,date,month,year);

			$countItemrendered = 0;
        }

    function initDates(){
        wdays[0] = 'non';
        wdays[1] = 'Sun';
        wdays[2] = 'Mon';
        wdays[3] = 'Tue';
        wdays[4] = 'Wed';
        wdays[5] = 'Thu';
        wdays[6] = 'Fri';
        wdays[7] = 'Sat';

        name_of_month_full[0] = 'noMonth';
        name_of_month_full[1] = 'JANUARY';
        name_of_month_full[2] = 'FEBRUARY';
        name_of_month_full[3] = 'MARCH';
        name_of_month_full[4] = 'APRIL';
        name_of_month_full[5] = 'MAY';
        name_of_month_full[6] = 'JUNE';
        name_of_month_full[7] = 'JULY';
        name_of_month_full[8] = 'AUGUST';
        name_of_month_full[9] = 'SEPTEMBER';
        name_of_month_full[10] = 'OCTOBER';
        name_of_month_full[11] = 'NOVEMBER';
        name_of_month_full[12] = 'DECEMBER';

        nodays[0] = '0';
        nodays[1] = '31';
        nodays[2] = '29';
        nodays[3] = '30';
        nodays[4] = '31';
        nodays[5] = '30';
        nodays[6] = '31';
        nodays[7] = '30';
        nodays[8] = '31';
        nodays[9] = '30';
        nodays[10] = '31';
        nodays[11] = '30';
        nodays[12] = '31';

    }


    function manageNext(Sday,Sdate,Smonth,Syear){
		$countItemrendered = 0;
		parseDate(Sday,Sdate,Smonth,Syear);
		for(i=1;i<$$$size;i++){
			Sday++;
			Sdate++;
			if(Sday>7) Sday=1;
			if(Smonth == 2) nodays[Smonth] = getLeapVal(Syear);
			if(Sdate>nodays[Smonth]) {
				Smonth++;
				if(Smonth>12){
					Syear++;
					Smonth = 1;
				}
				Sdate = 1;
			}
			monthonlyshow = false;
			if(Sdate==1 && i==$$$size-1)monthonlyshow=true;
			else if(Sdate == 1)i++;

			parseDate(Sday,Sdate,Smonth,Syear);

		}
		$("div.dateInSlider").css("width",(100/$$$size)+"%");
		$("div.monthDivider").css("width",(100/$$$size)+"%");
		selectDate();
    }

    function parseDate(w,x,y,z){

        if(x==1 && $countItemrendered < $$$size){
            var monthStartItem = document.createElement("div");
            monthStartItem.setAttribute("id",name_of_month_full[y]+"dateSliderDivider");
            monthStartItem.setAttribute("class","monthDivider");
            var monthChar = name_of_month_full[y].split('');
            monthStartItem.innerHTML = monthChar[0]+"<br>"+monthChar[1]+"<br>"+monthChar[2];
            $(monthStartItem).appendTo("#dateslider");
            $countItemrendered ++;
        }

        if($countItemrendered < $$$size){
            $countItemrendered++;
            var slideItem = document.createElement("div");
            slideItem.setAttribute("id",x+"date"+name_of_month_full[y]+"dateSlider");
			slideItem.setAttribute("onclick","setCurrDate("+w+","+x+","+y+","+z+")");
            slideItem.setAttribute("class","dateInSlider");

            var str='';
            str+='<center><span class="weekday">'+wdays[w]+'</span><br/><span class="dateofMonth">'+x+'</span></center>';
            $(slideItem).html(str);



            $("#dateslider").append(slideItem);


            $('<input>').attr({
                type: 'hidden',
                value: w,
                id: 'day'+name_of_month_full[y]+x+"slideItem",
                class: 'dayHide'
            }).appendTo("#"+x+"date"+name_of_month_full[y]+"dateSlider");
            $('<input>').attr({
                type: 'hidden',
                value: x,
                id: 'date'+name_of_month_full[y]+x+"slideItem",
                class: 'dateHide'
            }).appendTo("#"+x+"date"+name_of_month_full[y]+"dateSlider");
            $('<input>').attr({
                type: 'hidden',
                value: y,
                id: 'month'+name_of_month_full[y]+x+"slideItem",
                class: 'monthHide'
            }).appendTo("#"+x+"date"+name_of_month_full[y]+"dateSlider");
            $('<input>').attr({
                type: 'hidden',
                value: z,
                id: 'year'+name_of_month_full[y]+x+"slideItem",
                class: 'yearHide'
            }).appendTo("#"+x+"date"+name_of_month_full[y]+"dateSlider");
        }
    }

    function setCurrDate(w,x,y,z){
		curr_selected_day = w;
		curr_selected_date = x;
		curr_selected_month = y;
		curr_selected_year = z;
		selectDate();
	}

  function selectDate(){
    $("input[name='pick_up[date]']").val(curr_selected_year + '-' + curr_selected_month + '-' + curr_selected_date);
		console.log(curr_selected_date+" "+wdays[curr_selected_day]+" "+curr_selected_month+" "+curr_selected_year);
		$('.dateInSlider').css('border','none');
		console.log(curr_selected_date+"date"+name_of_month_full[curr_selected_month]+"dateSlider");
		$("#"+curr_selected_date+"date"+name_of_month_full[curr_selected_month]+"dateSlider").css("border-bottom","2px solid black");

  }

    function nextSlide_date_paginator(){
        day++;
        date++;
        if(day>7) day=1;
        if(month == 2) nodays[month] = getLeapVal(year);
        if(date>nodays[month]) {
            month++;
            if(month>12){
                year++;
                month = 1;
            }
            date = 1;
        }
        $("#dateslider").html("");
        manageNext(day,date,month,year);
		$(".prev_date_slider").css('opacity','1');

    }
    function prevSlide_date_paginator(){
       if(	year>todayDate.getFullYear() ||
			(year == todayDate.getFullYear() && month > todayDate.getMonth()+1) ||
			(year == todayDate.getFullYear() && month == todayDate.getMonth()+1 && date > todayDate.getDate() ) ){
			day--;
			date--;
			if(day<1) day=7;
			if(date==0) {
				month--;
				if(month<1){
					year--;
					month = 12;
				}
				if(month == 2) nodays[month] = getLeapVal(year);
				date = nodays[month];
			}

       	   $("#dateslider").html("");
			   manageNext(day,date,month,year);
	   }
	  if(year == todayDate.getFullYear() && month == todayDate.getMonth()+1 && date == todayDate.getDate() ){
		$(".prev_date_slider").css('opacity','0.6');
	  }
	}


    function getLeapVal(year){
		if(year%400==0)
			return 29;
		else if(year%100==0){
			return 28;
		}
		else if (year%4 == 0){
			return 29;
		}
		else{
			return 28;
		}
	}

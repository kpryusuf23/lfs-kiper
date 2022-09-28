#############################################################################
# GUI (Graphical User Interface) Version 1.0.7 by Tim NL                    #
#############################################################################
# Ver 1.0.4  Change date 24-3-2009 Rebuild from v5.716 to v5.829
# Ver 1.0.4B Change date 08-4-2009 Changed and improved track selector.
#                                  Removed /car at lapper restart
#                                  Removed flickering by track select
# Ver 1.0.5 Change date 17-7-2009 Changed and improved Car selector.
# Ver 1.0.7 Change date 07-9-2009 Add BL3 AU1 AU2 AU3 AU4
#                                 Add Laps/Hours choice
#                                 Updated drift part at end of this script
#
# Install this file into ..\bin\default\includes
#
############################################################################
#If you want to use the Drift Option see part at end of Script             #
############################################################################

Sub OnLapperStart_config_Gui()
	GlobalVar $GUI_origL ;
	GlobalVar $GUI_origT ;
	GlobalVar $GUI_Lap_hour_number ;
	GlobalVar $GUI_Lap_hour ;
	GlobalVar $GUI_lap_temp ;
  GlobalVar $GUI_hour_temp ;  	
	GlobalVar $GUI_qual ;
	GlobalVar $GUI_wind ;
	GlobalVar $GUI_weather ;
	GlobalVar $GUI_mustpit ;
	GlobalVar $GUI_fcv ;
	GlobalVar $GUI_drift ;
	GlobalVar $GUI_midrace ;
	GlobalVar $GUI_start ;
 	GlobalVar $GUI_current_car ;
  GlobalVar $GUI_set_plusmin;
  GlobalVar $GUI_last_char_check;
  GlobalVar $GUI_set_car;
 	 $GUI_origL = "40" ;
	 $GUI_origT = "60" ;
	 $GUI_Lap_hour = "laps" ;
	 
	 ### SET THE FOLLOWING VAR'S TO SETUP YOUR SERVER WHEN LFSLAPPER (RE)START ####
	 $GUI_Lap_hour_number = 5 ;            #Number of race laps
	 $GUI_qual = 10 ;                      #Number of qual minutes
	 $GUI_wind = 0 ;                       #0=no wind 1=low wind 2=hard wind
	 $GUI_weather = 1 ;                    #set type of wheather 0,1 or 2
	 $GUI_mustpit = "no" ;                 #need to pit yes or no
	 $GUI_fcv = "no" ;                     #Force cockpit view yes or no
	 $GUI_drift = "no" ;                   #Drift option yes or no ( see the part at end of this script)
	 $GUI_midrace = "yes" ;	               #Join midrace yes or no
	 $GUI_start = "finish" ;               #Race start order : fixed/finish/reverse/random
   $GUI_current_car = "?" ;              #You can set here the default car. If not set,the first time when the config GUI start its show's a "?".
   ### END  ###
   
	GlobalVar $GUI_col_bl ; GlobalVar $GUI_col_bl_rev ;
	 $GUI_col_bl_rev = 32 ;
	GlobalVar $GUI_col_so ; GlobalVar $GUI_col_so_rev ;
	 $GUI_col_so_rev = 32 ;
	GlobalVar $GUI_col_fe ; GlobalVar $GUI_col_fe_rev ;
	  $GUI_col_fe_rev = 32 ;
	GlobalVar $GUI_col_ky ; GlobalVar $GUI_col_ky_rev ;
	 $GUI_col_ky_rev = 32 ;
	GlobalVar $GUI_col_we ; GlobalVar $GUI_col_we_rev ;
	 $GUI_col_we_rev = 32 ;
	GlobalVar $GUI_col_as ; GlobalVar $GUI_col_as_rev ;
	 $GUI_col_as_rev = 32 ;
	GlobalVar $GUI_col_au ;
	GlobalVar $GUI_col_bl0 ; GlobalVar $GUI_col_so0 ; GlobalVar $GUI_col_fe0 ; GlobalVar $GUI_col_ky0 ; GlobalVar $GUI_col_we0 ; GlobalVar $GUI_col_as0 ;
	 $GUI_col_bl0 = 32 ; $GUI_col_so0 = 32 ; $GUI_col_fe0 = 32 ; $GUI_col_ky0 = 32 ; $GUI_col_we0 = 32 ; $GUI_col_as0 = 32 ;

	GlobalVar $GUI_col_laps ; GlobalVar $GUI_col_hours ;
	 $GUI_col_laps = 16 ; $GUI_col_hours = 32 ;

	GlobalVar $GUI_col_mustpit_yes ; GlobalVar $GUI_col_mustpit_no ;
	 $GUI_col_mustpit_yes = 16 ; $GUI_col_mustpit_no = 32 ;
	
	GlobalVar $GUI_col_fcv_yes ; GlobalVar $GUI_col_fcv_no ;
	 $GUI_col_fcv_yes = 16 ; $GUI_col_fcv_no = 32 ;
	
	GlobalVar $GUI_col_midrace_yes ; GlobalVar $GUI_col_midrace_no ;
	 $GUI_col_midrace_yes = 16 ; $GUI_col_midrace_no = 32 ;
	
	GlobalVar $GUI_col_wind_0 ; GlobalVar $GUI_col_wind_1 ; GlobalVar $GUI_col_wind_2 ;
	 $GUI_col_wind_0 = 16 ; $GUI_col_wind_1 = 32 ; $GUI_col_wind_2 = 32 ;
	
	GlobalVar $GUI_col_start_0 ; GlobalVar $GUI_col_start_1 ; GlobalVar $GUI_col_start_2 ; GlobalVar $GUI_col_start_3 ;
	 $GUI_col_start_0 = 32 ; $GUI_col_start_1 = 32 ; $GUI_col_start_2 = 32 ; $GUI_col_start_3 = 32 ;
	
	GlobalVar $GUI_col_weather_1 ; GlobalVar $GUI_col_weather_2 ; GlobalVar $GUI_col_weather_3 ;
	 $GUI_col_weather_1 = 32 ; $GUI_col_weather_2 = 32 ; $GUI_col_weather_3 = 32 ;
	
	GlobalVar $GUI_col_drift_yes ; GlobalVar $GUI_col_drift_no ; GlobalVar $Angle_drift ;
	 $GUI_col_drift_yes = 16 ; $GUI_col_drift_no = 32 ; $Angle_drift = 0 ;	
	
 	GlobalVar $GUI_current_track ;
 	GlobalVar $GUI_track_label ;
 	GlobalVar $GUI_track_rev ;
 	GlobalVar $cur_track ;
 	GlobalVar $GUI_cur_tracknumber ;
 	
    $GUI_lap_temp=$GUI_Lap_hour_number ;
    $GUI_hour_temp=1 ;
        
	cmdLFS( "/" . $GUI_Lap_hour . " " . $GUI_Lap_hour_number );
	cmdLFS( "/qual " . $GUI_qual );
	cmdLFS( "/wind " . $GUI_wind );
	cmdLFS( "/weather " . $GUI_weather );
	cmdLFS( "/mustpit " . $GUI_mustpit );
	cmdLFS( "/midrace " . $GUI_midrace );
	cmdLFS( "/fcv " . $GUI_fcv );
	cmdLFS( "/start " . $GUI_start );  
EndSub

Sub config_gui( $KeyFlags,$id )
   $GUI_cur_track= GetLapperVar( "ShortTrackName" );
   $GUI_track_label = substr( $GUI_cur_track,0,2 );
   $GUI_current_track = substr( $GUI_cur_track,0,3 );
   $GUI_track_rev = substr( $GUI_cur_track,3,1 );
   $GUI_cur_tracknumber =ToNum(substr( $GUI_cur_track,2,1 ));
   $HostName = getLapperVar( "HostName" );
#   $GUI_Lap_hour_number = getLapperVar( "RaceLaps" );  #Number of race laps
#   $GUI_qual = getLapperVar( "QalMins" );              #Number of qual minutes 
	openPrivButton( "gui_border",$GUI_origL-2,$GUI_origT-1,78,90,5,-1,16," " );
	openPrivButton( "gui_main",$GUI_origL-1,$GUI_origT,76,88,5,-1,32," " );
	openPrivButton( "gui_banner",$GUI_origL-1,$GUI_origT,76,6,5,-1,32,"GUI (Graphical User Interface)  " . $HostName );
	openPrivButton( "gui_ver",$GUI_origL+3,$GUI_origT+81,12,3,3,-1,0,"^0GUI Version 1.0.7 by Tim NL" );
	openPrivButton( "laps_box",$GUI_origL,$GUI_origT+8,26,10,4,-1,32," " );
	openPrivButton( "laps",$GUI_origL+1,$GUI_origT+9,7,4,4,-1,$GUI_col_laps,"Laps",config_lap_hour );
	openPrivButton( "hours",$GUI_origL+1,$GUI_origT+13,7,4,4,-1,$GUI_col_hours,"Hours",config_lap_hour );	
	openPrivButton( "lapsvar",$GUI_origL+9,$GUI_origT+9,8,4,4,-1,16, . $GUI_Lap_hour_number  );
	openPrivButton( "laps-hour",$GUI_origL+17,$GUI_origT+9,8,4,4,-1,16, .$GUI_Lap_hour  );	
	openPrivButton( "lap-5",$GUI_origL+9,$GUI_origT+13,4,4,4,-1,16,"-5",config_lap_M5 );
	openPrivButton( "lap-1",$GUI_origL+13,$GUI_origT+13,4,4,4,-1,16,"-1",config_lap_M1 );
	openPrivButton( "lap+1",$GUI_origL+17,$GUI_origT+13,4,4,4,-1,16,"+1",config_lap_P1 );
	openPrivButton( "lap+5",$GUI_origL+21,$GUI_origT+13,4,4,4,-1,16,"+5",config_lap_P5 );
	openPrivButton( "qual_box",$GUI_origL+27,$GUI_origT+8,18,10,4,-1,32," " );
	openPrivButton( "qual",$GUI_origL+28,$GUI_origT+9,8,4,4,-1,32,"Qual" );
	openPrivButton( "qualvar",$GUI_origL+36,$GUI_origT+9,8,4,4,-1,16," " . $GUI_qual  );
	openPrivButton( "qual-5",$GUI_origL+28,$GUI_origT+13,4,4,4,-1,16,"-5",config_qual_M5 );
	openPrivButton( "qual-1",$GUI_origL+32,$GUI_origT+13,4,4,4,-1,16,"-1",config_qual_M1 );
	openPrivButton( "qual+1",$GUI_origL+36,$GUI_origT+13,4,4,4,-1,16,"+1",config_qual_P1 );
	openPrivButton( "qual+5",$GUI_origL+40,$GUI_origT+13,4,4,4,-1,16,"+5",config_qual_P5 );
	openPrivButton( "current_box",$GUI_origL+46,$GUI_origT+8,28,10,4,-1,32," " );
	openPrivButton( "track",$GUI_origL+47,$GUI_origT+9,6,4,4,-1,96,"Track: " );
	openPrivButton( "car",$GUI_origL+47,$GUI_origT+13,6,4,4,-1,96,"Car's: " );
	openPrivButton( "current_track",$GUI_origL+53,$GUI_origT+9,20,4,4,-1,16, . $GUI_current_track );
	openPrivButton( "current_car",$GUI_origL+53,$GUI_origT+13,20,4,4,-1,16, . $GUI_current_car );

  openPrivButton( "select_car_box_w",$GUI_origL+76,$GUI_origT+42,44,47,4,-1,16," " );
  openPrivButton( "select_car_box_b",$GUI_origL+77,$GUI_origT+43,42,45,4,-1,32," " );
  openPrivButton( "select_car_top_txt",$GUI_origL+77,$GUI_origT+43,42,6,5,-1,32,"Select Car's" );
  openPrivButton( "select_car_UFR+XFR",$GUI_origL+78,$GUI_origT+50,8,4,4,-1,16,"FWD",config_select_car );
  openPrivButton( "select_car_UFR",$GUI_origL+86,$GUI_origT+50,8,4,4,-1,16,"UFR",config_select_car );
  openPrivButton( "select_car_XFR",$GUI_origL+94,$GUI_origT+50,8,4,4,-1,16,"XFR",config_select_car );
  openPrivButton( "select_car_fill1",$GUI_origL+102,$GUI_origT+50,8,4,4,-1,16," " );
  openPrivButton( "select_car_ALL",$GUI_origL+110,$GUI_origT+50,8,4,4,-1,16,"ALL",config_select_car );
  openPrivButton( "select_car_GTR",$GUI_origL+78,$GUI_origT+54,8,4,4,-1,16,"GTR",config_select_car );
  openPrivButton( "select_car_FXR",$GUI_origL+86,$GUI_origT+54,8,4,4,-1,16,"FXR",config_select_car );
  openPrivButton( "select_car_XRR",$GUI_origL+94,$GUI_origT+54,8,4,4,-1,16,"XRR",config_select_car );
  openPrivButton( "select_car_FZR",$GUI_origL+102,$GUI_origT+54,8,4,4,-1,16,"FZR",config_select_car );
  openPrivButton( "select_car_fill2",$GUI_origL+110,$GUI_origT+54,8,4,4,-1,16," " );
  openPrivButton( "select_car_TBO",$GUI_origL+78,$GUI_origT+58,8,4,4,-1,16,"TBO",config_select_car );
  openPrivButton( "select_car_RB4",$GUI_origL+86,$GUI_origT+58,8,4,4,-1,16,"RB4",config_select_car );
  openPrivButton( "select_car_FXO",$GUI_origL+94,$GUI_origT+58,8,4,4,-1,16,"FXO",config_select_car );
  openPrivButton( "select_car_XRT",$GUI_origL+102,$GUI_origT+58,8,4,4,-1,16,"XRT",config_select_car );
  openPrivButton( "select_car_fill3",$GUI_origL+110,$GUI_origT+58,8,4,4,-1,16," " );
  openPrivButton( "select_car_MRT",$GUI_origL+78,$GUI_origT+62,8,4,4,-1,16,"MRT",config_select_car );
  openPrivButton( "select_car_FBM",$GUI_origL+86,$GUI_origT+62,8,4,4,-1,16,"FBM",config_select_car );
  openPrivButton( "select_car_FOX",$GUI_origL+94,$GUI_origT+62,8,4,4,-1,16,"FOX",config_select_car );
  openPrivButton( "select_car_FO8",$GUI_origL+102,$GUI_origT+62,8,4,4,-1,16,"FO8",config_select_car );
  openPrivButton( "select_car_BF1",$GUI_origL+110,$GUI_origT+62,8,4,4,-1,16,"BF1",config_select_car );
  openPrivButton( "select_car_LX4+LX6+RAC+FZ5",$GUI_origL+78,$GUI_origT+66,8,4,4,-1,16,"RWD",config_select_car );
  openPrivButton( "select_car_LX4",$GUI_origL+86,$GUI_origT+66,8,4,4,-1,16,"LX4",config_select_car );
  openPrivButton( "select_car_LX6",$GUI_origL+94,$GUI_origT+66,8,4,4,-1,16,"LX6",config_select_car );
  openPrivButton( "select_car_RAC",$GUI_origL+102,$GUI_origT+66,8,4,4,-1,16,"RAC",config_select_car );
  openPrivButton( "select_car_FZ5",$GUI_origL+110,$GUI_origT+66,8,4,4,-1,16,"FZ5",config_select_car );
  openPrivButton( "select_car_XFG+XRG",$GUI_origL+78,$GUI_origT+70,8,4,4,-1,16,"XFG+XRG",config_select_car );
  openPrivButton( "select_car_XFG",$GUI_origL+86,$GUI_origT+70,8,4,4,-1,16,"XFG",config_select_car );
  openPrivButton( "select_car_XRG",$GUI_origL+94,$GUI_origT+70,8,4,4,-1,16,"XRG",config_select_car );
  openPrivButton( "select_car_UF1",$GUI_origL+102,$GUI_origT+70,8,4,4,-1,16,"UF1",config_select_car );
  openPrivButton( "select_car_VWS",$GUI_origL+110,$GUI_origT+70,8,4,4,-1,16,"VWS",config_select_car );
  openPrivButton( "select_car_+",$GUI_origL+78,$GUI_origT+75,8,4,4,-1,16,"^0+",config_select_plusmin );
  openPrivButton( "select_car_-",$GUI_origL+86,$GUI_origT+75,8,4,4,-1,16,"^0-",config_select_plusmin );
  openPrivButton( "select_car_set",$GUI_origL+94,$GUI_origT+75,8,4,4,-1,16,"^0Set",set_car );
  openPrivButton( "select_car_clear",$GUI_origL+102,$GUI_origT+75,8,4,4,-1,16,"^0Clear",config_select_clear );
  openPrivButton( "select_car_fill4",$GUI_origL+110,$GUI_origT+75,8,4,4,-1,16," " );
  openPrivButton( "select_car_selection",$GUI_origL+78,$GUI_origT+79,12,4,4,-1,32,"Selected Cars" );  
  openPrivButton( "select_car_string",$GUI_origL+90,$GUI_origT+79,28,4,4,-1,16, . $GUI_current_car );
  
  openPrivButton( "mid_box",$GUI_origL,$GUI_origT+22,35,6,4,-1,32," " );
	openPrivButton( "mid",$GUI_origL+1,$GUI_origT+23,16,4,4,-1,32,"Join Midrace" );
	  IF( $GUI_midrace == "yes" )
	  THEN
		  $GUI_col_midrace_yes = 16;
		  $GUI_col_midrace_no = 32;
	  ELSE
		  $GUI_col_midrace_yes = 32;
		  $GUI_col_midrace_no = 16;
	  ENDIF
	openPrivButton( "mid_yes",$GUI_origL+18,$GUI_origT+23,8,4,4,-1,$GUI_col_midrace_yes,"Yes",config_midyes );
	openPrivButton( "mid_no",$GUI_origL+26,$GUI_origT+23,8,4,4,-1,$GUI_col_midrace_no,"No",config_midno );
	openPrivButton( "mustpit_box",$GUI_origL,$GUI_origT+30,35,6,4,-1,32," " );
	openPrivButton( "mustpit",$GUI_origL+1,$GUI_origT+31,16,4,4,-1,32,"Must Pit" );
	  IF( $GUI_mustpit == "yes" )
	  THEN
		  $GUI_col_mustpit_yes = 16;
		  $GUI_col_mustpit_no = 32;
	  ELSE
		  $GUI_col_mustpit_yes = 32;
		  $GUI_col_mustpit_no = 16;
	  ENDIF
	openPrivButton( "pit_yes",$GUI_origL+18,$GUI_origT+31,8,4,4,-1,$GUI_col_mustpit_yes,"Yes",config_pit_yes );
	openPrivButton( "pit_no",$GUI_origL+26,$GUI_origT+31,8,4,4,-1,$GUI_col_mustpit_no,"No",config_pit_no );
	openPrivButton( "fcv_box",$GUI_origL,$GUI_origT+38,35,6,4,-1,32," " );
	openPrivButton( "fcv",$GUI_origL+1,$GUI_origT+39,16,4,4,-1,32,"Force Cockpit View" );
	  IF( $GUI_fcv == "yes" )
	  THEN
		  $GUI_col_fcv_yes = 16;
		  $GUI_col_fcv_no = 32;
	  ELSE
		  $GUI_col_fcv_yes = 32;
		  $GUI_col_fcv_no = 16;
	  ENDIF
	openPrivButton( "fcv_yes",$GUI_origL+18,$GUI_origT+39,8,4,4,-1,$GUI_col_fcv_yes,"Yes",config_fcv_yes );
	openPrivButton( "fcv_no",$GUI_origL+26,$GUI_origT+39,8,4,4,-1,$GUI_col_fcv_no,"No",config_fcv_no );
	openPrivButton( "wind_box",$GUI_origL,$GUI_origT+46,43,6,4,-1,32," " );
	openPrivButton( "wind",$GUI_origL+1,$GUI_origT+47,16,4,4,-1,32,"Wind" );
	  IF( $GUI_wind == 0 )
	  THEN
		  $GUI_col_wind_0 = 16;
		  $GUI_col_wind_1 = 32;
		  $GUI_col_wind_2 = 32;
	  ELSE
	  	IF( $GUI_wind == 1 )
	    THEN
			  $GUI_col_wind_0 = 32;
			  $GUI_col_wind_1 = 16;
			  $GUI_col_wind_2 = 32;
	    ELSE
			  $GUI_col_wind_0 = 32;
			  $GUI_col_wind_1 = 32;
			  $GUI_col_wind_2 = 16;
	    ENDIF
	  ENDIF 
	openPrivButton( "wind_0",$GUI_origL+18,$GUI_origT+47,8,4,4,-1,$GUI_col_wind_0,"Off",config_wind_0 );
	openPrivButton( "wind_1",$GUI_origL+26,$GUI_origT+47,8,4,4,-1,$GUI_col_wind_1,"Low",config_wind_1 );
	openPrivButton( "wind_2",$GUI_origL+34,$GUI_origT+47,8,4,4,-1,$GUI_col_wind_2,"High",config_wind_2 );
	openPrivButton( "weather_box",$GUI_origL,$GUI_origT+54,71,6,4,-1,32," " );
	openPrivButton( "weather",$GUI_origL+1,$GUI_origT+55,16,4,4,-1,32,"Weather" );
	  IF( $GUI_weather == 1 )
	  THEN
		  $GUI_col_weather_0 = 16;
		  $GUI_col_weather_1 = 32;
		  $GUI_col_weather_2 = 32;
	  ELSE
	  	IF( $GUI_weather == 2 )
	    THEN
			  $GUI_col_weather_0 = 32;
			  $GUI_col_weather_1 = 16;
			  $GUI_col_weather_2 = 32;
	    ELSE
			  $GUI_col_weather_0 = 32;
			  $GUI_col_weather_1 = 32;
			  $GUI_col_weather_2 = 16;
	    ENDIF
	  ENDIF 
	openPrivButton( "weather_0",$GUI_origL+18,$GUI_origT+55,12,4,4,-1,$GUI_col_weather_0,"Clear Day",config_weather_0 );
	openPrivButton( "weather_1",$GUI_origL+30,$GUI_origT+55,13,4,4,-1,$GUI_col_weather_1,"Cloudy Afternoon",config_weather_1 );
	openPrivButton( "weather_2",$GUI_origL+43,$GUI_origT+55,12,4,4,-1,$GUI_col_weather_2,"Cloudy sunset",config_weather_2 );
	openPrivButton( "weather_end",$GUI_origL+56,$GUI_origT+55,14,4,4,-1,16,"END Race to set",end_race );
	openPrivButton( "start_box",$GUI_origL,$GUI_origT+62,51,6,4,-1,32," " );
	openPrivButton( "start",$GUI_origL+1,$GUI_origT+63,16,4,4,-1,32,"Start Grid" );
	  IF( $GUI_start == "fixed" )
	  THEN
		  $GUI_col_start_0 = 16;
		  $GUI_col_start_1 = 32;
		  $GUI_col_start_2 = 32;
		  $GUI_col_start_3 = 32;
	  ELSE
	   	IF( $GUI_start == "finish" )
	    THEN
		  	$GUI_col_start_0 = 32;
		 	  $GUI_col_start_1 = 16;
		 	  $GUI_col_start_2 = 32;
		  	$GUI_col_start_3 = 32;
	    ELSE
	      IF( $GUI_start == "reverse" )
	      THEN
		     	$GUI_col_start_0 = 32;
		     	$GUI_col_start_1 = 32;
		     	$GUI_col_start_2 = 16;
		     	$GUI_col_start_3 = 32;
		 	  ELSE
		     	$GUI_col_start_0 = 32;
		     	$GUI_col_start_1 = 32;
		     	$GUI_col_start_2 = 32;
		     	$GUI_col_start_3 = 16;
			  ENDIF
	    ENDIF
	  ENDIF 
	openPrivButton( "start_0",$GUI_origL+18,$GUI_origT+63,8,4,4,-1,$GUI_col_start_0,"Fixed",config_start_0 );
	openPrivButton( "start_1",$GUI_origL+26,$GUI_origT+63,8,4,4,-1,$GUI_col_start_1,"Finish",config_start_1 );
	openPrivButton( "start_2",$GUI_origL+34,$GUI_origT+63,8,4,4,-1,$GUI_col_start_2,"Reverse",config_start_2 );
	openPrivButton( "start_3",$GUI_origL+42,$GUI_origT+63,8,4,4,-1,$GUI_col_start_3,"Random",config_start_3 );
	openPrivButton( "drift_box",$GUI_origL,$GUI_origT+70,35,6,4,-1,32," " );
	openPrivButton( "drift",$GUI_origL+1,$GUI_origT+71,16,4,4,-1,32,"Drift Option" );
	  IF( $GUI_drift == "yes" )
	  THEN
		  $GUI_col_drift_yes = 16;
		  $GUI_col_drift_no = 32;
	  ELSE
		  $GUI_col_drift_yes = 32;
		  $GUI_col_drift_no = 16;
	  ENDIF
	openPrivButton( "drift_yes",$GUI_origL+18,$GUI_origT+71,8,4,4,-1,$GUI_col_drift_yes,"Yes",config_drift_yes );
	openPrivButton( "drift_no",$GUI_origL+26,$GUI_origT+71,8,4,4,-1,$GUI_col_drift_no,"No",config_drift_no );
	
  openPrivButton( "close_box",$GUI_origL+61,$GUI_origT+81,12,6,4,-1,32," ",config_close_gui );
  openPrivButton( "close_gui",$GUI_origL+62,$GUI_origT+82,10,4,4,-1,16,"Close",config_close_gui );
	config_select_track(0,0);
EndSub

Sub config_close_gui( $KeyFlags,$id )
  closePrivButton("gui_border&gui_main&gui_banner&gui_ver&close_box&close_gui");
  closePrivButton("drift_box&drift&drift_yes&drift_no");
  closePrivButton("current_box&current_track&current_car&track&car");
  closePrivButton("start_box&start&start_0&start_1&start_2&start_3");
  closePrivButton("wind_box&wind&wind_0&wind_1&wind_2");
  closePrivButton("weather_end&weather_box&weather&weather_0&weather_1&weather_2");
  closePrivButton("fcv_box&fcv&fcv_yes&fcv_no");
  closePrivButton("mid_box&mid&mid_yes&mid_no");
  closePrivButton("mustpit_box&mustpit&pit_yes&pit_no");
  closePrivButton("laps_box&hours&laps&lapsvar&laps-hour&lap-5&lap-1&lap+1&lap+5");
  closePrivButton("qual_box&qual&qualvar&qual-5&qual-1&qual+1&qual+5");
  closePrivButton("select_track_box_w&select_track_box_b&select_track_top_txt&select_track_bl&select_track_so&select_track_fe&select_track_ky&select_track_we&select_track_as&set_track&cancel_track&cancel_box_b&set_track_box_b");
  closePrivButton("select_track_BL1&select_track_BL2&select_track_BL3&select_track_bl_rev");
  closePrivButton("select_track_SO1&select_track_SO2&select_track_SO3&select_track_SO4&select_track_SO5&select_track_SO6&select_track_so_rev");
  closePrivButton("select_track_FE1&select_track_FE2&select_track_FE3&select_track_FE4&select_track_FE5&select_track_FE6&select_track_fe_rev");
  closePrivButton("select_track_KY1&select_track_KY2&select_track_KY3&select_track_ky_rev");
  closePrivButton("select_track_WE1&select_track_we_rev");
  closePrivButton("select_track_AS1&select_track_AS2&select_track_AS3&select_track_AS4&select_track_AS5&select_track_AS6&select_track_AS7&select_track_as_rev");
  closePrivButton("select_track_AU1&select_track_AU2&select_track_AU3&select_track_AU4");
  closePrivButton("select_car_box_w&select_car_box_b&select_car_top_txt&select_car_ALL");
  closePrivButton("select_car_GTR&select_car_FXR&select_car_XRR&select_car_FZR");
  closePrivButton("select_car_UFR+XFR&select_car_UFR&select_car_XFR");  
  closePrivButton("select_car_MRT&select_car_FBM&select_car_FOX&select_car_FO8&select_car_BF1");
  closePrivButton("select_car_TBO&select_car_RB4&select_car_FXO&select_car_XRT");
  closePrivButton("select_car_LX4+LX6+RAC+FZ5&select_car_LX4&select_car_LX6&select_car_RAC&select_car_FZ5");   
  closePrivButton("select_car_XFG+XRG&select_car_XFG&select_car_XRG&select_car_UF1&select_car_VWS");
  closePrivButton("select_car_fill1&select_car_fill2&select_car_fill3&select_car_fill4");
  closePrivButton("select_car_+&select_car_-&select_car_set&select_car_clear&select_car_leeg&select_car_selection&select_car_string"); 
EndSub

Sub config_drift_yes( $KeyFlags,$id )
  $GUI_drift="yes";
  closePrivButton("drift_yes&drift_no");
  openPrivButton( "drift_yes",$GUI_origL+18,$GUI_origT+71,8,4,4,-1,16,"Yes",config_drift_yes );
  openPrivButton( "drift_no",$GUI_origL+26,$GUI_origT+71,8,4,4,-1,32,"No",config_drift_no );
EndSub

Sub config_drift_no( $KeyFlags,$id )
  $GUI_drift="no";
  closePrivButton("drf0&drf1&drf2");
  closePrivButton("drift_yes&drift_no");
  openPrivButton( "drift_yes",$GUI_origL+18,$GUI_origT+71,8,4,4,-1,32,"Yes",config_drift_yes );
  openPrivButton( "drift_no",$GUI_origL+26,$GUI_origT+71,8,4,4,-1,16,"No",config_drift_no );
EndSub

Sub end_race( $KeyFlags,$id )
  cmdLFS( "/end");
EndSub

#########################
# Select Track          #
#########################

Sub config_select_track($KeyFlags,$id)

  $GUI_col_bl[1]=32; $GUI_col_bl[2]=32; $GUI_col_bl[3]=32;
  $GUI_col_so[1]=32; $GUI_col_so[2]=32; $GUI_col_so[3]=32; $GUI_col_so[4]=32; $GUI_col_so[5]=32; $GUI_col_so[6]=32;
  $GUI_col_fe[1]=32; $GUI_col_fe[2]=32; $GUI_col_fe[3]=32; $GUI_col_fe[4]=32; $GUI_col_fe[5]=32; $GUI_col_fe[6]=32;
  $GUI_col_ky[1]=32; $GUI_col_ky[2]=32; $GUI_col_ky[3]=32;
  $GUI_col_we[1]=32;
  $GUI_col_as[1]=32; $GUI_col_as[2]=32; $GUI_col_as[3]=32; $GUI_col_as[4]=32; $GUI_col_as[5]=32; $GUI_col_as[6]=32; $GUI_col_as[7]=32;
  $GUI_col_au[1]=32; $GUI_col_au[2]=32; $GUI_col_au[3]=32; $GUI_col_au[4]=32;

  SWITCH( $GUI_track_label )
	   CASE "BL":
	     $GUI_col_bl[$GUI_cur_tracknumber]=16;
		   $GUI_col_bl0 = 16; $GUI_col_so0 = 32; $GUI_col_fe0 = 32; $GUI_col_ky0 = 32; $GUI_col_we0 = 32; $GUI_col_as0 = 32;
		   IF($GUI_track_rev == "R" )
		   THEN
		      $GUI_col_bl_rev = 16; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
		   ELSE
          $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
       ENDIF   
	   BREAK;
	   CASE "SO":
	     $GUI_col_so[$GUI_cur_tracknumber]=16;
		   $GUI_col_bl0 = 32; $GUI_col_so0 = 16; $GUI_col_fe0 = 32; $GUI_col_ky0 = 32; $GUI_col_we0 = 32; $GUI_col_as0 = 32;
		   IF($GUI_track_rev == "R" )
		   THEN
		      $GUI_col_bl_rev = 32; $GUI_col_so_rev = 16; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
		   ELSE
          $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
       ENDIF		   
	   BREAK;
	   CASE "FE":
	     $GUI_col_fe[$GUI_cur_tracknumber]=16;
       $GUI_col_bl0 = 32; $GUI_col_so0 = 32; $GUI_col_fe0 = 16; $GUI_col_ky0 = 32; $GUI_col_we0 = 32; $GUI_col_as0 = 32;
		   IF($GUI_track_rev == "R" )
		   THEN
		      $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 16; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
		   ELSE
          $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
       ENDIF       
	   BREAK;
	   CASE "KY":
	     $GUI_col_ky[$GUI_cur_tracknumber]=16;
       $GUI_col_bl0 = 32; $GUI_col_so0 = 32; $GUI_col_fe0 = 32; $GUI_col_ky0 = 16; $GUI_col_we0 = 32; $GUI_col_as0 = 32;
		   IF($GUI_track_rev == "R" )
		   THEN
		      $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 16; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
		   ELSE
          $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
       ENDIF       
	   BREAK;
	   CASE "WE":
	     $GUI_col_we[$GUI_cur_tracknumber]=16;
       $GUI_col_bl0 = 32; $GUI_col_so0 = 32; $GUI_col_fe0 = 32; $GUI_col_ky0 = 32; $GUI_col_we0 = 16; $GUI_col_as0 = 32;
		   IF($GUI_track_rev == "R" )
		   THEN
		      $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 16; $GUI_col_as_rev = 32;
		   ELSE
          $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
       ENDIF        
	   BREAK;
	   CASE "AS":
	     $GUI_col_as[$GUI_cur_tracknumber]=16;
       $GUI_col_bl0 = 32; $GUI_col_so0 = 32; $GUI_col_fe0 = 32; $GUI_col_ky0 = 32; $GUI_col_we0 = 32; $GUI_col_as0 = 16;
		   IF($GUI_track_rev == "R" )
		   THEN
		      $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 16;
		   ELSE
          $GUI_col_bl_rev = 32; $GUI_col_so_rev = 32; $GUI_col_fe_rev = 32; $GUI_col_ky_rev = 32; $GUI_col_we_rev = 32; $GUI_col_as_rev = 32;
       ENDIF            	
	   BREAK;
	   CASE "AU":
	     $GUI_col_au[$GUI_cur_tracknumber]=16;
       $GUI_col_bl0 = 32; $GUI_col_so0 = 32; $GUI_col_fe0 = 32; $GUI_col_ky0 = 32; $GUI_col_we0 = 32; $GUI_col_as0 = 32;          	
	   BREAK;	   
	   DEFAULT:
	   BREAK;
  ENDSWITCH

  openPrivButton( "select_track_box_w",$GUI_origL+76,$GUI_origT-1,44,43,4,-1,16," " );
  openPrivButton( "select_track_box_b",$GUI_origL+77,$GUI_origT,42,41,4,-1,32," " );
  openPrivButton( "select_track_top_txt",$GUI_origL+77,$GUI_origT,42,6,5,-1,32,"Select Track" );
  openPrivButton( "select_track_bl",$GUI_origL+78,$GUI_origT+7,4,4,4,-1,$GUI_col_bl0,"BL" );
  openPrivButton( "select_track_BL1",$GUI_origL+82,$GUI_origT+7,4,4,4,-1,$GUI_col_bl[1],"1",select_track );
  openPrivButton( "select_track_BL2",$GUI_origL+86,$GUI_origT+7,4,4,4,-1,$GUI_col_bl[2],"2",select_track );
  openPrivButton( "select_track_BL3",$GUI_origL+90,$GUI_origT+7,4,4,4,-1,$GUI_col_bl[3],"3",select_track );   
  openPrivButton( "select_track_bl_rev",$GUI_origL+110,$GUI_origT+7,8,4,4,-1,$GUI_col_bl_rev,"Reverse",config_select_rev );
  openPrivButton( "select_track_so",$GUI_origL+78,$GUI_origT+11,4,4,4,-1,$GUI_col_so0,"SO" );
  openPrivButton( "select_track_SO1",$GUI_origL+82,$GUI_origT+11,4,4,4,-1,$GUI_col_so[1],"1",select_track );
  openPrivButton( "select_track_SO2",$GUI_origL+86,$GUI_origT+11,4,4,4,-1,$GUI_col_so[2],"2",select_track );
  openPrivButton( "select_track_SO3",$GUI_origL+90,$GUI_origT+11,4,4,4,-1,$GUI_col_so[3],"3",select_track );
  openPrivButton( "select_track_SO4",$GUI_origL+94,$GUI_origT+11,4,4,4,-1,$GUI_col_so[4],"4",select_track );
  openPrivButton( "select_track_SO5",$GUI_origL+98,$GUI_origT+11,4,4,4,-1,$GUI_col_so[5],"5",select_track );
  openPrivButton( "select_track_SO6",$GUI_origL+102,$GUI_origT+11,4,4,4,-1,$GUI_col_so[6],"6",select_track );
  openPrivButton( "select_track_so_rev",$GUI_origL+110,$GUI_origT+11,8,4,4,-1,$GUI_col_so_rev,"Reverse",config_select_rev );
  openPrivButton( "select_track_fe",$GUI_origL+78,$GUI_origT+15,4,4,4,-1,$GUI_col_fe0,"FE" );
  openPrivButton( "select_track_FE1",$GUI_origL+82,$GUI_origT+15,4,4,4,-1,$GUI_col_fe[1],"1",select_track );
  openPrivButton( "select_track_FE2",$GUI_origL+86,$GUI_origT+15,4,4,4,-1,$GUI_col_fe[2],"2",select_track );
  openPrivButton( "select_track_FE3",$GUI_origL+90,$GUI_origT+15,4,4,4,-1,$GUI_col_fe[3],"3",select_track );
  openPrivButton( "select_track_FE4",$GUI_origL+94,$GUI_origT+15,4,4,4,-1,$GUI_col_fe[4],"4",select_track );
  openPrivButton( "select_track_FE5",$GUI_origL+98,$GUI_origT+15,4,4,4,-1,$GUI_col_fe[5],"5",select_track );
  openPrivButton( "select_track_FE6",$GUI_origL+102,$GUI_origT+15,4,4,4,-1,$GUI_col_fe[6],"6",select_track );
  openPrivButton( "select_track_fe_rev",$GUI_origL+110,$GUI_origT+15,8,4,4,-1,$GUI_col_fe_rev,"Reverse",config_select_rev );
  openPrivButton( "select_track_ky",$GUI_origL+78,$GUI_origT+19,4,4,4,-1,$GUI_col_ky0,"KY" );
  openPrivButton( "select_track_KY1",$GUI_origL+82,$GUI_origT+19,4,4,4,-1,$GUI_col_ky[1],"1",select_track );
  openPrivButton( "select_track_KY2",$GUI_origL+86,$GUI_origT+19,4,4,4,-1,$GUI_col_ky[2],"2",select_track );
  openPrivButton( "select_track_KY3",$GUI_origL+90,$GUI_origT+19,4,4,4,-1,$GUI_col_ky[3],"3",select_track );
  openPrivButton( "select_track_ky_rev",$GUI_origL+110,$GUI_origT+19,8,4,4,-1,$GUI_col_ky_rev,"Reverse",config_select_rev );
  openPrivButton( "select_track_we",$GUI_origL+78,$GUI_origT+23,4,4,4,-1,$GUI_col_we0,"WE" );
  openPrivButton( "select_track_WE1",$GUI_origL+82,$GUI_origT+23,4,4,4,-1,$GUI_col_we[1],"1",select_track );
  openPrivButton( "select_track_we_rev",$GUI_origL+110,$GUI_origT+23,8,4,4,-1,$GUI_col_we_rev,"Reverse",config_select_rev );
  openPrivButton( "select_track_as",$GUI_origL+78,$GUI_origT+27,4,4,4,-1,$GUI_col_as0,"AS" );
  openPrivButton( "select_track_AS1",$GUI_origL+82,$GUI_origT+27,4,4,4,-1,$GUI_col_as[1],"1",select_track );
  openPrivButton( "select_track_AS2",$GUI_origL+86,$GUI_origT+27,4,4,4,-1,$GUI_col_as[2],"2",select_track );
  openPrivButton( "select_track_AS3",$GUI_origL+90,$GUI_origT+27,4,4,4,-1,$GUI_col_as[3],"3",select_track );
  openPrivButton( "select_track_AS4",$GUI_origL+94,$GUI_origT+27,4,4,4,-1,$GUI_col_as[4],"4",select_track );
  openPrivButton( "select_track_AS5",$GUI_origL+98,$GUI_origT+27,4,4,4,-1,$GUI_col_as[5],"5",select_track );
  openPrivButton( "select_track_AS6",$GUI_origL+102,$GUI_origT+27,4,4,4,-1,$GUI_col_as[6],"6",select_track );
  openPrivButton( "select_track_AS7",$GUI_origL+106,$GUI_origT+27,4,4,4,-1,$GUI_col_as[7],"7",select_track );
  openPrivButton( "select_track_as_rev",$GUI_origL+110,$GUI_origT+27,8,4,4,-1,$GUI_col_as_rev,"Reverse",config_select_rev );
  openPrivButton( "select_track_AU1",$GUI_origL+78,$GUI_origT+31,10,4,4,-1,$GUI_col_au[1],"Auto Cross",select_track );
  openPrivButton( "select_track_AU2",$GUI_origL+88,$GUI_origT+31,10,4,4,-1,$GUI_col_au[2]," Skid Pad ",select_track );
  openPrivButton( "select_track_AU3",$GUI_origL+98,$GUI_origT+31,10,4,4,-1,$GUI_col_au[3],"Drag 2 lane",select_track );
  openPrivButton( "select_track_AU4",$GUI_origL+108,$GUI_origT+31,10,4,4,-1,$GUI_col_au[4],"Drag 8 lane",select_track );
  openPrivButton( "set_track",$GUI_origL+78,$GUI_origT+36,10,4,4,-1,16,"^0SET TRACK",config_end_race );   
EndSub

Sub select_track( $KeyFlags,$id )
  $GUI_current_track = trim( subStr( $id,13 ) );
  $GUI_track_label = substr( $GUI_current_track,0,2 );
  $GUI_cur_tracknumber =ToNum(substr( $GUI_current_track,2,1 ));
  config_select_track(0,0);
EndSub
 
Sub config_select_rev( $KeyFlags,$id )
	IF(  $GUI_track_rev == "R" )
	THEN
  	  $GUI_track_rev = "" ;
	ELSE
  	  $GUI_track_rev = "R" ;
	ENDIF
  config_select_track(0,0);
EndSub

Sub config_end_race( $KeyFlags,$id )
  openPrivButton( "end_box",$GUI_origL+46,$GUI_origT+22,28,10,4,-1,32," " );
  openPrivButton( "end",$GUI_origL+47,$GUI_origT+23,26,4,4,-1,32,"Race END before the Track Changed" );
  openPrivButton( "end_yes",$GUI_origL+47,$GUI_origT+27,13,4,4,-1,16,"Change Track Now",config_end_track );
  openPrivButton( "end_no",$GUI_origL+61,$GUI_origT+27,12,4,4,-1,16,"Cancel",config_end_no );
EndSub

Sub config_end_no( $KeyFlags,$id )
  closePrivButton("end_box&end&end_yes&end_no");
EndSub

Sub config_end_track( $KeyFlags,$id )
  cmdLFS("/end");
  closePrivButton("end_box&end&end_yes&end_no");
  closePrivButton("end2_box&end2&end2_yes");
  TextPrivButton( "current_track", . $GUI_current_track );
  openGlobalButton ("test",$GUI_origL+45,$GUI_origT+32,28,6,4,6,16,"^7Track will be changed in (%cpt%) second(s)");
	DelayedCommand( 6, change_track );
EndSub

Sub change_track()
	cmdLFS( "/track " . $GUI_current_track . $GUI_track_rev );
EndSub

#########################
# Select Car's          #
#########################

Sub config_select_plusmin( $KeyFlags,$id )
  IF( $GUI_current_car == "?" || $GUI_current_car == "" )
  THEN
    PrivMsg("^1Pick a Car first before enter a ^2+ ^1or ^2-");
  ELSE
    $GUI_set_plusmin = trim( subStr( $id,11 ) );
    $GUI_last_char_check = trim( subStr( $GUI_current_car,StrLen($GUI_current_car) - 1 ) );
    IF( $GUI_last_char_check == "+" || $GUI_last_char_check == "-")
    THEN
      PrivMsg("^1Next car needed.");
    ELSE
      $GUI_current_car=$GUI_current_car . $GUI_set_plusmin;
    ENDIF      
  ENDIF   
  config_select_temp(0,0);
EndSub

Sub config_select_car( $KeyFlags,$id )
  IF($GUI_current_car == "?" )
  THEN
    $GUI_current_car = "" ;
  ENDIF
  $GUI_set_car = trim( subStr( $id,11 ) );
  IF($GUI_current_car == "" )
  THEN
    $GUI_current_car=$GUI_current_car . $GUI_set_car;
  ELSE
    $GUI_last_char_check = trim( subStr( $GUI_current_car,StrLen($GUI_current_car) - 1 ) );  
    IF( $GUI_last_char_check == "+" || $GUI_last_char_check == "-")
    THEN
      $GUI_current_car=$GUI_current_car . $GUI_set_car;
    ELSE
      PrivMsg("^1a ^2+ ^1or ^2- ^1is needed before selecting the next car."); 
    ENDIF
  ENDIF  
  config_select_temp(0,0);  
EndSub

Sub config_select_temp( $KeyFlags,$id )
  TextPrivButton( "select_car_string", . $GUI_current_car );
EndSub

Sub config_select_clear( $KeyFlags,$id )
  $GUI_current_car = "" ;
  config_select_temp(0,0);   
EndSub

Sub set_car( $KeyFlags,$id )
  IF($GUI_current_car == "" )
  THEN
    PrivMsg("^1No car is seleced.");
  ELSE
    cmdLFS( "/cars " . $GUI_current_car );
    TextPrivButton( "current_car", . $GUI_current_car );
  ENDIF
EndSub

#########################
# set weather           #
#########################

Sub config_weather_0( $KeyFlags,$id )
  $GUI_weather=1;
  closePrivButton("weather_0&weather_1&weather_2");
  openPrivButton( "weather_0",$GUI_origL+18,$GUI_origT+55,12,4,4,-1,16,"Clear Day",config_weather_0 );
  openPrivButton( "weather_1",$GUI_origL+30,$GUI_origT+55,13,4,4,-1,32,"Cloudy Afternoon",config_weather_1 );
  openPrivButton( "weather_2",$GUI_origL+43,$GUI_origT+55,12,4,4,-1,32,"Cloudy sunset",config_weather_2 );
  cmdLFS( "/weather " . $GUI_weather );
EndSub

Sub config_weather_1( $KeyFlags,$id )
  $GUI_weather=2;
  closePrivButton("weather_0&weather_1&weather_2");
  openPrivButton( "weather_0",$GUI_origL+18,$GUI_origT+55,12,4,4,-1,32,"Clear Day",config_weather_0 );
  openPrivButton( "weather_1",$GUI_origL+30,$GUI_origT+55,13,4,4,-1,16,"Cloudy Afternoon",config_weather_1 );
  openPrivButton( "weather_2",$GUI_origL+43,$GUI_origT+55,12,4,4,-1,32,"Cloudy sunset",config_weather_2 );
  cmdLFS( "/weather " . $GUI_weather );
EndSub

Sub config_weather_2( $KeyFlags,$id )
  $GUI_weather=3;
  closePrivButton("weather_0&weather_1&weather_2");
  openPrivButton( "weather_0",$GUI_origL+18,$GUI_origT+55,12,4,4,-1,32,"Clear Day",config_weather_0 );
  openPrivButton( "weather_1",$GUI_origL+30,$GUI_origT+55,13,4,4,-1,32,"Cloudy Afternoon",config_weather_1 );
  openPrivButton( "weather_2",$GUI_origL+43,$GUI_origT+55,12,4,4,-1,16,"Cloudy sunset",config_weather_2 );
  cmdLFS( "/weather " . $GUI_weather );
EndSub

Sub config_start_0( $KeyFlags,$id )
  $GUI_start = "fixed";
  closePrivButton("start_0&start_1&start_2&start_3");
  openPrivButton( "start_0",$GUI_origL+18,$GUI_origT+63,8,4,4,-1,16,"Fixed",config_start_0 );
  openPrivButton( "start_1",$GUI_origL+26,$GUI_origT+63,8,4,4,-1,32,"Finish",config_start_1 );
  openPrivButton( "start_2",$GUI_origL+34,$GUI_origT+63,8,4,4,-1,32,"Reverse",config_start_2 );
  openPrivButton( "start_3",$GUI_origL+42,$GUI_origT+63,8,4,4,-1,32,"Random",config_start_3 );
  cmdLFS( "/start " . $GUI_start );
EndSub

Sub config_start_1( $KeyFlags,$id )
  $GUI_start = "finish";
  closePrivButton("start_0&start_1&start_2&start_3");
  openPrivButton( "start_0",$GUI_origL+18,$GUI_origT+63,8,4,4,-1,32,"Fixed",config_start_0 );
  openPrivButton( "start_1",$GUI_origL+26,$GUI_origT+63,8,4,4,-1,16,"Finish",config_start_1 );
  openPrivButton( "start_2",$GUI_origL+34,$GUI_origT+63,8,4,4,-1,32,"Reverse",config_start_2 );
  openPrivButton( "start_3",$GUI_origL+42,$GUI_origT+63,8,4,4,-1,32,"Random",config_start_3 );
  cmdLFS( "/start " . $GUI_start );
EndSub

Sub config_start_2( $KeyFlags,$id )
  $GUI_start = "reverse";
  closePrivButton("start_0&start_1&start_2&start_3");
  openPrivButton( "start_0",$GUI_origL+18,$GUI_origT+63,8,4,4,-1,32,"Fixed",config_start_0 );
  openPrivButton( "start_1",$GUI_origL+26,$GUI_origT+63,8,4,4,-1,32,"Finish",config_start_1 );
  openPrivButton( "start_2",$GUI_origL+34,$GUI_origT+63,8,4,4,-1,16,"Reverse",config_start_2 );
  openPrivButton( "start_3",$GUI_origL+42,$GUI_origT+63,8,4,4,-1,32,"Random",config_start_3 );
  cmdLFS( "/start " . $GUI_start );
EndSub

Sub config_start_3( $KeyFlags,$id )
  $GUI_start = "random";
  closePrivButton("start_0&start_1&start_2&start_3");
  openPrivButton( "start_0",$GUI_origL+18,$GUI_origT+63,8,4,4,-1,32,"Fixed",config_start_0 );
  openPrivButton( "start_1",$GUI_origL+26,$GUI_origT+63,8,4,4,-1,32,"Finish",config_start_1 );
  openPrivButton( "start_2",$GUI_origL+34,$GUI_origT+63,8,4,4,-1,32,"Reverse",config_start_2 );
  openPrivButton( "start_3",$GUI_origL+42,$GUI_origT+63,8,4,4,-1,16,"Random",config_start_3 );
  cmdLFS( "/start " . $GUI_start );
EndSub

Sub config_wind_0( $KeyFlags,$id )
  $GUI_wind=0;
  closePrivButton("wind_0&wind_1&wind_2");
  openPrivButton( "wind_0",$GUI_origL+18,$GUI_origT+47,8,4,4,-1,16,"Off",config_wind_0 );
  openPrivButton( "wind_1",$GUI_origL+26,$GUI_origT+47,8,4,4,-1,32,"Low",config_wind_1 );
  openPrivButton( "wind_2",$GUI_origL+34,$GUI_origT+47,8,4,4,-1,32,"High",config_wind_2 );
  cmdLFS( "/wind " . $GUI_wind );
EndSub

Sub config_wind_1( $KeyFlags,$id )
  $GUI_wind=1;
  closePrivButton("wind_0&wind_1&wind_2");
  openPrivButton( "wind_0",$GUI_origL+18,$GUI_origT+47,8,4,4,-1,32,"Off",config_wind_0 );
  openPrivButton( "wind_1",$GUI_origL+26,$GUI_origT+47,8,4,4,-1,16,"Low",config_wind_1 );
  openPrivButton( "wind_2",$GUI_origL+34,$GUI_origT+47,8,4,4,-1,32,"High",config_wind_2 );
  cmdLFS( "/wind " . $GUI_wind );
EndSub

Sub config_wind_2( $KeyFlags,$id )
  $GUI_wind=2;
  closePrivButton("wind_0&wind_1&wind_2");
  openPrivButton( "wind_0",$GUI_origL+18,$GUI_origT+47,8,4,4,-1,32,"Off",config_wind_0 );
  openPrivButton( "wind_1",$GUI_origL+26,$GUI_origT+47,8,4,4,-1,32,"Low",config_wind_1 );
  openPrivButton( "wind_2",$GUI_origL+34,$GUI_origT+47,8,4,4,-1,16,"High",config_wind_2 );
  cmdLFS( "/wind " . $GUI_wind );
EndSub

Sub config_fcv_yes( $KeyFlags,$id )
  $GUI_fcv="yes";
  closePrivButton("fcv_yes&fcv_no");
  openPrivButton( "fcv_yes",$GUI_origL+18,$GUI_origT+39,8,4,4,-1,16,"Yes",config_fcv_yes );
  openPrivButton( "fcv_no",$GUI_origL+26,$GUI_origT+39,8,4,4,-1,32,"No",config_fcv_no );
  cmdLFS( "/fcv " . $GUI_fcv );
EndSub

Sub config_fcv_no( $KeyFlags,$id )
  $GUI_fcv="no";
  closePrivButton("fcv_yes&fcv_no");
  openPrivButton( "fcv_yes",$GUI_origL+18,$GUI_origT+39,8,4,4,-1,32,"Yes",config_fcv_yes );
  openPrivButton( "fcv_no",$GUI_origL+26,$GUI_origT+39,8,4,4,-1,16,"No",config_fcv_no );
  cmdLFS( "/fcv " . $GUI_fcv );
EndSub

Sub config_midyes( $KeyFlags,$id )
  $GUI_midrace="yes";
  closePrivButton("mid_yes&mid_no");
  openPrivButton( "mid_yes",$GUI_origL+18,$GUI_origT+23,8,4,4,-1,16,"Yes",config_midyes );
  openPrivButton( "mid_no",$GUI_origL+26,$GUI_origT+23,8,4,4,-1,32,"No",config_midno );
  cmdLFS( "/midrace " . $GUI_midrace );
EndSub

Sub config_midno( $KeyFlags,$id )
  $GUI_midrace="no";
  closePrivButton("mid_yes&mid_no");
  openPrivButton( "mid_yes",$GUI_origL+18,$GUI_origT+23,8,4,4,-1,32,"Yes",config_midyes );
  openPrivButton( "mid_no",$GUI_origL+26,$GUI_origT+23,8,4,4,-1,16,"No",config_midno );
  cmdLFS( "/midrace " . $GUI_midrace );
EndSub

Sub config_qual_P1( $KeyFlags,$id )
  $GUI_qual=$GUI_qual+1;
  TextPrivButton( "qualvar", . $GUI_qual );  
  cmdLFS( "/qual " . $GUI_qual );
EndSub

Sub config_qual_M1( $KeyFlags,$id )
  $GUI_qual=$GUI_qual-1;
  TextPrivButton( "qualvar", . $GUI_qual );
  IF ( $GUI_qual <= 0 )
  THEN
    $GUI_qual=0;
    TextPrivButton( "qualvar","Off" );    
  ENDIF
  cmdLFS( "/qual " . $GUI_qual );
EndSub

Sub config_qual_P5( $KeyFlags,$id )
  $GUI_qual=$GUI_qual+5;
  TextPrivButton( "qualvar", . $GUI_qual );
  cmdLFS( "/qual " . $GUI_qual );
EndSub

Sub config_qual_M5( $KeyFlags,$id )
  $GUI_qual=$GUI_qual-5;
  TextPrivButton( "qualvar", . $GUI_qual );
  IF ( $GUI_qual <= 0 )
  THEN
    $GUI_qual=0;
    TextPrivButton( "qualvar","Off" );
  ENDIF
  cmdLFS( "/qual " . $GUI_qual );
EndSub

Sub config_lap_hour( $KeyFlags,$id )
  $GUI_Lap_hour=$id;
  TextPrivButton( "laps-hour", . $GUI_Lap_hour );
  IF ($GUI_Lap_hour == "laps")
  THEN
    $GUI_hour_temp = $GUI_Lap_hour_number ;
    $GUI_Lap_hour_number = $GUI_lap_temp;
    $GUI_col_laps = 16 ; $GUI_col_hours = 32 ;
  ELSE
    $GUI_lap_temp = $GUI_Lap_hour_number ;
    $GUI_Lap_hour_number = $GUI_hour_temp;  
    $GUI_col_laps = 32 ; $GUI_col_hours = 16 ;
  ENDIF
  openPrivButton( "laps",$GUI_origL+1,$GUI_origT+9,7,4,4,-1,$GUI_col_laps,"Laps",config_lap_hour );
	openPrivButton( "hours",$GUI_origL+1,$GUI_origT+13,7,4,4,-1,$GUI_col_hours,"Hours",config_lap_hour );
  TextPrivButton( "lapsvar", . $GUI_Lap_hour_number  );
  cmdLFS( "/" . $GUI_Lap_hour . " " . $GUI_Lap_hour_number );	    
EndSub
	
Sub config_lap_P1( $KeyFlags,$id )
  $GUI_Lap_hour_number=$GUI_Lap_hour_number+1;
  TextPrivButton( "lapsvar", . $GUI_Lap_hour_number );  
  cmdLFS( "/" . $GUI_Lap_hour . " " . $GUI_Lap_hour_number );
EndSub

Sub config_lap_M1( $KeyFlags,$id )
  $GUI_Lap_hour_number=$GUI_Lap_hour_number-1;
  TextPrivButton( "lapsvar", . $GUI_Lap_hour_number );
  IF ( $GUI_Lap_hour_number <= 1 && $GUI_Lap_hour =="hours" )
  THEN
    $GUI_Lap_hour_number=1;
  ENDIF  
  IF ( $GUI_Lap_hour_number <= 0 )
  THEN
    $GUI_Lap_hour_number=0;
    TextPrivButton( "lapsvar","Practice" );
  ENDIF
  cmdLFS( "/" . $GUI_Lap_hour . " " . $GUI_Lap_hour_number );
EndSub

Sub config_lap_P5( $KeyFlags,$id )
  $GUI_Lap_hour_number=$GUI_Lap_hour_number+5;
  TextPrivButton( "lapsvar", . $GUI_Lap_hour_number );
  cmdLFS( "/" . $GUI_Lap_hour . " " . $GUI_Lap_hour_number );
EndSub

Sub config_lap_M5( $KeyFlags,$id )
  $GUI_Lap_hour_number=$GUI_Lap_hour_number-5;
  TextPrivButton( "lapsvar", . $GUI_Lap_hour_number );
  IF ( $GUI_Lap_hour_number <= 0 )
    THEN
    $GUI_Lap_hour_number=0;
    TextPrivButton( "lapsvar","Practice" );
  ENDIF
  cmdLFS( "/" . $GUI_Lap_hour . " " . $GUI_Lap_hour_number );
EndSub

Sub config_pit_yes( $KeyFlags,$id )
  $GUI_mustpit="yes";
  closePrivButton("pit_yes&pit_no");
  openPrivButton( "pit_yes",$GUI_origL+18,$GUI_origT+31,8,4,4,-1,16,"Yes",config_pit_yes );
  openPrivButton( "pit_no",$GUI_origL+26,$GUI_origT+31,8,4,4,-1,32,"No",config_pit_no );
  cmdLFS( "/mustpit " . $GUI_mustpit );
EndSub

Sub config_pit_no( $KeyFlags,$id )
  $GUI_mustpit="no";
  closePrivButton("pit_yes&pit_no");
  openPrivButton( "pit_yes",$GUI_origL+18,$GUI_origT+31,8,4,4,-1,32,"Yes",config_pit_yes );
  openPrivButton( "pit_no",$GUI_origL+26,$GUI_origT+31,8,4,4,-1,16,"No",config_pit_no );
  cmdLFS( "/mustpit " . $GUI_mustpit );
EndSub


/*
### Copy and past this part in your in your LFSLapper.lpr to use the Drift Option in GUI ###

##################
#Drifting options#
##################
# This is the filepath for a file containing the collected data.
# This file will be created if it doesnt exist yet.
# You must ensure read/write access to this path.
#-------------------------------------------------------------------

$DriftDatabase = "./DriftPB";

# Actions to do on new personal best drift lap.

Event OnDriftPB()  # Player event
	IF( $GUI_drift == "yes" )
	THEN
	globalRcm( langEngine( "%{main_newdriftpb}%" , GetCurrentPlayerVar("Nickname"),GetCurrentPlayerVar("DriftScore") . " ^3pts!") );
	ENDIF
EndEvent

# Actions to do to when total lap drift score is higher or equal to MinimumDriftScore.

Event OnDriftLap() # Player event
	IF( $GUI_drift == "yes" )
	THEN
		globalMsg( langEngine( "%{main_driftlap}%" , GetCurrentPlayerVar("Nickname"), GetCurrentPlayerVar("DriftScore") ) );
	ENDIF
EndEvent

# Message to get on end of each drift.
# Possible variables to use:

Event OnDriftScore()
  $AngleVelocity = GetCurrentPlayerVar( "AngleVelocity" );
  $DriftScore = GetCurrentPlayerVar( "DriftScore" );
  $LastDriftScore = GetCurrentPlayerVar( "LastDriftScore" );
  IF( $GUI_drift == "yes" )
  THEN
    openPrivButton( "drf0",99,1,22,10,4,-1,16," " );
    IF( $AngleVelocity < 0 )
    THEN
      $AngleVelocity = -$AngleVelocity ;
      SetCurrentPlayerVar("Angle_drift",$AngleVelocity);
      openPrivButton( "drf1",100,2,20,4,4,-1,32,langEngine( "%{main_ondriftscorerev}%" , $DriftScore, $LastDriftScore ) );
      openPrivButton( "drf2",100,6,20,4,4,-1,32,langEngine( "%{main_driftanglerev}%" , GetCurrentPlayerVar( "Angle_drift")));
     ELSE
      openPrivButton( "drf1",100,2,20,4,4,-1,32,langEngine( "%{main_ondriftscore}%" , $DriftScore, $LastDriftScore ) );
      openPrivButton( "drf2",100,6,20,4,4,-1,32,langEngine( "%{main_driftangle}%" , $AngleVelocity ) );
    ENDIF
  ENDIF
EndEvent

$GoodDriftScore = 4000; # Value to be reached to execute action on good drift score

Event OnGoodDrift() # Player event
	IF( $GUI_drift == "yes" )
	THEN
		privMsg( langEngine( "%{main_ongooddrift}%" ,GetCurrentPlayerVar("Nickname"),GetCurrentPlayerVar("LastDriftScore") ) );
	ENDIF
EndEvent

#$MinimumDriftSpeed = 50; # Minimum speed in km/h to maintain. Driving below that speed will reset score
#$MinimumDriftAngle = 15; # Minimum angel to maintain. When angle is below value, score is reset
#$MaximumDriftAngle = 100; # Maximum angel to maintain. When angle is above value, score is reset



### ADD this part to the LFSLapper.lpr file ###
 Lang "EN"
 main_ondriftscore = "Score: ^7{0} ^3{1}";
 main_ondriftscorerev = "Score: ^7{0} ^2{1}";
 main_driftangle = "Drift Angle: ^7{0}  ^2>";
 main_driftanglerev = "Drift Angle: ^2< ^7{0}";
*/
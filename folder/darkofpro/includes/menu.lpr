####	MENU SYSTEM
####	=============
####
####	by Sinanju
####
####	An Add-On for LFSLapper V5.926 and later
####	(but preferably v6.011 *AND* CIF Modules)
####
####
####	Install this file into ..\bin\default\includes
####  then add
####  include( "./menu.lpr");
####
#######################################################
# Ver 1.0 - 19 March 2011 (Original release)
# Ver 1.1 - 4 April 2011 (got rid of couple of bugs)
#######################################################

####	You must have Krayy's CIF Modules, especially his HELP module working, else 'Sub DoMenuHelp' will not work
####	An alternative help section (which you can amend to suit) is included, but you will have to delete all the hash (#)
####	symbols from in front of all the lines of text starting from 'Sub' and ending 'EndSub', and you will have to delete
####	the first 'Sub DoMenuHelp' section

CatchEvent OnLapperStart()

### Set initial dialog coordinates & size for Menu items ###
	GlobalVar $MorigL; $MorigL = 86;	# Left edge of main content window / button / label
	GlobalVar $MorigT; $MorigT = 90;	# Top edge of window / button / label
	GlobalVar $MWidth; $MWidth = 20;	# Width of Dialog box / window / button / label
	GlobalVar $MHeight; $MHeight = 4;	# ...height of row of text
	GlobalVar $Mspacing; $Mspacing = 4;	# ...height of spacing between text
	GlobalVar $Mtime; $Mtime = -1;	# display button for how many seconds (-1 = permanent)
EndCatchEvent


CatchEvent OnConnect( $userName ) ### Load settings on connect (IdLang and UnitSpeedKmh) ### 
    $StoredIdLang = getUserStoredValue("IdLang"); 
    SetCurrentPlayerVar("IdLang",$StoredIdLang); 
     
    $StoredSpeedUnitKmh = getUserStoredValue("UnitSpeedKmh"); 
    SetCurrentPlayerVar("UnitSpeedKmh",$StoredSpeedUnitKmh); 
EndCatchEvent 


#####################################
#Action on teleport to pit (Shift+P)#
#####################################

# Actions to execute when player spectates or disconnects (leaves race).

CatchEvent OnLeaveRace( $userName )  # Player event
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_back_backing&menu_largeback&menu_largefront&menu_mainmenu&menu_menuabout&menu_menuback&menu_menuclose");
  closePrivButton("menu_menufun&menu_menuhelp&menu_menuoptions&menu_menuuser&menu_name&menu_smallback&menu_smallfront&menu_smallmenuclose");	
	closePrivButton("menu_funanimal&menu_funbird&menu_funcrustacean&menu_funfish&menu_funfruit&menu_funinsect&menu_funparrot&menu_funplanet");
  closePrivButton("menu_funrainbow&menu_funreptile&menu_funrodent&menu_funveg&menu_funsalad&menu_funsnake&menu_funwhale");	
  closePrivButton("menu_funanswer&menu_funanswer1&menu_funfantasy&menu_funnonspecific&menu_funquiz");
  closePrivButton("menu_langback&menu_langDutch&menu_langENchange&menu_langEnglish&menu_langFRchange&menu_langFrench");
  closePrivButton("menu_langItalian&menu_langITchange&menu_langNLchange&menu_langNOchange&menu_langNorway&menu_langtext");  
  closePrivButton("menu_bottomblurb1&menu_bottomblurb2&menu_bottomwindow&menu_closedrftop&menu_closedrftop1&menu_closetop&menu_closetop1");
  closePrivButton("menu_colour&menu_combostatsdetails&menu_combostatsname&menu_host&menu_speed_bg&menu_speed_title&menu_speedunitkph&menu_speedunitmph");	
  closePrivButton("menu_speedunittext&menu_topblurb1&menu_topblurb2&menu_topwindow&menu_usercombostats&menu_userdrifts&menu_userlfswstats&menu_userpbs&menu_usertops");	 	
  closePrivButton("menu_speedunittext&menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
  closePrivButton( "menu_closedrifttext&menu_closedrift&menu_closemarshalltext&menu_closemarshall" );
  closePrivButton("menu_pitboardtext&menu_pitboardoff&menu_pitboardchange");
	openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu);
EndCatchEvent


CatchEvent OnNewPlayerJoin( $userName )  # Player event

closePrivButton("menu_smallback&menu_smallfront&menu_host&menu_name");

EndCatchEvent


CatchEvent OnPit( $userName )  # Player teleported to pit ( Shift + P )
	closePrivButton("menu_back_backing&menu_largeback&menu_largefront&menu_mainmenu&menu_menuabout&menu_menuback&menu_menuclose");
  closePrivButton("menu_menufun&menu_menuhelp&menu_menuoptions&menu_menuuser&menu_name&menu_smallback&menu_smallfront&menu_smallmenuclose");	
	closePrivButton("menu_funanimal&menu_funbird&menu_funcrustacean&menu_funfish&menu_funfruit&menu_funinsect&menu_funparrot&menu_funplanet");
  closePrivButton("menu_funrainbow&menu_funreptile&menu_funrodent&menu_funveg&menu_funsalad&menu_funsnake&menu_funwhale");	
  closePrivButton("menu_funanswer&menu_funanswer1&menu_funfantasy&menu_funnonspecific&menu_funquiz");
  closePrivButton("menu_langback&menu_langDutch&menu_langENchange&menu_langEnglish&menu_langFRchange&menu_langFrench");
  closePrivButton("menu_langItalian&menu_langITchange&menu_langNLchange&menu_langNOchange&menu_langNorway&menu_langtext");  
  closePrivButton("menu_bottomblurb1&menu_bottomblurb2&menu_bottomwindow&menu_closedrftop&menu_closedrftop1&menu_closetop&menu_closetop1");
  closePrivButton("menu_colour&menu_combostatsdetails&menu_combostatsname&menu_host&menu_speed_bg&menu_speed_title&menu_speedunitkph&menu_speedunitmph");	
  closePrivButton("menu_speedunittext&menu_topblurb1&menu_topblurb2&menu_topwindow&menu_usercombostats&menu_userdrifts&menu_userlfswstats&menu_userpbs&menu_usertops");	
  closePrivButton( "menu_pitboardtext&menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
  closePrivButton("menu_speedunittext&menu_pitboardoff&menu_pitboardchange");
	closePrivButton( "menu_closedrifttext&menu_closedrift&menu_closemarshalltext&menu_closemarshall" );    
EndCatchEvent


CatchEvent OnExitPitLane(  $userName ) # Player event (This closes menu when you pass pitlane exit, otherwise you could have mouse cursor on screen as well as the menu)
	closePrivButton("menu_back_backing&menu_largeback&menu_largefront&menu_mainmenu&menu_menuabout&menu_menuback&menu_menuclose");
  closePrivButton("menu_menufun&menu_menuhelp&menu_menuoptions&menu_menuuser&menu_name&menu_smallback&menu_smallfront&menu_smallmenuclose");	
	closePrivButton("menu_funanimal&menu_funbird&menu_funcrustacean&menu_funfish&menu_funfruit&menu_funinsect&menu_funparrot&menu_funplanet");
  closePrivButton("menu_funrainbow&menu_funreptile&menu_funrodent&menu_funveg&menu_funsalad&menu_funsnake&menu_funwhale");	
  closePrivButton("menu_funanswer&menu_funanswer1&menu_funfantasy&menu_funnonspecific&menu_funquiz");
  closePrivButton("menu_langback&menu_langDutch&menu_langENchange&menu_langEnglish&menu_langFRchange&menu_langFrench");
  closePrivButton("menu_langItalian&menu_langITchange&menu_langNLchange&menu_langNOchange&menu_langNorway&menu_langtext");  
  closePrivButton("menu_bottomblurb1&menu_bottomblurb2&menu_bottomwindow&menu_closedrftop&menu_closedrftop1&menu_closetop&menu_closetop1");
  closePrivButton("menu_colour&menu_combostatsdetails&menu_combostatsname&menu_host&menu_speed_bg&menu_speed_title&menu_speedunitkph&menu_speedunitmph");	
  closePrivButton("menu_speedunittext&menu_topblurb1&menu_topblurb2&menu_topwindow&menu_usercombostats&menu_userdrifts&menu_userlfswstats&menu_userpbs&menu_usertops");	
  closePrivButton( "menu_pitboardtext&menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
  closePrivButton("menu_speedunittext&menu_pitboardoff&menu_pitboardchange");
	closePrivButton( "menu_closedrifttext&menu_closedrift&menu_closemarshalltext&menu_closemarshall" );    
EndCatchEvent


Sub DoMenu( $KeyFlags,$id )		#	This is the large menu with various selections available (Help, About, Fun, etc)
	closePrivButton("menu_back_backing&menu_largeback&menu_largefront&menu_mainmenu&menu_menuabout&menu_menuback&menu_menuclose");
  closePrivButton("menu_menufun&menu_menuhelp&menu_menuoptions&menu_menuuser&menu_name&menu_smallback&menu_smallfront&menu_smallmenuclose");	
	closePrivButton("menu_funanimal&menu_funbird&menu_funcrustacean&menu_funfish&menu_funfruit&menu_funinsect&menu_funparrot&menu_funplanet");
  closePrivButton("menu_funrainbow&menu_funreptile&menu_funrodent&menu_funveg&menu_funsalad&menu_funsnake&menu_funwhale");	
  closePrivButton("menu_funanswer&menu_funanswer1&menu_funfantasy&menu_funnonspecific&menu_funquiz");
  closePrivButton("menu_langback&menu_langDutch&menu_langENchange&menu_langEnglish&menu_langFRchange&menu_langFrench");
  closePrivButton("menu_langItalian&menu_langITchange&menu_langNLchange&menu_langNOchange&menu_langNorway&menu_langtext");  
  closePrivButton("menu_bottomblurb1&menu_bottomblurb2&menu_bottomwindow&menu_closedrftop&menu_closedrftop1&menu_closetop&menu_closetop1");
  closePrivButton("menu_colour&menu_combostatsdetails&menu_combostatsname&menu_host&menu_speed_bg&menu_speed_title&menu_speedunitkph&menu_speedunitmph");	
  closePrivButton("menu_speedunittext&menu_topblurb1&menu_topblurb2&menu_topwindow&menu_usercombostats&menu_userdrifts&menu_userlfswstats&menu_userpbs&menu_usertops");		   
 	closePrivButton( "menu_speedunittext&menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
  closePrivButton("menu_pitboardtext&menu_pitboardoff&menu_pitboardchange");
	closePrivButton( "menu_closedrifttext&menu_closedrift&menu_closemarshalltext&menu_closemarshall" );   	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_mainmenu",$MorigL+1,$MorigT+2,$MWidth+6,$MHeight+1,$Mspacing,$Mtime,0, langEngine("%{menu_mainmenu}%"));
	openPrivButton( "menu_menuuser",$MorigL+4,$MorigT+8,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_userswitchboard}%"),DoMenuSwitchboard);
	openPrivButton("menu_menuoptions",$MorigL+4,$MorigT+14,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_optionsname}%"),DoMenuOptions);
	openPrivButton( "menu_menuhelp",$MorigL+4,$MorigT+20,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_helpname}%"),DoMenuHelp);
	openPrivButton( "menu_menuabout",$MorigL+4,$MorigT+26,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_aboutname}%"),DoMenuAbout);
	openPrivButton( "menu_menufun",$MorigL+4,$MorigT+32,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_funname}%"),DoMenuFun);
	openPrivButton( "menu_menuclose",$MorigL+4,$MorigT+38,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_menuclose}%"),DoMainMenuClose);
EndSub
       

Sub DoMenuSwitchboard( $KeyFlags,$id )	#	This allows user to see PB's, etc
	closePrivButton( "menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
  openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
  openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );	
  openPrivButton( "menu_menuuser",$MorigL+1,$MorigT+2,$MWidth+6,$MHeight+1,$Mspacing,$Mtime,0, langEngine("%{menu_userswitchboard}%"));
	openPrivButton( "menu_userpbs",$MorigL+4,$MorigT+8,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_userpbs}%"),DoUserPBs);  
	openPrivButton( "menu_userlfswstats",$MorigL+4,$MorigT+14,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_userlfswstats}%"),DoUserStats);  
	openPrivButton( "menu_usercombostats",$MorigL+4,$MorigT+20,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_usercombostats}%"),DoUserComboStats);  
	openPrivButton( "menu_usertops",$MorigL+4,$MorigT+26,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_usertops}%"),DoUserTops);
	openPrivButton( "menu_userdrifts",$MorigL+4,$MorigT+32,$MWidth,$MHeight,$Mspacing,$Mtime,16, langEngine("%{menu_userdrifts}%"),DoUserDrifts);  
  openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
EndSub


Sub DoMenuOptions( $KeyFlags,$id )		#	This allows user to configure some of the settings and turn things off and on
	closePrivButton( "menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
  openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
  openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );	
  openPrivButton( "menu_menuoptions",$MorigL+1,$MorigT+1,$MWidth+6,$MHeight+1,$Mspacing,$Mtime,0,langEngine("%{menu_optionsname}%"));
  openPrivButton( "menu_langback",$MorigL+3,$MorigT+6,$MWidth+2,$MHeight+9,$Mspacing,$Mtime,16,"" );
  openPrivButton( "menu_langtext",$MorigL+4,$MorigT+6,$MWidth,$MHeight,$Mspacing,$Mtime,0,langEngine("%{menu_langtext}%"));
  openPrivButton("menu_langFrench",$MorigL+4,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7French",SetLang_fr);
  openPrivButton("menu_langDutch",$MorigL+11,$MorigT+13,6,$MHeight,$Mspacing,$Mtime,32,"^7Dutch",SetLang_nl);  
  openPrivButton("menu_langItalian",$MorigL+17,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7Italian",SetLang_it);
  openPrivButton("menu_langEnglish",$MorigL+4,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7English",SetLang_en);
  openPrivButton("menu_langNorway",$MorigL+14,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7Norvegian",SetLang_no);
 	openPrivButton( "menu_speedunittext",$MorigL+3,$MorigT+23,$MWidth+2,$MHeight,$Mspacing+2,$Mtime,80,langEngine("%{menu_speedunittext}%"));	
  openPrivButton( "menu_speedunitkph",$MorigL+19,$MorigT+23,5,$MHeight,3,$Mtime,32,"^7KPH",SetSpeedkph); 
  openPrivButton( "menu_speedunitmph",$MorigL+13,$MorigT+23,5,$MHeight,3,$Mtime,32,"^7MPH",SetSpeedmph);
  openPrivButton( "menu_pitboardtext",$MorigL+3,$MorigT+27,$MWidth+2,$MHeight,$Mspacing+2,$Mtime,80,langEngine("%{menu_pitboardtext}%"));	
  openPrivButton( "menu_pitboardoff",$MorigL+19,$MorigT+27,5,$MHeight,3,$Mtime,32,"^7Close",SetPBClose); 
  openPrivButton( "menu_pitboardchange",$MorigL+13,$MorigT+27,5,$MHeight,3,$Mtime,32,"^7Config",SetPBConfig);
  openPrivButton( "menu_closedrifttext",$MorigL+3,$MorigT+31,$MWidth+2,$MHeight,$Mspacing+2,$Mtime,80,langEngine("%{menu_closedrifttext}%") );  
	openPrivButton( "menu_closedrift",$MorigL+13,$MorigT+31,11,$MHeight,3,$Mtime,32,"^7Close", CloseDrift );
  openPrivButton( "menu_closemarshalltext",$MorigL+3,$MorigT+35,$MWidth+2,$MHeight,$Mspacing+2,$Mtime,80,langEngine("%{menu_closemarshalltext}%"));  
	openPrivButton( "menu_closemarshall",$MorigL+13,$MorigT+35,11,$MHeight,3,$Mtime,32,"^7Close",CloseMarshall );     
  openPrivButton("menu_menuback",$MorigL+3,$MorigT+39,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton("menu_smallmenuclose",$MorigL+15,$MorigT+39,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
EndSub




####	Turn off Marshalls
Sub CloseMarshall( $KeyFlags,$id )
	SetCurrentPlayerVar( "$marshall_on_off","off" ); # Set marshall "off"
	closePrivButton( "menu_closemarshall" );
	openPrivButton( "menu_closemarshall",$MorigL+13,$MorigT+35,11,$MHeight,3,$Mtime,32,"^6Close",CloseMarshall );   	
	closePrivButton( "m_instruct&m_instruct1&hide_marshall&notohide_marshall" );
	closePrivButton( "paintball_warning&blank_back&warning&warning1&info&impressive&remember&warning_message1&adjective" );
	closePrivButton( "manhand1&manhand1a&manarm1&manarm1a&head1&head1a&white_band&marshall_hat&yellow_trim&earA&earB&earA1&earB1&eyeA&eyeB&mouth" );
	closePrivButton( "yellow_flag1a&yellow_flag2a&yellow_flag3a&yellow_flag4a&yellow_flag5a&yellow_flag6a&yellow_flag7a&yellow_flag8a&yellow_flag9a" );
	closePrivButton( "manarm&manarma&manarm7&manarm7a&manlines&man8&manlines1&clogo&manlogo&manll1&manll2&manrl1&manrl2&manlf&manrf&shorts1&shorts2" );
EndSub



####	Turn off Driftmeter
Sub CloseDrift( $KeyFlags,$id )
	$GUI_drift="no";
	closePrivButton("dminstruct&dminstruct1&yes_to_drift&no_to_drift" );
	closePrivButton("statsbacking&statstitle&statsdetails&qualdetails&closestats&mylogo&sinrslogo&driftboxback");
	closePrivButton("driftanglebox&driftcombbox&driftscorebox&driftangleboxtext&driftcomboboxtext&driftscoreboxtext&driftcomboboxtexttop");
	closePrivButton("closedrftop&closedrftop1&help&help2&close&drfback_button&drf_rubbish_button&drfnear_button&drf_rubbish_button");
	closePrivButton("19_36_button&37_54_button&55_72_button&73_90_button&91_108_button&199_216_button&217_234_button&271_289_button&290_307_button");
	closePrivButton("109_126_button&127_144_button&145_162_button&163_180_button&181_198_button&235_252_button&253_270_button");
	closePrivButton("driftcomboboxtexttopmessage&driftcomboboxtexttopmessage0&driftcomboboxtexttopmessage1&driftcomboboxtexttopmessage2");
	closePrivButton("driftangleboxtextanglerev&driftanglerev&driftscoretextrev&driftcombotextrev");
	closePrivButton("driftangleboxtextangle&driftangle&driftscoretext&driftcombotext&drftop_button");
	closePrivButton("TDSM0&TDSM&TDSM1&TDSM2&TDSM3&TDSM4&TDSM5&TDSM6&TDSM7&TDSM8&TDSM9" );
	closePrivButton("TDSLL&TDSLL1&TDSLL2&TDSLL3&TDSLL4&TDSLL5&TDSLL6&TDSLL7&TDSLL8&TDSLL9" );
	closePrivButton("TDSRL&TDSLR1&TDSLR2&TDSLR3&TDSLR4&TDSLR5&TDSLR6&TDSLR7&TDSLR8&TDSLR9" );
	closePrivButton("TDS11&TDS12&TDS13&TDS14&TDS15&TDS21&TDS22&TDS23&TDS24&TDS25&TDS31&TDS32&TDS33&TDS34&TDS35" );
	closePrivButton("TDS41&TDS42&TDS43&TDS44&TDS45&TDS51&TDS52&TDS53&TDS54&TDS55&TDS61&TDS62&TDS63&TDS64&TDS65" );
	closePrivButton("TDS71&TDS72&TDS73&TDS74&TDS75&TDS81&TDS82&TDS83&TDS84&TDS85&TDS91&TDS92&TDS93&TDS94&TDS95" );
	closePrivButton("TDS01&TDS02&TDS03&TDS04&TDS05&main_driftadequate" );
	closePrivButton( "drift399&drift400&drift500&drift1000&drift2000&drift5000&drift10000&drift15000&drift20000&drift30000" );
	closePrivButton("driftmeter_TDS01&driftmeter_TDS02&driftmeter_TDS03&driftmeter_TDS04&driftmeter_TDS05&driftmeter_TDS11&driftmeter_TDS12&driftmeter_TDS13" );
	closePrivButton("driftmeter_TDS21&driftmeter_TDS22&driftmeter_TDS23&driftmeter_TDS24&driftmeter_TDS25&driftmeter_TDS31&driftmeter_TDS32&driftmeter_TDS335" );
	closePrivButton("driftmeter_TDS14&driftmeter_TDS15&driftmeter_TDS34&driftmeter_TDS3&driftmeter_TDS41&driftmeter_TDS42&driftmeter_TDS43&driftmeter_TDS44" );
	closePrivButton("driftmeter_TDS45&driftmeter_TDS51&driftmeter_TDS52driftmeter_TDS53&driftmeter_TDS54&driftmeter_TDS55&driftmeter_TDS61&driftmeter_TDS62" );
	closePrivButton("driftmeter_TDS63&driftmeter_TDS64&driftmeter_TDS65&driftmeter_TDS71&driftmeter_TDS72&driftmeter_TDS73&driftmeter_TDS74&driftmeter_TDS75" );
	closePrivButton("driftmeter_TDS81&driftmeter_TDS82&driftmeter_TDS83&driftmeter_TDS84&driftmeter_TDS85&driftmeter_TDS91&driftmeter_TDS92&driftmeter_TDS93" );
	closePrivButton("driftmeter_TDS94&driftmeter_TDS95&driftmeter_TDSM&driftmeter_TDSM0&driftmeter_TDSM1&driftmeter_TDSM2&driftmeter_TDSM3&driftmeter_TDSM4" );
	closePrivButton("driftmeter_TDSM5&driftmeter_TDSM6&driftmeter_TDSM7&driftmeter_TDSM8&driftmeter_TDSM9&driftmeter_driftbarelyadequate&driftmeter_driftadequate" );
	closePrivButton("driftmeter_driftgood&driftmeter_driftsuperb&driftmeter_driftoutrageous&driftmeter_driftinsane&driftmeter_driftroyalty&driftmeter_driftgod" );
	closePrivButton("driftmeter_driftnotworthy&driftmeter_mylogo&driftmeter_driftanglebox&driftmeter_driftangleboxtext&driftmeter_driftangleboxtextangle" );
	closePrivButton("driftmeter_driftanglerevboxp&driftmeter_driftcombotext&driftmeter_driftcomboboxtext&driftmeter_driftcomboboxtextto" );
	closePrivButton("driftmeter_driftcomboboxtexttopmessage&driftmeter_driftcomboboxtexttopmessage2&driftmeter_driftscoretext&driftmeter_driftscoreboxtext" );
	closePrivButton("driftmeter_drifttolow&driftmeter_driftlap&driftmeter_newdriftpb&driftmeter_ongooddrift" );
	closePrivButton( "dminstruct&dminstruct1&yes_to_drift&no_to_drift&circledrift_notscore" );
	closePrivButton( "circledrift_back&circledrift_back1&circledrift_thisdrift&circledrift_lastdriftscore&circledrift_lapscore");
	closePrivButton( "circledrift_notangle&circledrift_notanglerev&circledrift_maxscore&circledrift_anglerev&circledrift_angle");
	closePrivButton( "ds_back&ds_frnt&ds_name&ds_oads_label&ds_alsk_label&ds_alsm_label&ds_sltm_label&ds_dssr_labe&ds_sbox");
	closePrivButton( "ds_oads&ds_alsk&ds_alsm&ds_sltm&ds_dssr&ds_back2&ds_back3&ds_dssr_label2&ds_dssr2&main_ds_msg&main_ds_worse&main_ds_better");
	closePrivButton( "driftcomboboxtexttopmessage0&driftcomboboxtexttopmessage&driftcomboboxtexttopmessage1" );
	closePrivButton("menu_closedrift");
  openPrivButton( "menu_closedrift",$MorigL+13,$MorigT+31,11,$MHeight,3,$Mtime,32,"^6Close", CloseDrift );

EndSub


####	Set Language Section	####
 
Sub SetLang_en($KeyFlags,$userName) 
    SetCurrentPlayerVar("IdLang","en");
    setUserStoredValue("IdLang","en");
    closePrivButton("menu_langEnglish&menu_langNorway&menu_langItalian&menu_langDutch&menu_langFrench");
    closePrivButton("menu_langENchange&menu_langNOchange&menu_langITchange&menu_langNLchange&menu_langFRchange");
    closePrivButton("menu_speedkphchange&menu_speedmphchange");   
  openPrivButton("menu_langFrench",$MorigL+4,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7French",SetLang_fr);
  openPrivButton("menu_langDutch",$MorigL+11,$MorigT+13,6,$MHeight,$Mspacing,$Mtime,32,"^7Dutch",SetLang_nl);  
  openPrivButton("menu_langItalian",$MorigL+17,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7Italian",SetLang_it);
  openPrivButton("menu_langEnglish",$MorigL+4,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^6English",SetLang_en);
  openPrivButton("menu_langNorway",$MorigL+14,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7Norvegian",SetLang_no);
    openPrivButton("menu_langENchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_langENchange}%"));        
EndSub


Sub SetLang_no($KeyFlags,$userName) 
    SetCurrentPlayerVar("IdLang","no"); 
    setUserStoredValue("IdLang","no");
    closePrivButton("menu_langEnglish&menu_langNorway&menu_langItalian&menu_langDutch&menu_langFrench");
    closePrivButton("menu_langENchange&menu_langNOchange&menu_langITchange&menu_langNLchange&menu_langFRchange");
    closePrivButton("menu_speedkphchange&menu_speedmphchange");        
  openPrivButton("menu_langFrench",$MorigL+4,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7French",SetLang_fr);
  openPrivButton("menu_langDutch",$MorigL+11,$MorigT+13,6,$MHeight,$Mspacing,$Mtime,32,"^7Dutch",SetLang_nl);  
  openPrivButton("menu_langItalian",$MorigL+17,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7Italian",SetLang_it);
  openPrivButton("menu_langEnglish",$MorigL+4,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7English",SetLang_en);
  openPrivButton("menu_langNorway",$MorigL+14,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^6Norvegian",SetLang_no);
    openPrivButton("menu_langNOchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_langNOchange}%"));    
EndSub


Sub SetLang_it($KeyFlags,$userName) 
    SetCurrentPlayerVar("IdLang","it");
    setUserStoredValue("IdLang","it");  
    closePrivButton("menu_langEnglish&menu_langNorway&menu_langItalian&menu_langDutch&menu_langFrench");
    closePrivButton("menu_langENchange&menu_langNOchange&menu_langITchange&menu_langNLchange&menu_langFRchange");
    closePrivButton("menu_speedkphchange&menu_speedmphchange");    
  openPrivButton("menu_langFrench",$MorigL+4,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7French",SetLang_fr);
  openPrivButton("menu_langDutch",$MorigL+11,$MorigT+13,6,$MHeight,$Mspacing,$Mtime,32,"^7Dutch",SetLang_nl);  
  openPrivButton("menu_langItalian",$MorigL+17,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^6Italian",SetLang_it);
  openPrivButton("menu_langEnglish",$MorigL+4,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7English",SetLang_en);
  openPrivButton("menu_langNorway",$MorigL+14,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7Norvegian",SetLang_no);
    openPrivButton("menu_langITchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_langITchange}%"));      
EndSub 


Sub SetLang_nl($KeyFlags,$userName) 
    SetCurrentPlayerVar("IdLang","nl"); 
    setUserStoredValue("IdLang","nl"); 
    closePrivButton("menu_langEnglish&menu_langNorway&menu_langItalian&menu_langDutch&menu_langFrench");
    closePrivButton("menu_langENchange&menu_langNOchange&menu_langITchange&menu_langNLchange&menu_langFRchange");
    closePrivButton("menu_speedkphchange&menu_speedmphchange");    
  openPrivButton("menu_langFrench",$MorigL+4,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7French",SetLang_fr);
  openPrivButton("menu_langDutch",$MorigL+11,$MorigT+13,6,$MHeight,$Mspacing,$Mtime,32,"^6Dutch",SetLang_nl);  
  openPrivButton("menu_langItalian",$MorigL+17,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7Italian",SetLang_it);
  openPrivButton("menu_langEnglish",$MorigL+4,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7English",SetLang_en);
  openPrivButton("menu_langNorway",$MorigL+14,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7Norvegian",SetLang_no);
    openPrivButton("menu_langNLchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_langNLchange}%"));
EndSub


Sub SetLang_fr($KeyFlags,$userName) 
    SetCurrentPlayerVar("IdLang","fr");
    setUserStoredValue("IdLang","fr");  
    closePrivButton("menu_langEnglish&menu_langNorway&menu_langItalian&menu_langDutch&menu_langFrench");
    closePrivButton("menu_langENchange&menu_langNOchange&menu_langITchange&menu_langNLchange&menu_langFRchange");
    closePrivButton("menu_speedkphchange&menu_speedmphchange");    
  openPrivButton("menu_langFrench",$MorigL+4,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^6French",SetLang_fr);
  openPrivButton("menu_langDutch",$MorigL+11,$MorigT+13,6,$MHeight,$Mspacing,$Mtime,32,"^7Dutch",SetLang_nl);  
  openPrivButton("menu_langItalian",$MorigL+17,$MorigT+13,7,$MHeight,$Mspacing,$Mtime,32,"^7Italian",SetLang_it);
  openPrivButton("menu_langEnglish",$MorigL+4,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7English",SetLang_en);
  openPrivButton("menu_langNorway",$MorigL+14,$MorigT+9,10,$MHeight,$Mspacing,$Mtime,32,"^7Norvegian",SetLang_no);
    openPrivButton("menu_langFRchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_langFRchange}%")); 
EndSub

####	Change MPH/KPH

Sub SetSpeedkph($KeyFlags,$userName)
 #		UnitSpeedKmh	// unit used for speed and distance: 1 = kms 0 = miles  ( Can be SET )
 
    SetCurrentPlayerVar("UnitSpeedKmh","1");
    setUserStoredValue("UnitSpeedKmh","1"); 
    closePrivButton("menu_langENchange&menu_langNOchange&menu_langITchange&menu_langNLchange&menu_langFRchange");
    closePrivButton("menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
    openPrivButton( "menu_speedunitkph",$MorigL+19,$MorigT+23,5,$MHeight,3,$Mtime,32,"^6KPH",SetSpeedkph );
    openPrivButton( "menu_speedunitmph",$MorigL+13,$MorigT+23,5,$MHeight,3,$Mtime,32,"^7MPH",SetSpeedmph ); 
    openPrivButton("menu_speedkphchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_speedkphchange}%"));
EndSub
                   
  
Sub SetSpeedmph($KeyFlags,$userName)
#		UnitSpeedKmh	// unit used for speed and distance: 1 = kms 0 = miles  ( Can be SET )

    SetCurrentPlayerVar("UnitSpeedKmh","0");
    setUserStoredValue("UnitSpeedKmh","0");
    closePrivButton("menu_langENchange&menu_langNOchange&menu_langITchange&menu_langNLchange&menu_langFRchange");
    closePrivButton("menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
    openPrivButton( "menu_speedunitkph",$MorigL+19,$MorigT+23,5,$MHeight,3,$Mtime,32,"^7KPH",SetSpeedkph );
    openPrivButton( "menu_speedunitmph",$MorigL+13,$MorigT+23,5,$MHeight,3,$Mtime,32,"^6MPH",SetSpeedmph ); 
    openPrivButton("menu_speedmphchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_speedmphchange}%"));
EndSub

#   Pitboard 
Sub SetPBClose($KeyFlags,$userName) # Close Pitboard

    closePrivButton("menu_pitboardoff&menu_pitboardchange");
    openPrivButton( "menu_pitboardoff",$MorigL+19,$MorigT+27,5,$MHeight,3,$Mtime,32,"^6Close",SetPBClose); 
    openPrivButton( "menu_pitboardchange",$MorigL+13,$MorigT+27,5,$MHeight,3,$Mtime,32,"^7Config",SetPBConfig);
    openPrivButton("menu_speedmphchange",$MorigL+3,$MorigT+19,$MWidth+2,$MHeight,$Mspacing,6,32,langEngine("%{menu_pitboardclosed}%")); 
			IF ( $enable_pitboard == "true" )
			THEN
			  close_pitboard( $KeyFlags );
			  OnConnectClose_Pitboard();
			ENDIF
	    closePrivButton( "pitboard_current_sector_1_txt&pitboard_last_sector_1_txt&pitboard_best_sector_1_txt");
	    closePrivButton( "pitboard_current_sector_1&pitboard_last_sector_1&pitboard_best_sector_1" );
	    closePrivButton( "pitboard_before_sector_1&pitboard_behind_sector_1" );
	    closePrivButton( "pitboard_current_sector_2_txt&pitboard_last_sector_2_txt&pitboard_best_sector_2_txt");
	    closePrivButton( "pitboard_current_sector_2&pitboard_last_sector_2&pitboard_best_sector_2" );
	    closePrivButton( "pitboard_before_sector_2&pitboard_behind_sector_2");
	    closePrivButton( "pitboard_current_sector_3_txt&pitboard_last_sector_3_txt&pitboard_best_sector_3_txt");
	    closePrivButton( "pitboard_current_sector_3&pitboard_last_sector_3&pitboard_best_sector_3" );
	    closePrivButton( "pitboard_before_sector_3&pitboard_behind_sector_3");
	    closePrivButton( "pitboard_current_sector_last_txt&pitboard_last_sector_last_txt&pitboard_best_sector_last_txt");
	    closePrivButton( "pitboard_current_sector_last&pitboard_last_sector_last&pitboard_best_sector_last" );
	    closePrivButton( "pitboard_before_sector_last&pitboard_behind_sector_last" );
	    closePrivButton( "pitboard_information&pitboard_information_2" );
	    closePrivButton( "pitboard_safetycar_message_1&pitboard_safetycar_message_2&pitboard_safetycar_message_3" );
	    closePrivButton( "pitboard_safetycar_bg&pitboard_txt&pitboard_total" );
	    closePrivButton( "pitboard_start_pitwindow_lap&pitboard_end_pitwindow_lap&pitboard_number_of_stops&pitboard_start_pitwindow&pitboard_end_pitwindow" );
	    closePrivButton( "pitboard_no_pitwindow&pitboard_pw_stops");			
EndSub


Sub SetPBConfig($KeyFlags,$userName )  # Configure Pitboard Settings
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_back_backing&menu_largeback&menu_largefront&menu_mainmenu&menu_menuabout&menu_menuback&menu_menuclose");
  closePrivButton("menu_menufun&menu_menuhelp&menu_menuoptions&menu_menuuser&menu_name&menu_host&menu_smallback&menu_smallfront&menu_smallmenuclose");	
	closePrivButton("menu_funanimal&menu_funbird&menu_funcrustacean&menu_funfish&menu_funfruit&menu_funinsect&menu_funparrot&menu_funplanet");
  closePrivButton("menu_funrainbow&menu_funreptile&menu_funrodent&menu_funveg&menu_funsalad&menu_funsnake&menu_funwhale");	
  closePrivButton("menu_funanswer&menu_funanswer1&menu_funfantasy&menu_funnonspecific&menu_funquiz");
  closePrivButton("menu_langback&menu_langDutch&menu_langENchange&menu_langEnglish&menu_langFRchange&menu_langFrench");
  closePrivButton("menu_langItalian&menu_langITchange&menu_langNLchange&menu_langNOchange&menu_langNorway&menu_langtext");  
  closePrivButton("menu_bottomblurb1&menu_bottomblurb2&menu_bottomwindow&menu_closedrftop&menu_closedrftop1&menu_closetop&menu_closetop1");
  closePrivButton("menu_colour&menu_combostatsdetails&menu_combostatsname&menu_speed_bg&menu_speed_title&menu_speedunitkph&menu_speedunitmph");	
  closePrivButton("menu_speedunittext&menu_topblurb1&menu_topblurb2&menu_topwindow&menu_usercombostats&menu_userdrifts&menu_userlfswstats&menu_userpbs&menu_usertops");	 	
  closePrivButton("menu_speedunittext&menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
  closePrivButton("menu_pitboardtext&menu_pitboardoff&menu_pitboardchange");
  openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu);  		
        Config_Pitboard($KeyFlags);
EndSub

 
Sub DoMenuHelp( $KeyFlags,$id )		####	This section need's Krayy's CIF Module to be enabled	#####
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions");	closePrivButton("menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
	openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu);
 	DoCifHelpGeneral(0,0); 
EndSub


#########################################################
###	Aternate HELP if you do *NOT* have Krayy's CIF Module enabled
#########################################################
#Sub DoMenuHelp( $KeyFlags,$id )
#	$HostName = getLapperVar( "HostName" );
#	closePrivButton( "menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
#  	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
#  	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
#  	openPrivButton( "menu_menuhelp",$MorigL+1,$MorigT+2,$MWidth+6,$MHeight+1,$Mspacing,$Mtime,0, langEngine("%{menu_helpname}%"));
#	openPrivButton( "menu_topwindow",$MorigL+4,$MorigT+8,$MWidth,14,$Mspacing,$Mtime,16,"^1Work In Progress%nl%^7Please contact%nl%^3admin%nl%^7for help" );  
#  	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
#	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
#EndSub
#########################################################


Sub DoMenuAbout( $KeyFlags,$id )		#	Tells user a little about the server / InSim
  closePrivButton( "menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
 	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
 	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
 	openPrivButton( "menu_menuabout",$MorigL+1,$MorigT+2,$MWidth+6,$MHeight+1,$Mspacing,$Mtime,0, langEngine("%{menu_aboutname}%"));  
	openPrivButton( "menu_topwindow",$MorigL+4,$MorigT+8,$MWidth,14,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_bottomwindow",$MorigL+4,$MorigT+22,$MWidth,15,$Mspacing,$Mtime,16,"" );   
	openPrivButton( "menu_topblurb1",$MorigL+4,$MorigT+8,$MWidth,$MHeight,$Mspacing,$Mtime,0,langEngine("%{menu_topblurb1}%")); 
	openPrivButton( "menu_topblurb2",$MorigL+6,$MorigT+12,18,3,3,$Mtime,64,langEngine("%{menu_topblurb2}%"));    	
	openPrivButton( "menu_bottomblurb1",$MorigL+4,$MorigT+22,$MWidth,$MHeight,3,$Mtime,0,langEngine("%{menu_bottomblurb1}%")); 
	openPrivButton( "menu_bottomblurb2",$MorigL+4,$MorigT+29,$MWidth,3,3,$Mtime,0,langEngine("%{menu_bottomblurb2}%")); 
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
EndSub
             

Sub DoMenuFun( $KeyFlags,$id )		#	For those who get bit bored, or who have time on their hands, and think they're clever.  Go on; you know you want to!
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_smallmenuclose");
	closePrivButton("menu_funrodent&menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_funquiz",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16,langEngine("%{menu_quiz}%"));
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
EndSub


Sub DoMainMenuClose( $KeyFlags,$id )		#	This closes the large menu that has the various choices available
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_back_backing&menu_largeback&menu_largefront&menu_mainmenu&menu_menuabout&menu_menuback&menu_menuclose");
  closePrivButton("menu_menufun&menu_menuhelp&menu_menuoptions&menu_menuuser&menu_name&menu_smallback&menu_smallfront&menu_smallmenuclose");	
	closePrivButton("menu_funanimal&menu_funbird&menu_funcrustacean&menu_funfish&menu_funfruit&menu_funinsect&menu_funparrot&menu_funplanet");
  closePrivButton("menu_funrainbow&menu_funreptile&menu_funrodent&menu_funveg&menu_funsalad&menu_funsnake&menu_funwhale");	
  closePrivButton("menu_funanswer&menu_funanswer1&menu_funfantasy&menu_funnonspecific&menu_funquiz");
  closePrivButton("menu_langback&menu_langDutch&menu_langENchange&menu_langEnglish&menu_langFRchange&menu_langFrench");
  closePrivButton("menu_langItalian&menu_langITchange&menu_langNLchange&menu_langNOchange&menu_langNorway&menu_langtext");  
  closePrivButton("menu_bottomblurb1&menu_bottomblurb2&menu_bottomwindow&menu_closedrftop&menu_closedrftop1&menu_closetop&menu_closetop1");
  closePrivButton("menu_colour&menu_combostatsdetails&menu_combostatsname&menu_host&menu_speed_bg&menu_speed_title&menu_speedunitkph&menu_speedunitmph");	
  closePrivButton("menu_speedunittext&menu_topblurb1&menu_topblurb2&menu_topwindow&menu_usercombostats&menu_userdrifts&menu_userlfswstats&menu_userpbs&menu_usertops");   	
 	closePrivButton("menu_speedunittext&menu_speedunitkph&menu_speedunitmph&menu_speedkphchange&menu_speedmphchange");
  closePrivButton("menu_pitboardtext&menu_pitboardoff&menu_pitboardchange");
  closePrivButton( "menu_closedrifttext&menu_closedrift&menu_closemarshalltext&menu_closemarshall" ); 	
	openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu);
EndSub


Sub DoUserPBs($KeyFlags,$id)
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_userpbs&menu_userlfswstats&menu_usercombostats&menu_usertops&menu_userdrifts&menu_menuback&menu_largeback&menu_largefront");
	closePrivButton("menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
	openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu); 
	CurrentPlayerlfsWorldPB( $argv );
EndSub


Sub DoUserStats($KeyFlags,$id) 
	$userName = GetCurrentPlayerVar( "UserName" );
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_userpbs&menu_userlfswstats&menu_usercombostats&menu_usertops&menu_userdrifts&menu_menuback&menu_largeback&menu_largefront");
	closePrivButton("menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
	openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu);
	 PstInfo( $userName );
EndSub


Sub DoUserComboStats($KeyFlags,$id)
 	closePrivButton("menu_userpbs&menu_userlfswstats&menu_usercombostats&menu_usertops&menu_userdrifts&menu_menuback7menu_largeback&menu_largefront");
	closePrivButton("menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose&menu_smallmenuclose");
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_combostatsname",$MorigL+1,$MorigT+2,$MWidth+6,$MHeight+1,$Mspacing,$Mtime,0, langEngine("%{menu_combostatsname}%"));
	openPrivButton( "menu_combostatsdetails",$MorigL+3,$MorigT+7,$MWidth+2,$MHeight+1,$Mspacing+1,$Mtime,16,langEngine( "%{menu_combostatsdetails}%",GetCurrentPlayerVar("UserName"),GetCurrentPlayerVar("NickName"),GetCurrentPlayerVar("PosAbs"),GetCurrentPlayerVar("PBDrift"),GetCurrentPlayerVar("Car"),getLapperVar("LongTrackName"),getLapperVar("ShortTrackName"),NumToMSH (GetCurrentPlayerVar("PBLapTime")),NumToMSH (GetCurrentPlayerVar("Tpb")),GetCurrentPlayerVar("Laps"),GetCurrentPlayerVar("Dist"),GetCurrentPlayerVar("UnitDist")));  
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
 EndSub


 Sub DoUserTops( $KeyFlags,$id )
	closePrivButton( "menu_usercombostats&menu_usertops&menu_userdrifts&menu_menuback&menu_smallmenuclose");
	closePrivButton( "menu_largeback&menu_largefront&menu_menuuser&menu_userpbs&menu_userlfswstats");
	openPrivButton( "menu_back_backing",50,20,100,15,2,-1,32,"" );
	openPrivButton( "UF1_button",50,25,10,5,2,-1,16,langEngine( "%{menu_UF1}%" ),Click_UF1 );
	openPrivButton( "XFG_button",60,25,10,5,2,-1,16,langEngine( "%{menu_XFG}%" ),Click_XFG );
	openPrivButton( "XRG_button",70,25,10,5,2,-1,16,langEngine( "%{menu_XRG}%" ),Click_XRG );
	openPrivButton( "XRT_button",80,25,10,5,2,-1,16,langEngine( "%{menu_XRT}%" ),Click_XRT );
	openPrivButton( "RB4_button",90,25,10,5,2,-1,16,langEngine( "%{menu_RB4}%" ),Click_RB4 );
	openPrivButton( "FXO_button",100,25,10,5,2,-1,16,langEngine( "%{menu_FXO}%" ),Click_FXO );
	openPrivButton( "RAC_button",110,25,10,5,2,-1,16,langEngine( "%{menu_RAC}%" ),Click_RAC );
	openPrivButton( "FZ5_button",120,25,10,5,2,-1,16,langEngine( "%{menu_FZ5}%" ),Click_FZ5 );
	openPrivButton( "LX4_button",130,25,10,5,2,-1,16,langEngine( "%{menu_LX4}%" ),Click_LX4 );
	openPrivButton( "LX6_button",140,25,10,5,2,-1,16,langEngine( "%{menu_LX6}%" ),Click_LX6 );
	openPrivButton( "MRT_button",50,30,10,5,2,-1,16,langEngine( "%{menu_MRT}%" ),Click_MRT );
	openPrivButton( "UFR_button",60,30,10,5,2,-1,16,langEngine( "%{menu_UFR}%" ),Click_UFR );
	openPrivButton( "XFR_button",70,30,10,5,2,-1,16,langEngine( "%{menu_XFR}%" ),Click_XFR );
	openPrivButton( "FBM_button",80,30,10,5,2,-1,16,langEngine( "%{menu_FBM}%" ),Click_FBM );
	openPrivButton( "FOX_button",90,30,10,5,2,-1,16,langEngine( "%{menu_FOX}%" ),Click_FOX );
	openPrivButton( "FXR_button",100,30,10,5,2,-1,16,langEngine( "%{menu_FXR}%" ),Click_FXR );
	openPrivButton( "XRR_button",110,30,10,5,2,-1,16,langEngine( "%{menu_XRR}%" ),Click_XRR );
	openPrivButton( "FZR_button",120,30,10,5,2,-1,16,langEngine( "%{menu_FZR}%" ),Click_FZR );
	openPrivButton( "FO8_button",130,30,10,5,2,-1,16,langEngine( "%{menu_FO8}%" ),Click_FO8 );
	openPrivButton( "BF1_button",140,30,10,5,2,-1,16,langEngine( "%{menu_BF1}%" ),Click_BF1 );
	openPrivButton( "top1_button",50,20,10,5,2,-1,16,langEngine( "%{menu_top1}%" ),Click_top1 );
	openPrivButton( "top18_button",60,20,10,5,2,-1,16,langEngine( "%{menu_top18}%" ),Click_top18 );
	openPrivButton( "top35_button",70,20,10,5,2,-1,16,langEngine( "%{menu_top35}%" ),Click_top35);
	openPrivButton( "top52_button",80,20,10,5,2,-1,16,langEngine( "%{menu_top52}%" ),Click_top52);
	openPrivButton( "top69_button",90,20,10,5,2,-1,16,langEngine( "%{menu_top69}%" ),Click_top69);
	openPrivButton( "top86_button",100,20,10,5,2,-1,16,langEngine( "%{menu_top86}%" ),Click_top86);
	openPrivButton( "top103_button",110,20,10,5,2,-1,16,langEngine( "%{menu_top103}%" ),Click_top103);
	openPrivButton( "top120_button",120,20,10,5,2,-1,16,langEngine( "%{menu_top120}%" ),Click_top120);
	openPrivButton( "topGTR_button",130,20,10,5,2,-1,16,langEngine( "%{menu_topGTR}%" ),Click_topGTR);
#	openPrivButton( "topFWD_button",120,20,10,5,2,-1,16,langEngine( "%{menu_topFWD}%" ),Click_topFWD);
#	openPrivButton( "topRWD_button",130,20,10,5,2,-1,16,langEngine( "%{menu_topRWD}%" ),Click_topRWD);
	openPrivButton( "topTBO_button",140,20,10,5,2,-1,16,langEngine( "%{menu_topTBO}%" ),Click_topTBO);
	openPrivButton( "menu_closetop",40,20,10,5,5,-1,32,langEngine( "%{menu_closetop}%" ),menu_closetop );
	openPrivButton( "menu_closetop1",150,20,10,5,5,-1,32,langEngine( "%{menu_closetop1}%" ),menu_closetop );

EndSub


Sub DoUserDrifts( $KeyFlags,$id )
	closePrivButton("statsbacking&statstitle&statsdetails&qualdetails&closestats&back_button");
	closePrivButton("help&help2&close&statsbacking&statstitle&statsdetails&qualdetails&closestats");
	closePrivButton("drf_rubbish_button&drftop_button&closedrftop&closedrftop1&help&help2&close&drfback_button");
	closePrivButton("drfnear_button&drf_rubbish_button&closedrftop&closedrftop1&help&help2&close&drfback_button");
	closePrivButton("closetop&closetop1&help&help2&close&back_button&topTBO_button");
	closePrivButton("back_button&UF1_button&XFG_button&XRG_button&XRT_button&RB4_button&FXO_button&RAC_button&FZ5_button&LX4_button&LX6_button");
	closePrivButton("UF1_button&XFG_button&XRG_button&XRT_button&RB4_button&FXO_button&RAC_button&FZ5_button&LX4_button&LX6_button");
	closePrivButton("MRT_button&UFR_button&XFR_button&FBM_button&FOX_button&FXR_button&XRR_button&FZR_button&FO8_button&BF1_button");
	closePrivButton("top1_button&top18_button&top35_button&top52_button&top69_button&top86_button&top103_button&top120_button&topGTR_button&topFWD_button&topRWD_button");
	closePrivButton( "menu_largeback&menu_largefront&menu_menuuser&menu_userpbs&menu_userlfswstats&menu_usercombostats");
	closePrivButton( "menu_usertops&menu_userdrifts&menu_menuback&menu_smallmenuclose");
	openPrivButton( "drfback_button",50,25,100,10,2,-1,32,"" );
	openPrivButton( "drftop_button",50,25,20,5,2,-1,16,langEngine( "%{menu_drftop}%" ),Click_drftop );
	openPrivButton( "19_36_button",70,25,10,5,2,-1,16,langEngine( "%{menu_1936}%" ),Click_1936 );
	openPrivButton( "37_54_button",80,25,10,5,2,-1,16,langEngine( "%{menu_3754}%" ),Click_3754 );
	openPrivButton( "55_72_button",90,25,10,5,2,-1,16,langEngine( "%{menu_5572}%" ),Click_5572 );
	openPrivButton( "73_90_button",100,25,10,5,2,-1,16,langEngine( "%{menu_7390}%" ),Click_7390 );
	openPrivButton( "91_108_button",110,25,10,5,2,-1,16,langEngine( "%{menu_91108}%" ),Click_91108 );
	openPrivButton( "109_126_button",120,25,10,5,2,-1,16,langEngine( "%{menu_109126}%" ),Click_109126 );
	openPrivButton( "127_144_button",130,25,10,5,2,-1,16,langEngine( "%{menu_127144}%" ),Click_127144 );
	openPrivButton( "145_162_button",140,25,10,5,2,-1,16,langEngine( "%{menu_145162}%" ),Click_145162 );
	openPrivButton( "drfnear_button",50,30,20,5,2,-1,16,langEngine( "%{menu_drfnear}%" ),Click_drfnear );
	openPrivButton( "163_180_button",70,30,10,5,2,-1,16,langEngine( "%{menu_163180}%" ),Click_163180 );
	openPrivButton( "181_198_button",80,30,10,5,2,-1,16,langEngine( "%{menu_181198}%" ),Click_181198 );
	openPrivButton( "199_216_button",90,30,10,5,2,-1,16,langEngine( "%{menu_199216}%" ),Click_199216 );
	openPrivButton( "217_234_button",100,30,10,5,2,-1,16,langEngine( "%{menu_217234}%" ),Click_217234 );
	openPrivButton( "235_252_button",110,30,10,5,2,-1,16,langEngine( "%{menu_235252}%" ),Click_235252 );
	openPrivButton( "253_270_button",120,30,10,5,2,-1,16,langEngine( "%{menu_253270}%" ),Click_253270 );
	openPrivButton( "271_289_button",130,30,10,5,2,-1,16,langEngine( "%{menu_271289}%" ),Click_271289 );
	openPrivButton( "290_307_button",140,30,10,5,2,-1,16,langEngine( "%{menu_290307}%" ),Click_290307 );
	openPrivButton( "drf_rubbish_button",150,35,10,5,5,-1,32,langEngine( "%{menu_drfrubbish}%" ),Click_drfrubbish );
	openPrivButton( "menu_closedrftop",40,25,10,5,5,-1,32,langEngine( "%{menu_closetopa}%" ),menu_closedrftop );
	openPrivButton( "menu_closedrftop1",150,25,10,5,5,-1,32,langEngine( "%{menu_closetop1a}%" ),menu_closedrftop );
EndSub


Sub menu_closedrftop( $KeyFlags,$id )
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_back_backing&menu_closedrftop&menu_closedrftop1&menu_drfrubbish&drfback_button&drftop_button&drf_rubbish_button");	
	closePrivButton("19_36_button&37_54_button&55_72_button&73_90_button&91_108_button&217_234_button&235_252_button&271_289_button&290_307_button");
	closePrivButton("drfnear_button&109_126_button&127_144_button&145_162_button&163_180_button&181_198_button&199_216_button&253_270_button");	
	openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu);	
EndSub


Sub menu_closetop( $KeyFlags,$id )
	$HostName = getLapperVar( "HostName" );
	closePrivButton("menu_back_backing&menu_closetop&menu_closetop1&topTBO_button&topFWD_button&topRWD_button&topGTR_button");
	closePrivButton("UF1_button&XFG_button&XRG_button&XRT_button&RB4_button&FXO_button&RAC_button&FZ5_button&LX4_button&LX6_button");
	closePrivButton("MRT_button&UFR_button&XFR_button&FBM_button&FOX_button&FXR_button&XRR_button&FZR_button&FO8_button&BF1_button");	
	closePrivButton("top1_button&top18_button&top35_button&top52_button&top69_button&top86_button&top103_button&top120_button");
	openPrivButton( "menu_smallback",$MorigL,191,$MWidth+10,7,2,$Mtime,16,"" );
	openPrivButton( "menu_smallfront",$MorigL+1,192,$MWidth+8,5,2,$Mtime,32,"" );
	openPrivButton( "menu_host",$MorigL+1,193,14,3,2,$Mtime,0,$HostName);
	openPrivButton( "menu_name",$MorigL+14,193,14,3,2,$Mtime,16,langEngine("%{menu_menuname}%"),DoMenu);	
EndSub


CatchEvent OnMSO( $userName, $text ) # Player event - this section needed for when someone types a word in the text box and you want lapper to answer

	$idxOfFirtsSpace = indexOf( $text, " ");
	IF( $idxOfFirtsSpace == -1 ) THEN
	  $command = $text;
	  $argv = "";
	ELSE
	  $command = subStr( $text,0,$idxOfFirtsSpace );
	  $argv = trim( subStr( $text,$idxOfFirtsSpace ) );
	ENDIF

	SWITCH( $command )

#	Turns 'Menu System' on without having to spectate first

		CASE "!menu":
		CASE "!Menu":
		CASE "!MENU":
                CASE "!admin":
		DoMenu(0,0);
BREAK;


####	This section deals with the 'FUN' part	#	Feel free to add anything you think may be missing		# 	Does assume people can spell properly in English		####

CASE "ananas": CASE "apple": CASE "apricot": CASE "avocado":  CASE "avocat":  CASE "banana": CASE "banane": CASE "berry": CASE "berry": CASE "blackberry": CASE "blackcurrant":
CASE "bleuet": CASE "blueberry": CASE "cassis": CASE "cherry": CASE "clementine": CASE "coconut":CASE "currant": CASE "durian": CASE "fig": CASE "gooseberry": CASE "goyave":
CASE "grape": CASE "grapefruit": CASE "groseille": CASE "guava": CASE "mandarin": CASE "noix": CASE "orange": CASE "pamplemousse": CASE "passion": CASE "peach": CASE "pear":
CASE "pinapple": CASE "pineapple": CASE "poire": CASE "pomigranate": CASE "pomme": CASE "raisin": CASE "lime": CASE "lemon": CASE "squash": CASE "mango":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton("menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funfruit",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_fruit}%"));		
BREAK;
	
CASE "artichaut": CASE "artichoke":  CASE "asparagus":  CASE "asperges":  CASE "aubergine":  CASE "basil":  CASE "basilic":  CASE "bean":
CASE "beetroot": CASE "broccoli": CASE "brocoli": CASE "brussel": CASE "bruxelles": CASE "cabbage": CASE "carotte": CASE "carrot":
CASE "cassava": CASE "cauliflower": CASE "celeri": CASE "celery": CASE "chou": CASE "corn": CASE "courgette": CASE "eggplant": CASE "horseradish":
CASE "leek": CASE "mais": CASE "maize": CASE "navet": CASE "oignon": CASE "onion": CASE "pea": CASE "pomme": CASE "potato": CASE "radish":
CASE "raifort": CASE "shallot": CASE "soya": CASE "turnip": CASE "yam":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funveg",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_veg}%"));
BREAK;		
		
CASE "asparagus": CASE "concombre": CASE "cucumber": CASE "laitue": CASE "lettuce":  CASE "rocket":  CASE "spinach": CASE "tomate": CASE "tomato":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funsalad",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_salad}%"));
BREAK;		

CASE "earth": CASE "jupiter": CASE "mars":  CASE "mercury": CASE "neptune": CASE "pluto": CASE "saturn":  CASE "uranus":  CASE "venus":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("men_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funplanet",$MorigL+4,$MorigT+13,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_planet}%"));
BREAK;

CASE "asteroid": CASE "aurora": CASE "comet": CASE "constellation": CASE "corona": CASE "cosmic": CASE "cosmos": CASE "eclipse": CASE "galactic":
CASE "galaxies": CASE "galaxy": CASE "io": CASE "lunar": CASE "meteor": CASE "meteorite": CASE "moon": CASE "nebula": CASE "nebulae": CASE "neutron":
CASE "nova": CASE "planet":  CASE "pulsar": CASE "quasar": CASE "satellite": CASE "solar": CASE "space": CASE "star": CASE "stellar": CASE "sun":
CASE "supenova": CASE "universe": CASE "zodiac":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose"); 
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funastro",$MorigL+4,$MorigT+13,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_astro}%"));                  	    		
BREAK;

CASE "anchovy": CASE "angelfish": CASE "anglerfish": CASE "barracuda": CASE "bass": CASE "bream": CASE "carp": CASE "catfish": CASE "clownfish": CASE "cod":
CASE "conger":  CASE "dogfish": CASE "eel": CASE "elver": CASE "flounder": CASE "flyingfish": CASE "goldfish": CASE "guppy": CASE "haddock": CASE "hake":
CASE "halibut": CASE "hammerhead": CASE "herring": CASE "lampray": CASE "lemonsole": CASE "loach": CASE "lungfish": CASE "mackarel": CASE "manta": CASE "marlin":
CASE "minnow": CASE "moray": CASE "octopus": CASE "parrotfish": CASE "perch": CASE "pike": CASE "piranha": CASE "plaice": CASE "rainbowfish": CASE "ray":
CASE "sailfish": CASE "salmon": CASE "sardine":  CASE "saury":  CASE "seahorse": CASE "shark": CASE "skate": CASE "snapper": CASE "sole": CASE "sprat":
CASE "squid": CASE "stickleback": CASE "stingray": CASE "sturgeon": CASE "sunfish": CASE "swordfish": CASE "tang": CASE "tench": CASE "trout":
CASE "tuna": CASE "turbot": CASE "wrasse":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funfish",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_fish}%"));
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
BREAK;

CASE "aardvark": CASE "alpaca": CASE "antelope": CASE "anteater": CASE "ape": CASE "ass": CASE "armadillo": CASE "badger": CASE "baboon": CASE "bandicoot": CASE "bear": CASE "bison":
CASE "bilby": CASE "boar": CASE "bobcat":  CASE "bongo": CASE "buffalo": CASE "bull": CASE "camel": CASE "capybara": CASE "caribou": CASE "catamount": CASE "cheetah": CASE "cat":
CASE "coaty": CASE "coatimundi": CASE "cony": CASE "cow": CASE "cougar": CASE "coyote": CASE "deer": CASE "dhole": CASE "dingo": CASE "dog": CASE "donkey": CASE "echidna": 
CASE "dromedary": CASE "elephant": CASE "ermine": CASE "foal": CASE "fox": CASE "gazelle": CASE "gibbon": CASE "giraffe": CASE "gnu": CASE "goat": CASE "gorilla": CASE "quokka":
CASE "hare": CASE "hedgehog": CASE "hippo": CASE "hippopotumus": CASE "horse": CASE "husky": CASE "hyena": CASE "impala": CASE "jaguar": CASE "kangaroo": CASE "numbat":
CASE "kinkajou": CASE "koala": CASE "kodkod": CASE "lemming": CASE "lemur": CASE "leopard": CASE "lion": CASE "lioness": CASE "llama": CASE "lynx": CASE "macaque":
CASE "mandrill": CASE "meercat": CASE "meerkat": CASE "mole": CASE "mongoose": CASE "monkey": CASE "moose": CASE "mule": CASE "ocelot": CASE "okapi": CASE "nabarlek": 
CASE "opossum": CASE "orang": CASE "orangutang": CASE "oryx": CASE "ox": CASE "panda": CASE "pangoline": CASE "panther": CASE "peccary": CASE "pig": CASE "piglet": CASE "quoll":
CASE "pika": CASE "platypus": CASE "polar": CASE "pony": CASE "porcupine": CASE "possum": CASE "pronghorn": CASE "puma": CASE "rabbit": CASE "racoon": CASE "reindeer": CASE "rhino":
CASE "rhinoceros": CASE "serval": CASE "sheep": CASE "skunk": CASE "shrew": CASE "sloth": CASE "squirrel": CASE "stoat": CASE "tapir": CASE "tarsier": CASE "tiger": CASE "wombat":
CASE "tortoise": CASE "wallaby": CASE "warthog": CASE "weasel": CASE "wildebeest": CASE "wolf": CASE "worm": CASE "yak": CASE "zebra":  CASE "zorilla": CASE "zorro":  
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer1",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer1}%"));
	openPrivButton( "menu_funanimal",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_animal}%"));
BREAK;

CASE "bigfoot": CASE "chimera": CASE "cyclops": CASE "dragon": CASE "elf": CASE "fairy":
CASE "griffon": CASE "gryphon": CASE "ogre": CASE "pegasus": CASE "sphinx": CASE "troll":
CASE "unicorn": CASE "vampire":CASE "werewolf":CASE "yeti": CASE "zombie":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton("menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer1}%"));
	openPrivButton( "menu_funfantasy",$MorigL+4,$MorigT+13,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_fantasy}%"));
BREAK;

CASE "animal": CASE "bird": CASE "crustacean": CASE "fish": CASE "flower": CASE "fruit": CASE "insect": CASE "mammal": CASE "ocean":
CASE "plant": CASE "reptile": CASE "rodent": CASE "sea": CASE "snake": CASE "tree": CASE "tree": CASE "veg": CASE "vegetable":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funnonspecific",$MorigL+4,$MorigT+13,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_nonspecific}%"));
BREAK;

CASE "accentor": CASE "auklet": CASE "avocet": CASE "bee-eater": CASE "bittern": CASE "blackbird": CASE "booby": CASE "budgie": CASE "bullfinch": CASE "bunting": CASE "bustard":
CASE "buzzard": CASE "camaru": CASE "capercaillie": CASE "chaffinch": CASE "chicken": CASE "cockatoo": CASE "coot": CASE "cormorant": CASE "crake": CASE "crane": CASE "crossbill":
CASE "crow": CASE "cuckoo": CASE "curlew": CASE "dotterel": CASE "dove": CASE "dowitcher": CASE "duck": CASE "eagle": CASE "emu": CASE "egret": CASE "eider": CASE "falcon":
CASE "finch": CASE "flamingo": CASE "flycatcher": CASE "fulmar": CASE "gallinule": CASE "gannet": CASE "goldfinch": CASE "goose": CASE "goshawk": CASE "grebe":
CASE "greenfinch": CASE "grouse": CASE "guillemot": CASE "gull": CASE "gullimot": CASE "gyrfalcon": CASE "harrier": CASE "hawk": CASE "hen": CASE "heron": CASE "housemartin":
CASE "ibis": CASE "jackdaw": CASE "jay": CASE "kestrel": CASE "kingfisher": CASE "kite": CASE "kittiwake": CASE "lapwing": CASE "lark": CASE "linnet": CASE "loon": CASE "macaw":CASE "magpie":
CASE "mallard": CASE "martin": CASE "moorhen": CASE "nightingale": CASE "nightjar": CASE "nuthatch": CASE "ostrich": CASE "owl": CASE "oystercatcher": CASE "patridge": CASE "pelican":
CASE "penquin": CASE "perigrine": CASE "petrel": CASE "phalarope": CASE "pheasant": CASE "pigeon": CASE "pipet": CASE "plover": CASE "pochard": CASE "ptarmigan": CASE "puffin":
CASE "quail": CASE "raven": CASE "razorbill": CASE "rhea": CASE "roadrunner":  CASE "robin":  CASE "rook":  CASE "rosefinch": CASE "sandpiper": CASE "seaeagle": CASE "seagull":
CASE "shrike": CASE "skua": CASE "snipe": CASE "snowcock": CASE "sparrow": CASE "sparrowhawk": CASE "spoonbill": CASE "starling": CASE "stork": CASE "stormpetrel": CASE "swallow":
CASE "swan": CASE "swift": CASE "teal": CASE "tern": CASE "thrush": CASE "tit": CASE "turkey": CASE "turtledove": CASE "vulture": CASE "wagtail": CASE "warbler": CASE "wigeon":
CASE "woodcock": CASE "woodpecker": CASE "woodpigeon": CASE "wren":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer1",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer1}%"));
	openPrivButton( "menu_funbird",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_bird}%"));
BREAK;

CASE "agouti": CASE "capybara": CASE "chinchilla": CASE "chipmunk": CASE "coypu": CASE "coypus": CASE "ferret": CASE "gerbil": CASE "groundhog": CASE "guinea": CASE "hamster":
CASE "jerboa": CASE "mink": CASE "muskrat": CASE "mouse": CASE "nutrias": CASE "rat": CASE "skunk": CASE "woodchuck": CASE "wolverine":
	closePrivButton( "menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funrodent",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_rodent}%"));
BREAK;

CASE "Anenome": CASE "barnacle": CASE "clam": CASE "cockle": CASE "crab": CASE "crayfish": CASE "crawfish": CASE "lobster": CASE "mollusc": CASE "mussel":
CASE "oyster": CASE "periwinkle": CASE "prawn": CASE "scallop": CASE "shrimp": CASE "starfish":  CASE "whelk":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funcrustacean",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_crustacean}%"));
BREAK;


CASE "ant": CASE "aphid": CASE "bee": CASE "beetle": CASE "bluebottle": CASE "caterpillar": CASE "centipede": CASE "cockroach": CASE "cricket": CASE "dragonfly":
CASE "flea": CASE "fly": CASE "gnat": CASE "grasshopper": CASE "greenfly": CASE "hornet": CASE "horsefly": CASE "ladybird": CASE "leech": CASE "locust":
CASE "mayfly": CASE "midgie": CASE "midge": CASE "millipede": CASE "spider": CASE "termite": CASE "tic": CASE "wasp": CASE "woodlice":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer1",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer1}%"));
	openPrivButton( "menu_funinsect",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_insect}%"));
BREAK;


CASE "alligator": CASE "caiman": CASE "cayman": CASE "chameleon": CASE "crocodile": CASE "gecko": CASE "iguana": CASE "lizard": CASE "salamander": CASE "skink": CASE "turtle": CASE "tortoise":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton("menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funreptile",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_reptile}%"));		
BREAK;    
    
CASE "parrot":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funparrot",$MorigL+4,$MorigT+8,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_parrot}%"));
BREAK;    
    
CASE "adder": CASE "anaconda": CASE "asp":  CASE "boa": CASE "bushmaster": CASE "cobra": CASE "copperhead": CASE "coralsnake": CASE "cottonmouth":
CASE "diamondback": CASE "fer-de-lance": CASE "keelback": CASE "krait":  CASE "lancehead": CASE "lyresnake": CASE "mamba": CASE "python": CASE "rattlesnake":
CASE "seasnake": CASE "sidewinder": CASE "taipan": CASE "viper":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	 openPrivButton( "menu_funsnake",$MorigL+4,$MorigT+16,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_snake}%"));		
BREAK;
    
CASE "dolphin": CASE "dugong": CASE "humpback": CASE "manatee": CASE "minke": CASE "narwhal": CASE "orca": CASE "porpoise": CASE "seal":
CASE "sealion": CASE "walrus": CASE "whale":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
 	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funanswer",$MorigL+4,$MorigT+4,$MWidth,$MHeight,$Mspacing+1,$Mtime,16, langEngine("%{menu_answer}%"));
	openPrivButton( "menu_funwhale",$MorigL+4,$MorigT+13,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_whale}%"));
BREAK;  

CASE "red": CASE "blue": CASE "yellow": CASE "orange": CASE "green": CASE "indigo": CASE "violet":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton("menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_funrainbow",$MorigL+4,$MorigT+4,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_rainbow}%"));
BREAK;

CASE "white": CASE "black": CASE "gray": CASE "grey":
	closePrivButton("menu_largeback&menu_largefront&menu_mainmenu&menu_menuuser&menu_menuoptions&menu_menuhelp&menu_menuabout&menu_menufun&menu_menuclose");
	closePrivButton("menu_funanswer&menu_funquiz&menu_funfruit&menu_funsalad&menu_funveg&menu_funplanet&menu_funastro&menu_funfish&menu_smallmenuclose");
	closePrivButton("menu_funanswer1&menu_funanimal&menu_funastro&menu_funfantasy&menu_funnonspecific&menu_funbird&menu_funcrustacean&menu_funrodent");
	closePrivButton("menu_funinsect&menu_funreptile&menu_funparrot&menu_funsnake&menu_funwhale&menu_funrainbow&menu_colour");
	closePrivButton("menu_menuabout&menu_topwindow&menu_bottomwindow&menu_topblurb1&menu_topblurb2&menu_bottomblurb1&menu_bottomblurb2");	
	openPrivButton( "menu_largeback",$MorigL,$MorigT,$MWidth+8,45,$Mspacing,$Mtime,16,"" );
	openPrivButton( "menu_largefront",$MorigL+1,$MorigT+1,$MWidth+6,43,$Mspacing,$Mtime,32,"" );
	openPrivButton( "menu_menuback",$MorigL+4,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuback}%"),DoMenu);
	openPrivButton( "menu_smallmenuclose",$MorigL+14,$MorigT+38,10,$MHeight,$Mspacing,$Mtime,16,langEngine("%{menu_menuclose}%"),DoMainMenuClose);
	openPrivButton( "menu_colour",$MorigL+4,$MorigT+4,$MWidth,$MHeight+2,$Mspacing+1,$Mtime,0, langEngine("%{menu_colour}%"));
BREAK;

	CASE "!UF1":
	CASE "!uf1":
		Click_UF1(0,0);
	 BREAK;

	CASE "!LX6":
	CASE "!lx6":
		Click_LX6(0,0);
	BREAK;

	CASE "!LX4":
	CASE "!lx4":
		Click_LX4(0,0);
	BREAK;

	CASE "!FZ5":
	CASE "!fz5":
		Click_FZ5(0,0);
	BREAK;

	CASE "!FXO":
	CASE "!fxo":
		Click_FXO(0,0);
	BREAK;

	CASE "!RAC":
	CASE "!rac":
		Click_RAC(0,0);
	BREAK;

	CASE "!RB4":
	CASE "!rb4":
		Click_RB4(0,0);
	BREAK;

	CASE "!FBM":
	CASE "!fbm":
		Click_FBM(0,0);
	 BREAK;

	CASE "!FOX":
	CASE "!fox":
		Click_FOX(0,0);
	 BREAK;

	CASE "!FO8":
	CASE "!fo8":
		Click_FO8(0,0);
	 BREAK;

	CASE "!FZR":
	CASE "!fzr":
		Click_FZR(0,0);
	 BREAK;

	CASE "!FXR":
	CASE "!fxr":
		Click_FXR(0,0);
	 BREAK;

	CASE "!XRR":
	CASE "!xrr":
		Click_XRR(0,0);
	 BREAK;

	CASE "!XRG":
	CASE "!xrg":
		Click_XRG(0,0);
	 BREAK;

	CASE "!MRT":
	CASE "!mrt":
		Click_MRT(0,0);
	 BREAK;

	CASE "!XRT":
	CASE "!xrt":
		Click_XRT(0,0);
	 BREAK;

	CASE "!XFR":
	CASE "!xfr":
		Click_XFR(0,0);
	 BREAK;

	CASE "!XFG":
	CASE "!xfg":
		Click_XFG(0,0);
	 BREAK;

	CASE "!UFR":
	CASE "!ufr":
		Click_UFR(0,0);
	 BREAK;

	CASE "!BF1":
	CASE "!bf1":
		Click_BF1(0,0);
	 BREAK;




	ENDSWITCH

EndCatchEvent



Sub Click_UF1( $KeyFlags,$id )
	top ( UF1 );
EndSub

Sub Click_XFG( $KeyFlags,$id )
	top ( XFG );
EndSub

Sub Click_XRG( $KeyFlags,$id )
	top ( XRG );
EndSub

Sub Click_XRT( $KeyFlags,$id )
	top ( XRT );
EndSub

Sub Click_RB4( $KeyFlags,$id )
	top ( RB4 );
EndSub

Sub Click_FXO( $KeyFlags,$id )
	top ( FXO );
EndSub

Sub Click_RAC( $KeyFlags,$id )
	top ( RAC );
EndSub

Sub Click_FZ5( $KeyFlags,$id )
	top ( FZ5 );
EndSub

Sub Click_LX4( $KeyFlags,$id )
	top ( LX4 );
EndSub

Sub Click_LX6( $KeyFlags,$id )
	top ( LX6 );
EndSub

Sub Click_MRT( $KeyFlags,$id )
	top ( MRT );
EndSub

Sub Click_UFR( $KeyFlags,$id )
	top ( UFR );
EndSub

Sub Click_XFR( $KeyFlags,$id )
	top ( XFR );
EndSub

Sub Click_FBM( $KeyFlags,$id )
	top ( FBM );
EndSub

Sub Click_FOX( $KeyFlags,$id )
	top ( FOX );
EndSub

Sub Click_FXR( $KeyFlags,$id )
	top ( FXR );
EndSub

Sub Click_XRR( $KeyFlags,$id )
	top ( XRR );
EndSub

Sub Click_FZR( $KeyFlags,$id )
	top ( FZR );
EndSub

Sub Click_FO8( $KeyFlags,$id )
	top ( FO8 );
EndSub

Sub Click_BF1( $KeyFlags,$id )
	top ( BF1 );
EndSub

Sub Click_top1( $KeyFlags,$id )
	top ( 1 );
EndSub

Sub Click_top18( $KeyFlags,$id )
	top ( 18 );
EndSub

Sub Click_top35( $KeyFlags,$id )
	top ( 35 );
EndSub

Sub Click_top52( $KeyFlags,$id )
	top ( 52 );
EndSub

Sub Click_top69( $KeyFlags,$id )
	top ( 69 );
EndSub

Sub Click_top86( $KeyFlags,$id )
	top (86 );
EndSub

Sub Click_top103( $KeyFlags,$id )
	top (103 );
EndSub

Sub Click_top120( $KeyFlags,$id )
	top (120 );
EndSub

Sub Click_topGTR( $KeyFlags,$id )
	top (GTR );
EndSub

Sub Click_topFWD( $KeyFlags,$id )
	top (FWD);
EndSub

Sub Click_topRWD( $KeyFlags,$id )
	top (RWD);
EndSub

Sub Click_topTBO( $KeyFlags,$id )
	top (TBO);
EndSub

Sub Click_drftop( $KeyFlags,$id )
	drf( $argv );
EndSub

Sub Click_1936( $KeyFlags,$id )
	drf( 19 );
EndSub

Sub Click_3754( $KeyFlags,$id )
	drf( 37 );
EndSub

Sub Click_5572( $KeyFlags,$id )
	drf( 55 );
EndSub

Sub Click_7390( $KeyFlags,$id )
	drf( 73 );
EndSub

Sub Click_91108( $KeyFlags,$id )
	drf( 91 );
EndSub

Sub Click_109126( $KeyFlags,$id )
	drf( 109 );
EndSub

Sub Click_127144( $KeyFlags,$id )
	drf( 127 );
EndSub

Sub Click_145162( $KeyFlags,$id )
	drf( 145 );
EndSub

Sub Click_163180( $KeyFlags,$id )
	drf( 163 );
EndSub

Sub Click_181198( $KeyFlags,$id )
	drf( 181 );
EndSub

Sub Click_199216( $KeyFlags,$id )
	drf( 199 );
EndSub

Sub Click_217234( $KeyFlags,$id )
	drf( 217 );
EndSub

Sub Click_235252( $KeyFlags,$id )
	drf( 235 );
EndSub

Sub Click_253270( $KeyFlags,$id )
	drf( 253 );
EndSub

Sub Click_271289( $KeyFlags,$id )
	drf( 271 );
EndSub

Sub Click_290307( $KeyFlags,$id )
	drf( 290 );
EndSub

Sub Click_drfrubbish( $KeyFlags,$id )
	drf( 308 );
EndSub

Sub Click_drfnear( $KeyFlags,$id )
	$NickName = GetCurrentPlayerVar("NickName");
	drfNear( $NickName );
EndSub


####	The Various Language Choices Available


# ENGLISH LANGUAGE SECTION				
##########################

Lang "EN"

#	MAIN PART OF MENU
menu_menuname = "^7MENU SYSTEM%at%^7MENU SYSTEM%at%^6MENU SYSTEM%at%^6MENU SYSTEM";
menu_mainmenu = "^6MENU";
menu_userswitchboard = "^7USER SWITCHBOARD";
menu_optionsname = "^7OPTIONS";
menu_helpname = "^7HELP";
menu_aboutname = "^7ABOUT";
menu_funname = "^7FUN";
menu_menuback = "^6< ^7BACK";
menu_menuclose = "^7CLOSE";

menu_topblurb1 = "^6Server Configuration";
menu_topblurb2 = "^7Mode: ^6Race / Drift%nl%^7Mid Race Join: ^6Allowed%nl%^7Car Reset: ^6Disallowed";
menu_bottomblurb1 = "^1Sin'rs%nl%^2(^1Sin^2anju^1'^2s ^1r^2acing ^1s^2erver)";
menu_bottomblurb2 = "^7InSim: ^6Based on LFSLapper ^7v6.011%nl%^6customised by ^4[^7><^4]^2S^3inanju";

menu_userpbs = "^6All your Personal Bests";  
menu_userlfswstats = "^6Your LFSWorld Stats";  
menu_usercombostats = "^6This Server's Combo Stats";  
menu_usertops = "^6Top Times";
menu_userdrifts = "^6Top Drifts";


menu_closedrifttext = "^6Driftmeter";
menu_driftclose = "^7Close";
menu_closemarshalltext = "^6Marshalls";
menu_closemarshall = "^7Close"; 

menu_combostatsname = "^6Combo Stats";
menu_combostatsdetails = "^7Ranking: ^6{2}"
            . "%nl%^6{4} ^7Drift PB: ^6{3}"
            . "%nl%^7Current Track: ^6{6}"
            . "%nl%^7This combo PB: ^6{7}"
            . "%nl%^7Theoretical PB: ^6{8}"
            . "%nl%^7Distance: ^6{9} ^7laps / ^6{10} ^7{11}";

menu_drfnear = "^3Who am I nearest?";
menu_drfrubbish = "^8Some of%nl%^8the rest";
menu_drftop = "^3At the very Top is?";


#	LANGUAGE
menu_langtext = "^6Language";
menu_lang_en = "^7Your%nl%^7current language%nl%^7now set to:%nl%^6{0}";
menu_langENchange = "^7Language changed to ^6English";
menu_langFRchange = "^7Langue chang'e a' ^6French";
#menu_langFRchange = "^7Langue changé à ^6French";
menu_langITchange = "^7Lingua cambiato ^6Italian";
menu_langNOchange = "^7Språk endret til ^6Norvegian";
menu_langNLchange = "^7Taal veranderd naar ^6Dutch";

# SPEED UNIT
menu_speedunittext = "^6Speed Unit";
menu_speedkphchange = "^7Speed Unit changed to ^6KPH";	  
menu_speedmphchange = "^7Speed Unit changed to ^6MPH";

menu_pitboardtext = "^6Pitboard"; 	
menu_pitboardclosed = "^7Pitboard Closed";

#	QUIZ
menu_quiz = "^2QUIZ:%nl%^3Type in the name of either%nl%^3fruit, veg, planet, bird,%nl%^3animal, snake, etc";
menu_answer = "^3Quiz Answer:%nl%^2I think that is a%nl%%nl%%nl%Type another word%nl%to try again";
menu_answer1 = "^3Quiz Answer:%nl%^2I think that is an%nl%%nl%%nl%Type another word%nl%to try again";
menu_fruit = "^4FRUIT";
menu_veg = "^4VEGETABLE";
menu_salad = "^4SALAD VEGETABLE";
menu_planet = "^4PLANET IN OUR%nl%^4SOLAR SYSTEM";
menu_astro = "^4TERM USED IN%nl%^4ASTRONOMY";
menu_fish = "^4FISH";
menu_animal = "^4ANIMAL";
menu_fantasy = "^4FANTASY%nl%^4ANIMAL ";
menu_nonspecific = "^2Quiz Question%nl%^2not specific enough.%nl%%nl%^3Try another word.";
menu_bird = "^4BIRD";
menu_rodent = "^4RODENT";
menu_crustacean = "^4CRUSTACEAN";
menu_insect = "^4INSECT";
menu_reptile = "^4REPTILE";
menu_parrot = "^4Is that%nl%^4parrot deceased?";
menu_snake = "^4SNAKE";
menu_whale = "^4Mammal that%nl%^4lives in the sea";
menu_rainbow = "^3Quiz Answer:%nl%%nl%^2One of the colours%nl%^2in a rainbow%nl%Type another word%nl%to try again";
menu_colour = "^3Quiz Answer:%nl%^2This colour%nl%^2rejected by%nl%^2the rainbow%nl%Type another word%nl%to try again";




#	CARS

menu_BF1 = "^2BF1";
menu_FBM = "^2FBM";
menu_FO8 = "^2FO8";
menu_FOX = "^2FOX";
menu_FXO = "^2FXO";
menu_FXR = "^2FXR";
menu_FZ5 = "^2FZ5";
menu_FZR = "^2FZR";
menu_LX4 = "^2LX4";
menu_LX6 = "^2LX6";
menu_MRT = "^2MRT";
menu_RAC = "^2RAC";
menu_RB4 = "^2RB4";
menu_UF1 = "^2UF1";
menu_UFR = "^2UFR";
menu_XFG = "^2XFG";
menu_XFR = "^2XFR";
menu_XRG = "^2XRG";
menu_XRR = "^2XRR";
menu_XRT = "^2XRT";

menu_top1 = "^2Top 1 - 18";
menu_top18 = "^2Top 18 - 35";
menu_top35 = "^2Top 35 - 52";
menu_top52 = "^2Top 52 - 69";
menu_top69 = "^2Top 69 - 86";
menu_top86 = "^2Top 86 - 103";
menu_top103 = "^2Top 103 - 120";
menu_top120 = "^2Top 120 - 137";
menu_topGTR = "^2Top GTR's";
#menu_topFWD = "^2Top FWD's";
#menu_topRWD = "^2Top RWD's";
menu_topTBO = "^2Top TBO's";

menu_closetop = "^3CLOSE ^1->"
. "%nl%^3ALL ^1->"
. "%nl%^3ROWS ^1->";

menu_closetop1 = "^1<- ^3CLOSE"
. "%nl%^1<- ^3ALL"
. "%nl%^1<- ^3ROWS";

#	DRIFT SCORE BUTTONS

menu_1936 = "^319 ^7to ^336";
menu_3754 = "^337 ^7to ^354";
menu_5572 = "^355 ^7to ^372";
menu_7390 = "^373 ^7to ^390";
menu_91108 = "^391 ^7to ^3108";
menu_109126 = "^3109 ^7to ^3126";
menu_127144 = "^3127 ^7to ^3144";
menu_145162 = "^3145 ^7to ^3162";
menu_163180 = "^3163 ^7to ^3180";
menu_181198 = "^3181 ^7to ^3198";
menu_199216 = "^3199 ^7to ^3216";
menu_217234 = "^3217 ^7to ^3234";
menu_235252 = "^3235 ^7to ^3252";
menu_253270 = "^3253 ^7to ^3270";
menu_271289 = "^3271 ^7to ^3289";
menu_290307 = "^3290 ^7to ^3307";



menu_closetopa = "^3CLOSE ^1->"
. "%nl%^3ROWS ^1->";

menu_closetop1a = "^1<- ^3CLOSE"
. "%nl%^1<- ^3ROWS";



#	These needed for Public Stats
main_psdistance = "^7Distance: ^2{0} ^7{1}";
main_psfinished = "^7Race finished: ^2{0}";
main_psfuel = "^7Fuel used: ^2{0} ^7litres ";
main_pslaps = "^7Laps done: ^2{0}";
main_pspole = "^7Poles done: ^2{0}";
main_psquals = "^7Qualifications done: ^2{0}";
main_pssecond = "^7Second: ^2{0}";
main_psthird = "^7Third: ^2{0}";
main_pswins = "^7Wins: ^2{0}";
main_close = "Close";

#	BUILT COMMANDS (Needed for Tables)
built_car = "Car";
built_grp = "Grp";
built_hand_curr = "  - Current {0}Kg - Intake Restr.: {1}%";
built_hand_nick = "^3{0}^9 handicap:";
built_hand_req =  "  - Required {0}^9 {1}Kg - Intake Rest.: {2}%";
built_lapsdone = " Laps Done";
built_nick = "NickName";
built_nolfspb = "LFS World PB not yet retreived";
built_nolfspbcrit = "No LFS World PB for this criteria";
built_pb = "Pb";
built_points = "Points";
built_pos = "Pos";
built_split = "Split";
built_splits = "Splits";
built_track = "Track";

EndLang


###	Language translations courtesy of GOOGLE Translate


# FRENCH LANGUAGE SECTION				
##########################				

Lang "FR"	
menu_menuname = "^7MENU SYSTEME%at%^7MENU SYSTEME%at%^6MENU SYSTEME%at%^6MENU SYSTEME";
menu_mainmenu = "^6MENU";
menu_userswitchboard = "^7L'UTILISATEUR DE TABLEAU";
menu_optionsname = "^7OPTIONS";
menu_aboutname = "^7A' PROPOS";
menu_helpname = "^7HELP";
menu_funname = "^7FUN";
menu_menuback = "^7< RETOUR";
menu_menuclose = "^7CLOSE";
menu_topblurb1 = "^6Configuration du Serveur";
menu_topblurb2 = "^7Mode: ^6Race / Drift%nl%^7Joignez-vous à la mi-course: ^6Admis%nl%^7Reset voiture: ^6Rejeté";
menu_bottomblurb1 = "^1Sin'rs%nl%^2(^1Sin^2anju^1'^2s ^1r^2acing ^1s^2erver)";
menu_bottomblurb2 = "^7InSim: ^6Sur la base de LFSLapper ^7v6.011%nl%^6personnalisé par ^4[^7><^4]^2S^3inanju";

menu_userpbs = "^6Tous vos meilleurs temps";  
menu_userlfswstats = "^6Votre LFSWorld Stats";  
menu_usercombostats = "^6Stats Combo de ce serveur";  
menu_usertops = "^6Top Times";
menu_userdrifts = "^6Dérives Haut"; 

menu_speedunittext = "^6Vitesse Unité";
menu_speedkphchange = "^7Vitesse Unité changé à ^6KPH";	  
menu_speedmphchange = "^7Vitesse Unité changé à ^6MPH";


#	QUIZ
menu_quiz = "^2QUIZ:%nl%^3Tapez le nom de l'une des%nl%^3fruits, légumes, planète, d'oiseaux,%nl%^3animal, snake, etc";
menu_answer = "^3RÃ©ponse Quiz:%nl%^2Je pense que c'est une%nl%%nl%nl%^7Tapez un autre mot%nl%^7pour essayer Ã  nouveau";
menu_answer1 = "^3RÃ©ponse Quiz:%nl%^2Je pense que c'est une%nl%%nl%nl%^7Tapez un autre mot%nl%^7pour essayer Ã  nouveau";
menu_fruit = "^4FRUITS";
menu_veg = "^4LEGUME";
menu_salad = "^4SALADE DE LEGUMES";
menu_planet = "^4PLANETE DANS NOTRE%nl%^4SYSTEME SOLAIRE";
menu_astro = "^4U TERME%nl%^4ASTRONOMIQUE";
menu_fish = "^4POISSON";
menu_fantasy = "^4FANTASIE SUR%nl%^4LES ANIMAUX ";
menu_animal = "^4ANIMAUX";
menu_nonspecific = "^2Quiz Question%nl%^2pas assez précis.%nl%%nl%^3Essayez un autre mot.";
menu_bird = "^4OISEAU";
menu_rodent = "^4RONGEURS";
menu_crustacean = "^4CRUSTACÉS";
menu_insect = "^4INSECTES";
menu_reptile = "^4REPTILE";
menu_parrot = "^4Est-ce%nl%^4perroquet défunt?";
menu_snake = "^4SERPENT";
menu_whale = "^4Mammifère qui%nl%^4vit dans la mer";                
menu_rainbow = "^3Réponse Quiz:%nl%%nl%^4L'ue des couleurs%nl%^4dans un arc en ciel";
menu_colour = "^3Réponse Quiz:%nl%%nl%^4Cette couleur%nl%^4rejetée par%nl%^4l'arc en ciel";

menu_combostatsname = "^6Combo Stats";
menu_combostatsdetails = "^7Classement: ^6{2}"
            . "%nl%^6{4} ^7PB Drift: ^6{3}"
            . "%nl%^7Track actuel: ^6{6}"
            . "%nl%^7Ce combo PB: ^6{7}"
            . "%nl%^7PB théorique: ^6{8}"
            . "%nl%^7Distance: ^6{9} ^7tours / ^6{10} ^7{11}";


	main_close = "Fermer";
	main_psdistance = "^7Distance: ^2{0} ^7{1}";
	main_psfuel = "^7Essence consommée: ^2{0} ^7liters ";
	main_pslaps = "^7Tours réalisés: ^2{0}";
	main_pswins = "^7Victoires: ^2{0}";
	main_pssecond = "^7Secondes places: ^2{0}";
	main_psthird = "^7Troisièmes places: ^2{0}";
	main_psfinished = "^7Courses termiée: ^2{0}";
	main_psquals = "^7Qualifications réalisées: ^2{0}";
	main_pspole = "^7Poles réalisées: ^2{0}";

	built_pos = "Position";
	built_grp = "Poule";
	built_car = "Voiture";
	built_track = "Circuit";
	built_nick = "Pseudo";
	built_pb = "PB";
	built_split = "Split";
	built_splits = "Splits";
	built_points = "Points";
	built_nolfspb = "Les record de LFS World ne sont pas encore récupérés";
	built_nolfspbcrit = "Pas de records LFS World pour ce critère";
	built_lapsdone = "Tours réalisés";
	built_hand_nick = "^9 Handicap pour ^3{0}^9 :";
	built_hand_curr = "  - Actuel {0}Kg - Restr. admission.: {1}%";
	built_hand_req =  "  - Requis {0}^9 {1}Kg - Restr. admission.: {2}%";

EndLang

# ITALIAN LANGUAGE SECTION				
##########################

Lang "IT"
menu_menuname = "^7MENU DI SISTEMA%at%^7MENU DI SISTEMA%at%^6MENU DI SISTEMA%at%^6MENU DI SISTEMA";
menu_mainmenu = "^6MENU";
menu_userswitchboard = "^7UTENTE CENTRALINO";
menu_optionsname = "^7OPZIONI";
menu_aboutname = "^7CHI";
menu_helpname = "^7HELP";
menu_funname = "^7FUN";
menu_menuback = "^7< RETRO";
menu_menuclose = "^7CHIUDI";
menu_topblurb1 = "^6Configurazione del server";
menu_topblurb2 = "^7ModalitÃ : ^6Razza / Drift%nl%^7Iscriviti a metÃ  gara: ^6Ammessi%nl%^7Auto Reset: ^6non consentito";

menu_userpbs = "^6Tutti i vostri record personali";  
menu_userlfswstats = "^6Il tuo LFSWorld Stats";  
menu_usercombostats = "^6Statistiche Combo di questo server";  
menu_usertops = "^6Top Times";
menu_userdrifts = "^6Drifts Top"; 
menu_speedunittext = "^6Unità velocità";
menu_speedkphchange = "^7Unità velocità cambiato ^6KPH";	  
menu_speedmphchange = "^7Unità velocità cambiato ^6MPH";



menu_bottomblurb1 = "^1Sin'rs%nl%^2(^1Sin^2anju^1'^2s ^1r^2acing ^1s^2erver)";
menu_bottomblurb2 = "^7InSim: ^6Basato su LFSLapper ^7v6.011%nl%^6personalizzato da ^4[^7><^4]^2S^3inanju";

menu_combostatsname = "^6Combo Stats";
menu_combostatsdetails = "^7Ranking: ^6{2}"
            . "%nl%^6{4} ^7Drift PB: ^6{3}"
            . "%nl%^7Traccia corrente: ^6{6}"
            . "%nl%^7Questo combo PB: ^6{7}"
            . "%nl%^7Teorica PB: ^6{8}"
            . "%nl%^7Distanza: ^6{9} ^7giri / ^6{10} ^7{11}";



menu_quiz = "^2QUIZ:%nl%^3Digitare il nome di una delle%nl%^3frutta, verdura, pianeta, uccello,%nl%^3animale, serpente, ecc";
menu_answer = "^3Quiz Risposta:%nl%^2Penso che Ã¨ una%nl%%nl%%nl%^7Digitare una parola%nl%^7per riprovare";
menu_answer1 = "^3Quiz Risposta:%nl%^2Credo che questo sia uno%nl%%nl%%nl%^7Digitare una parola%nl%^7per riprovare"; 
menu_fruit = "^4FRUTTA";
menu_veg = "^4VEGETALI";
menu_salad = "^4INSALATA DI VERDURE";
menu_planet = "^4PIANETA DEL NOSTRO%nl%^4SISTAMA SOLARE";
menu_astro = "^4UN TERMINE%nl%^4ASTRONOMICO";
menu_fish = "^4PESCE";
menu_fantasy = "^4FANTASY%nl%^4ANIMALI ";
menu_animal = "^4ANIMALI";
menu_nonspecific = "^2Quiz Domanda%nl%^non sufficientemente specifiche.%nl%%nl%^3Provare un'altra parola.";
menu_bird = "^4UCCELLO";
menu_rodent = "^4RODITORI";
menu_crustacean = "^4CROSTACEO";
menu_insect = "^4INSETTI";
menu_reptile = "^4RETTILE";
menu_parrot = "^4E 'questo%nl%^4pappagallo morto?";
menu_snake = "^4SERPENTE";
menu_whale = "^4Mammifero che%nl%^4vive nel mare";          
menu_rainbow = "^3Quiz Risposta:%nl%%nl%^4Uno dei colori%nl%^4in un arcobaleno";
menu_colour = "^3Quiz Risposta:%nl%%nl%^4Questo colore%nl%^4respinta dal%nl%^4arcobaleno";
                                                  
EndLang
 

# DUTCH LANGUAGE SECTION				
########################

Lang "NL"
menu_menuname = "^7MENU SYSTEEM%at%^7MENU SYSTEEM%at%^6MENU SYSTEEM%at%^6MENU SYSTEEM";
menu_mainmenu = "^6MENU";
menu_userswitchboard = "^7GEBRUIKER SCHAKELINSTALLATIE";
menu_optionsname = "^7OPTIES";
menu_aboutname = "^7OVER";
menu_helpname = "^7HELP";
menu_funname = "^7FUN";
menu_menuback = "^7< TERUG";
menu_menuclose = "^7CLOSE";
menu_topblurb1 = "^6Server Configuration";
menu_topblurb2 = "^7Mode: ^6Race / Drift%nl%^7Halverwege de race Join: ^6Toegestaan%nl%^7Auto Reset: ^6Verworpen";

menu_bottomblurb1 = "^1Sin'rs%nl%^2(^1Sin^2anju^1'^2s ^1r^2acing ^1s^2erver)";
menu_bottomblurb2 = "^7InSim: ^6Gebaseerd op LFSLapper ^7v6.011%nl%^6aangepast door ^4[^7><^4]^2S^3inanju";

menu_userpbs = "^6Al uw persoonlijke records";  
menu_userlfswstats = "^6Uw LFSWorld Stats";  
menu_usercombostats = "^6Deze server's Combo Stats";  
menu_usertops = "^6Terug naar boven Times";
menu_userdrifts = "^6Top Drifts"; 
menu_speedunittext = "^6Eenheid voor snelheid";
menu_speedkphchange = "^7Eenheid voor snelheid veranderd ^6KPH";	  
menu_speedmphchange = "^7Eenheid voor snelheid veranderd ^6MPH";

                                 
menu_combostatsname = "^6Combo Stats";
menu_combostatsdetails = "^7Ranking: ^6{2}"
            . "%nl%^6{4} ^7Drift PB: ^6{3}"
            . "%nl%^7Huidige Track: ^6{6}"
            . "%nl%^7Dit combo PB: ^6{7}"
            . "%nl%^7Theoretische PB: ^6{8}"
            . "%nl%^7Afstand: ^6{9} ^7ronden / ^6{10} ^7{11}";
            

menu_quiz = "^2QUIZ:%nl%^3Typ de naam van een van beide%nl%^3fruit, groenten, planeet, vogel,%nl%^3dier, slang, enz.";
menu_answer = "^3Quiz Antwoord:%nl%^2Ik denk dat dat een%nl%%nl%%nl%^7Type een ander woord%nl%^7Om opnieuw te proberen";
menu_answer1 = "^3Quiz Antwoord:%nl%^2Ik denk dat een%nl%%nl%%nl%^7Type een ander woord%nl%^7Om opnieuw te proberen"; 
menu_fruit = "^4FRUIT";
menu_veg = "^4PLANTAARDIGE";
menu_salad = "^4SALADES";
menu_planet = "^4PLANEET IN ONS%nl%^4ZONNESTELSEL";
menu_astro = "^4ASTRONOMISCHE%nl%^4TERM";
menu_fish = "^4FISH";
menu_fantasy = "^4FANTASIEDIER";
menu_animal = "^4DIEREN";
menu_nnonspecific = "^2Quizvraag%nl%^2niet specifiek genoeg.%nl%%nl%^3Probeer een ander woord.";
menu_bird = "^4VOGEL";
menu_rodent = "^4RODENT";
menu_crustacean = "^4SCHAALDIER";
menu_insect = "^4INSECT";
menu_reptile = "^4REPTIEL";
menu_parrot = "^4Is dat%nl^4papegaai overledene?";
menu_snake = "^4SLANG";
menu_whale = "^4Zoogdier dat%nl%^4leeft in de zee";
menu_rainbow = "^3Quiz Antwoord:%nl%%nl%^4Een van de kleuren%nl%^4in een regenboog";     
menu_colour = "^3Quiz Antwoord:%nl%%nl%^4Deze kleur%nl%^4verworpen door%nl%^4de regenboog";

 main_close = "Sluiten";
 main_psdistance = "^7Afstand: ^2{0} ^7{1}";
 main_psfuel = "^7Gebruikte brandstof: ^2{0} ^7Liter ";
 main_pslaps = "^7Gereden rondes: ^2{0}";
 main_pswins = "^7Gewonnen: ^2{0}";
 main_pssecond = "^7Tweede: ^2{0}";
 main_psthird = "^7Derde: ^2{0}";
 main_psfinished = "^7Aantal Races gefinisht: ^2{0}";
 main_psquals = "^7Aantal Kwalificaties gedaan: ^2{0}";
 main_pspole = "^7Aantal Poles: ^2{0}";
 built_car = "Auto";
 built_track = "Baan";
 built_points = "Punten";
 built_nolfspb = "LFS World PB nog niet ontvangen";
 built_nolfspbcrit = "Geen LFS World PB voor deze criteria";
 built_lapsdone = " Gereden rondes";
 built_hand_nick = "^3{0}^9 handicap:";
 built_hand_curr = "  - Toegevoegde massa: {0}Kg - Luchtinlaat beperking: {1}%";
 built_hand_req =  "  - Benodigd: {0}^9 {1}Kg toegevoegde massa - Luchtinlaat beperking: {2}%";
 

                                
EndLang



# NORVEGIAN LANGUAGE SECTION				
############################

Lang "NO"
menu_menuname = "^7MENYSYSTEMET%at%^7MENYSYSTEMET%at%^6MENYSYSTEMET%at%^6MENYSYSTEMET";
menu_mainmenu = "^6MENY";
menu_userswitchboard = "^7BRUKER BRYTERPANELET";
menu_optionsname = "^7ALTERNATIVER";
menu_aboutname = "^7OM";
menu_helpname = "^7HJELP";
menu_funname = "^7FUN";
menu_menuback = "^7< TILBAKE";
menu_menuclose = "^7LUKK";
menu_topblurb1 = "^6Server Konfigurasjon";
menu_topblurb2 = "^7Mode: ^6Race / Drift%nl%^7Midt Race Bli: ^6Tillatt%nl%^7Bil Reset: ^6Ikke tillatt";
menu_bottomblurb1 = "^1Sin'rs%nl%^2(^1Sin^2anju^1'^2s ^1r^2acing ^1s^2erver)";
menu_bottomblurb2 = "^7InSim: ^6Basert på LFSLapper ^7v6.011%nl%^6tilpasset av ^4[^7><^4]^2S^3inanju";
menu_quiz = "^2QUIZ:%nl%^3Skriv inn navnet på enten%nl%^3frukt, grønnsaker, planet, fugl,%nl%^3dyr, slange, etc.";
menu_answer = "^3Quiz Svar:%nl%^2Jeg tror det er en%nl%%nl%%nl%^7Skriv et annet ord%nl%^7å prøve igjen";
menu_answer1 = "^3Quiz Svar:%nl%^2Jeg tror det er en%nl%%nl%%nl%^7Skriv et annet ord%nl%^7å prøve igjen"; 
menu_fruit = "^4FRUKT";
menu_veg = "^4VEGETABILSK";
menu_salad = "^4SALAT VEGETABILSK";
menu_planet = "^4PLANETEN I VART%nl%^4SOLSYSTEM";
menu_astro = "^4BEGREP SOM%nl%^4BRUKES I ASTRONOMI";
menu_fish = "^4FISH";
menu_fantasy = "^4FANTASY%nl%^4ANIMAL ";
menu_animal = "^4ANIMAL";
menu_nonspecific = "^2Quiz Spørsmål%nl%^2Ikke spesifikk nok.%nl%%nl%^3Prøv et annet ord.";
menu_userpbs = "^6Alle personlige rekorder";  
menu_userlfswstats = "^6Din LFSWorld Stats";  
menu_usercombostats = "^6Dette Server's Combo Stats";  
menu_usertops = "^6Top Times";
menu_userdrifts = "^6Top Drifts"; 
menu_speedunittext = "^6Speed ??Unit";
menu_speedkphchange = "^7Speed ??Unit endret til ^6KPH";
menu_speedmphchange = "^7Speed ??Unit endret til ^6MPH";

menu_combostatsname = "^6Combo Stats";
menu_combostatsdetails = "^7Ranking: ^6{2}"
            . "%nl%^6{4} ^7Drift PB: ^6{3}"
            . "%nl%^7Gjeldende Spor: ^6{6}"
            . "%nl%^7Dette combo PB: ^6{7}"
            . "%nl%^7Teoretisk PB: ^6{8}"
            . "%nl%^7Avstand: ^6{9} ^7runder / ^6{10} ^7{11}";


menu_bird = "^4FUGL";
menu_rodent = "^4GNAGER";
menu_crustacean = "^4KREPSDYR";
menu_insect = "^4INSECT";
menu_reptile = "^4REPTIL";
menu_parrot = "^4Er tha papegøye avdøde?";
menu_snake = "^4SLANGE";
menu_whale = "^4Pattedyr som%nl%^4lever i sjøen";            
menu_rainbow = "^3Quiz Svar:%nl%%nl%^4En av fargene%nl%^4i en regnbue";
menu_colour = "^3Quiz Svar:%nl%%nl%^4Denne fargen%nl%^4avvist av%nl%^4regnbuen";


    main_close = "Avslutt";
    main_psdistance = "^7Distanse: ^2{0} ^7{1}";
    main_psfuel = "^7Drivstoff brukt: ^2{0} ^7liter";
    main_pslaps = "^7Runder gjort: ^2{0}";
    main_pswins = "^7Første plass: ^2{0}";
    main_pssecond = "^7Andre plass: ^2{0}";
    main_psthird = "^7Tredje plass: ^2{0}";
    main_psfinished = "^7Løp gjort: ^2{0}";
    main_psquals = "^7Kvalifisjoner gjort: ^2{0}";
    main_pspole = "^7Staver gjort: ^2{0}";
    
    built_pos = "Posisjon";
    built_grp = "Grp";
    built_car = "Bil";
    built_track = "Bane";
    built_nick = "Kallenavn";
    built_pb = "Banerekord";
    built_split = "Split";
    built_splits = "Splits";
    built_points = "Points";
    built_nolfspb = "LFS World banerekord er ikke mottatt enda";
    built_nolfspbcrit = "Ingen LFS World banerekord for denne bilen/banen";
    built_lapsdone = "Runder gjort";

                                           
EndLang

####	RACE CONTROL SYSTEM (V2)
####	==========================
####
####	For LFSLapper
####
####	Tested with V6.011 and V6.012
####
####	by Sinanju
####
####	(from an idea suggested by Jonathon.provost)
####
#########################################################################################
# Ver 0.1 - 27 April 2011 - Initial workup
# Ver 2.0 - 26 May 2011 - Rather than individual menu's, all laid out in single gui
#########################################################################################
# To Do: Maybe option of "remembering" if Pit Hud stays on/off depending on last used
#########################################################################################
# LFS TeamChat v1.01 by Krayy
# LFS !pm chat by Fire_optikz001 (and a variation of which was used to code penalties section)
#########################################################################################

CatchEvent OnLapperStart()

### Change the first 2 numbers if you want the HUD in different location

	GlobalVar $HUDorigL; $HUDorigL = 57;           # Left edge of main content window / button / label
	GlobalVar $HUDorigT; $HUDorigT = 0;            # Top edge of window / button / label
	GlobalVar $HUDWidth; $HUDWidth = 2;            # Width of Dialog box / window / button / label
	GlobalVar $HUDHeight; $HUDHeight = 4;          # ...height of row of text
	GlobalVar $HUDspacing; $HUDspacing = 1;        # ...height of spacing between text
	GlobalVar $HUDtime; $HUDtime = -1;             # display button for how many seconds (-1 = permanent)
	GlobalVar $HUDtime_alt; $HUDtime_alt = 5;      # display button for how many seconds

### This bit needed to switch HUD off or on
	GlobalVar $HUDoffon; $HUDoffon = "on";         # switched on as standard - has to be switched off

# Set TeamChat globals
	GlobalVar $tcDelimiterStart;
	GlobalVar $tcDelimiterEnd;
	
# Set the inital values to be square brackets (as used in team names) - change if team uses something else
	$tcDelimiterStart = "[";
	$tcDelimiterEnd = "]";
	
EndCatchEvent 


CatchEvent OnNameChange($userName,$oldNickName,$newNickName) # Player event
	 SetTeamName();
EndCatchEvent

CatchEvent OnMSO( $userName, $text ) # Player event
	$idxOfFirstSpace = indexOf( $text, " ");
	IF( $idxOfFirstSpace == -1 )
	THEN
	  $command = $text;
	  $argv = "";
	ELSE
	  $command = subStr( $text,0,$idxOfFirstSpace );
	  $argv = trim( subStr( $text,$idxOfFirstSpace ) );
	ENDIF

	SWITCH ( $command )
		CASE "!admin":  #	Words/Text needed to start Race Control Menu
			DoRCM(0,0);
		BREAK;
		
		CASE "!tc":
			TeamChat($argv);
   		BREAK;		
		
CASE "!pm":
	IF( $argv != "" )   THEN
		$idxSpace = indexOf( $argv, " ");
	IF( $idxSpace != -1 ) THEN
		$toUser = subStr( $argv,0,$idxSpace );
		$argv = trim( subStr( $argv,$idxSpace ) );
			privMsg ( "^6Ozel Mesaj ^8" . GetPlayerVar( $toUser , "Nickname" )  );
			privMsg ( "^7" . $argv );
			userMsg (GetCurrentPlayerVar( "Nickname" ), $toUser, $argv);
	ELSE
		privMsg ( "^7Komut ^2!pm <username> <message>" );
		privMsg ( "^7(Ornek: ^2!pm ABARTH SelamunAleykum^7)" );
	ENDIF
	ELSE
		privMsg ( "^7Komut: ^2!pm <username> <message>" );
	ENDIF
BREAK; 		
		
	ENDSWITCH
EndCatchEvent
            
Sub SetTeamName ( )
	$NickName = GetCurrentPlayerVar("NickName");
	$NickStrip = StripLFSColor( ToLower($NickName) );  
	$IdxStart = indexOf( $NickStrip , $tcDelimiterStart);  
	$IdxEnd = indexOf( $NickStrip , $tcDelimiterEnd);  

	IF ( $IdxStart == -1 || $IdxEnd == -1 )
	THEN
		$MyTeam = "";
	ELSE
	IF ( $IdxStart > $IdxEnd )
	THEN
		$MyTeam = "";
	ELSE
		$MyTeam = subStr( $NickStrip ,$IdxStart + 1, ($IdxEnd - $IdxStart) - 1  );
	ENDIF
	ENDIF
	
	IF ( $MyTeam == "" )
	THEN
		privMsg ("^7I am unable to find a valid Team Name in your NickName...");
		privMsg ("^7A Team name should be bracketed with a ^3" . $tcDelimiterStart . "^7 and a ^3" . $tcDelimiterEnd);
	ELSE
		privMsg ("^7Your nickame shows that you are in Team: ^3" . $MyTeam);
	ENDIF
	SetCurrentPlayerVar("TeamName",$MyTeam);
EndSub

Sub TeamChat ( $msg )
	$NickName = GetCurrentPlayerVar("NickName");
	$MyTeam = GetCurrentPlayerVar("TeamName");
	IF ( $MyTeam != "" )
	THEN
		$lop = GetListOfPlayers("N");
		FOREACH ( $de in $lop )
			$userName = $de["value"];
			IF ( GetPlayerVar($userName,"TeamName") == $MyTeam )
			THEN
				privMsg ( $userName, "^5TeamChat from ^8" . $NickName . "^5: ^8");
				privMsg ( $userName, "^6" . $msg );
			ENDIF
		ENDFOREACH
	ELSE
		privMsg ("You must have your Team name in your Nick to use TeamChat!");
	ENDIF
EndSub

Sub DoRCM( $KeyFlags,$id )
  closeButtonRegex (GetCurrentPlayerVar("UserName"), "rcm_*");
                                                                                                                                                                      
	IF ( UserIsAdmin( $userName ) == 1 )
	THEN
	
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_openrcm}%" ) );	
	
	openPrivButton( "rcm_back",34,49,26,39,6,-1,16,"" );
	openPrivButton( "rcm_front",35,51,24,34,6,-1,32,"" );
	openPrivButton( "rcm_menu",35,53,24,8,6,-1,0, langEngine( "%{rcm_menu}%"));
	openPrivButton( "rcm_by",35,66,24,4,5,2,0, langEngine( "%{rcm_by}%"));
	openPrivButton( "rcm_menumanager",35,71,24,5,5,-1,32, langEngine( "%{rcm_menumanager}%"),DoRCmenu);	
	openPrivButton( "rcm_closemenu",35,78,24,5,5,-1,32, langEngine( "%{rcm_closemenu}%"),DoRCclosemenu );
  	ELSE
	privMsg( langEngine( "%{rcm_notrcadmin}%" ) );
	ENDIF
EndSub
     
Sub DoRCclosemenu( $KeyFlags,$id )
  closeButtonRegex (GetCurrentPlayerVar("UserName"), "rcm_*");
EndSub
     
Sub DoRCmenu( $KeyFlags,$id )
  closeButtonRegex (GetCurrentPlayerVar("UserName"), "rcm_*");

	openPrivButton( "rcm_back",39,60,121,122,1,-1,16,"" );
	
	openPrivButton( "rcm_messagesback",40,71,29,110,1,-1,32,"" );
	openPrivButton( "rcm_trackback",70,71,29,110,1,-1,32,"" );
	openPrivButton( "rcm_penaltiesback",100,71,29,55,1,-1,32,"" );
  openPrivButton( "rcm_banback", 100,127,29,54,1,-1,32,"" );
  openPrivButton( "rcm_pitlaneoptback", 130,71,29,93,1,-1,32,"" );
# Headers  
  openPrivButton( "rcm_header",40,62,120,8,6,-1,0, langEngine( "%{rcm_rcmheader}%") );
	openPrivButton( "rcm_version",139,62,18,4,4,-1,128, langEngine( "%{rcm_rcmversionheader}%") );         	
	openPrivButton( "rcm_messages",40,71,29,6,5,-1,0, langEngine( "%{rcm_messagesheader}%") );
	openPrivButton( "rcm_track",70,71,29,6,5,-1,0, langEngine( "%{rcm_trackheader}%") );
	openPrivButton( "rcm_penalties",100,71,29,6,5,-1,0, langEngine( "%{rcm_penaltiesheader}%") );
	openPrivButton( "rcm_bans",100,127,29,6,5,-1,0, langEngine( "%{rcm_bansheader}%") );
  openPrivButton( "rcm_pitlaneopt", 130,71,29,6,5,-1,0, langEngine( "%{rcm_pitlaneheader}%") );
  
### Button Text
# Messages  
	openPrivButton( "rcm_privmsg",41,79,13,5,4,-1,0, langEngine( "%{rcm_privmsg}%") );
	openPrivButton( "rcm_teammsg",55,79,13,5,4,-1,0, langEngine( "%{rcm_teammsg}%") );
 	openPrivButton( "rcm_privrcm",41,96,13,5,4,-1,0, langEngine( "%{rcm_privrcm}%") );
	openPrivButton( "rcm_globrcm",55,96,13,5,4,-1,0, langEngine( "%{rcm_globrcm}%") );
	openPrivButton( "rcm_smessage1",41,115,13,5,5,-1,0, langEngine( "%{rcm_smessage1}%") ); # Welcome to server
	openPrivButton( "rcm_smessage2",55,115,13,5,5,-1,0, langEngine( "%{rcm_smessage2}%") ); # email address
	openPrivButton( "rcm_smessage3",41,132,13,5,5,-1,0, langEngine( "%{rcm_smessage3}%") ); # Any problems
	openPrivButton( "rcm_smessage4",55,132,13,5,5,-1,0, langEngine( "%{rcm_smessage4}%") ); # Admin Break
	openPrivButton( "rcm_smessage5",41,149,13,5,5,-1,0, langEngine( "%{rcm_smessage5}%") ); # Admin Rules
	openPrivButton( "rcm_message1",55,149,13,5,5,-1,0, langEngine( "%{rcm_message1}%") ); # Going Blind
	openPrivButton( "rcm_message2",41,166,13,5,5,-1,0, langEngine( "%{rcm_message2}%") ); # Crashing
	openPrivButton( "rcm_message3",55,166,13,5,5,-1,0, langEngine( "%{rcm_message3}%") ); # Accidents
# Track  	
	openPrivButton( "rcm_track_yellowflag",71,80,13,5,5,-1,0, langEngine( "%{rcm_yellowflag}%") );	
	openPrivButton( "rcm_track_greenflag",85,80,13,5,5,-1,0, langEngine( "%{rcm_greenflag}%") );
	openPrivButton( "rcm_track_blueflag",71,97,13,5,5,-1,0, langEngine( "%{rcm_blueflag}%") );	
	openPrivButton( "rcm_track_redflag",85,97,13,5,5,-1,0, langEngine( "%{rcm_redflag}%") );
	openPrivButton( "rcm_track_blackflag",71,115,13,5,5,-1,0, langEngine( "%{rcm_blackflag}%") );
	openPrivButton( "rcm_track_cheqflag",85,115,13,5,5,-1,0, langEngine( "%{rcm_cheqflag}%") );
	openPrivButton( "rcm_track_safetycar",71,132,13,5,5,-1,0, langEngine( "%{rcm_safetycar}%") );  	
	openPrivButton( "rcm_track_safetycarin",85,132,13,5,5,-1,0, langEngine( "%{rcm_safetycarin}%") );
	openPrivButton( "rcm_message4",71,149,13,5,5,-1,0, langEngine( "%{rcm_message4}%") ); # Race Shortly
	openPrivButton( "rcm_message5",85,149,13,5,5,-1,0, langEngine( "%{rcm_message5}%") ); # Qualy Shortly	
	openPrivButton( "rcm_pitallmessage",71,164,13,5,5,-1,0, langEngine( "%{rcm_pitall}%") ); 
	openPrivButton( "rcm_pitonemessage",85,164,13,5,5,-1,0, langEngine( "%{rcm_pitone}%") );
# Penalties
	openPrivButton( "rcm_30pen",101,80,13,5,5,-1,0, langEngine( "%{rcm_30pen}%") );
	openPrivButton( "rcm_45pen",115,80,13,5,5,-1,0, langEngine( "%{rcm_45pen}%") );	
	openPrivButton( "rcm_dtpen",101,92,13,5,5,-1,0, langEngine( "%{rcm_dtpen}%") );
	openPrivButton( "rcm_sgpen",115,92,13,5,5,-1,0, langEngine( "%{rcm_sgpen}%") );	
	openPrivButton( "rcm_specpen",101,105,13,5,5,-1,0, langEngine( "%{rcm_specpen}%") );
	openPrivButton( "rcm_kickpen",115,105,13,5,5,-1,0, langEngine( "%{rcm_kickpen}%") );
	openPrivButton( "rcm_clearpen",101,118,27,5,5,-1,0, langEngine( "%{rcm_clearpen}%") );
# Bans
	openPrivButton( "rcm_ban12",101,134,13,5,5,-1,0, langEngine( "%{rcm_ban12}%"));                   
	openPrivButton( "rcm_ban1",115,134,13,5,5,-1,0, langEngine( "%{rcm_ban1}%") );	
	openPrivButton( "rcm_ban7",101,147,13,5,5,-1,0, langEngine( "%{rcm_ban7}%") );
	openPrivButton( "rcm_ban30",115,147,13,5,5,-1,0, langEngine( "%{rcm_ban30}%") );	
	openPrivButton( "rcm_ban90", 101,160,13,5,5,-1,0, langEngine( "%{rcm_ban90}%") );
	openPrivButton( "rcm_ban999", 115,160,13,5,5,-1,0, langEngine( "%{rcm_ban999}%") );
	openPrivButton( "rcm_unbanpen",101,173,27,5,5,-1,0, langEngine( "%{rcm_unbanpen1}%") );
  
# Buttons (these are what you press to go to a sub-routine - the text sits underneath these buttons	
# Messages section                                                                                       
  openPrivButton( "rcm_mr1c1", 41,78,13,16,1,-1,16,"",DoRCprivmsg );
  openPrivButton( "rcm_mr1c2", 55,78,13,16,1,-1,16,"",DoRCteammsg );
  openPrivButton( "rcm_mr2c1", 41,95,13,16,1,-1,16,"",DoRCprivrcm );
  openPrivButton( "rcm_mr2c2", 55,95,13,16,1,-1,16,"",DoRCglobrcm);  
  openPrivButton( "rcm_mr3c1", 41,112,13,16,1,-1,16,"",DoRCsmess1 );
  openPrivButton( "rcm_mr3c2", 55,112,13,16,1,-1,16,"",DoRCsmess2 );  
  openPrivButton( "rcm_mr4c1", 41,129,13,16,1,-1,16,"",DoRCsmess3 );
  openPrivButton( "rcm_mr4c2", 55,129,13,16,1,-1,16,"",DoRCsmess4 );  
  openPrivButton( "rcm_mr5c1", 41,146,13,16,1,-1,16,"",DoRCsmess5 );
  openPrivButton( "rcm_mr5c2", 55,146,13,16,1,-1,16,"",DoRCmess1 ); 
  openPrivButton( "rcm_mr6c1", 41,163,13,16,1,-1,16,"",DoRCmess2 );
  openPrivButton( "rcm_mr6c2", 55,163,13,16,1,-1,16,"",DoRCmess3 );  
# Track section  	
  openPrivButton( "rcm_tr1c1", 71,78,13,16,1,-1,16,"",DoRCyellowflag );
  openPrivButton( "rcm_tr1c2", 85,78,13,16,1,-1,16,"",DoRCgreenflag );
  openPrivButton( "rcm_tr2c1", 71,95,13,16,1,-1,16,"",DoRCblueflag );
  openPrivButton( "rcm_tr2c2", 85,95,13,16,1,-1,16,"",DoRCredflag );  
  openPrivButton( "rcm_tr3c1", 71,112,13,16,1,-1,16,"",DoRCblackflag );
  openPrivButton( "rcm_tr3c2", 85,112,13,16,1,-1,16,"",DoRCcheqflag );  
  openPrivButton( "rcm_tr4c1", 71,129,13,16,1,-1,16,"",DoRCsafetycarout );
  openPrivButton( "rcm_tr4c2", 85,129,13,16,1,-1,16,"",DoRCsafetycarin );  
  openPrivButton( "rcm_tr5c1", 71,146,13,16,1,-1,16,"",DoRCmess4 );
  openPrivButton( "rcm_tr5c2", 85,146,13,16,1,-1,16,"",DoRCmess5 ); 
  openPrivButton( "rcm_tr6c1", 71,163,13,16,1,-1,16,"",DoRCDpitallPenalties );
  openPrivButton( "rcm_tr6c2", 85,163,13,16,1,-1,16,"",DoRCpitonepenalties );
# Penalties section
  openPrivButton( "rcm_pr1c1", 101,78,13,12,1,-1,16,"",DoRC30pen );
  openPrivButton( "rcm_pr1c2", 115,78,13,12,1,-1,16,"",DoRC45pen );
  openPrivButton( "rcm_pr2c1", 101,91,13,12,1,-1,16,"",DoRCdtpen );
  openPrivButton( "rcm_pr2c2", 115,91,13,12,1,-1,16,"",DoRCsgpen );  
  openPrivButton( "rcm_pr3c1", 101,104,13,12,1,-1,16,"",DoRCspecpen );
  openPrivButton( "rcm_pr3c2", 115,104,13,12,1,-1,16,"",DoRCkickpen );  
  openPrivButton( "rcm_pr4c1", 101,117,27,8,1,-1,32,"",DoRCclearpen );
# Ban section
  openPrivButton( "rcm_br1c1", 101,133,13,12,1,-1,16,"",DoRCban12 );
  openPrivButton( "rcm_br1c2", 115,133,13,12,1,-1,16,"",DoRCban1 );
  openPrivButton( "rcm_br2c1", 101,146,13,12,1,-1,16,"",DoRCban7 );
  openPrivButton( "rcm_br2c2", 115,146,13,12,1,-1,16,"",DoRCban30 );  
  openPrivButton( "rcm_br3c1", 101,159,13,12,1,-1,16,"",DoRCban90 );
  openPrivButton( "rcm_br3c2", 115,159,13,12,1,-1,16,"",DoRCban999 );  
  openPrivButton( "rcm_br4c1", 101,172,27,8,1,-1,32,"",DoRCunbanpen1 );

# Pitlane
	openPrivButton( "rcm_pithudback",131,78,27,27,1,-1,16,"" );
	openPrivButton( "rcm_pithudtext",131,80,27,5,5,-1,0, langEngine( "%{rcm_pithud}%") );

IF ( $HUDoffon == "on" )
THEN
# Left & Right Pit HUDs
	openPrivButton( "hud_penback",$HUDorigL,$HUDorigT,$HUDWidth+11,$HUDHeight+6,$HUDspacing,$HUDtime,32,"");
	openPrivButton( "hud_pentext",$HUDorigL,$HUDorigT,$HUDWidth+11,$HUDHeight,$HUDspacing+4,$HUDtime,0,langEngine("%{hud_pentext}%"));
	openPrivButton( "hud_penfront",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");	
	openPrivButton( "hud_pexback",$HUDorigL+73,$HUDorigT,$HUDWidth+11,$HUDHeight+6,$HUDspacing,$HUDtime,32,"");
	openPrivButton( "hud_pextext",$HUDorigL+73,$HUDorigT,$HUDWidth+11,$HUDHeight,$HUDspacing+4,$HUDtime,0,langEngine("%{hud_pextext}%"));	
	openPrivButton( "hud_pexfront",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");
  openPrivButton( "rcm_pithudentback", 131,107,27,27,1,-1,16,"" );
	openPrivButton( "rcm_pithudenttext",131,108,27,5,5,-1,0, langEngine( "%{rcm_pithudenttext}%") );
	openPrivButton( "rcm_pitenthudopen",131,119,9,5,5,-1,0, langEngine( "%{rcm_pithudopen}%") );
	openPrivButton( "rcm_pitenthudclosed",140,119,9,5,5,-1,0, langEngine( "%{rcm_pitthudclosed}%") );
	openPrivButton( "rcm_pitenthudclear",148,119,9,5,5,-1,0, langEngine( "%{rcm_pithudclear}%") ); 
  openPrivButton( "rcm_pithudexback", 131,136,27,27,1,-1,16,"" );
	openPrivButton( "rcm_pithudextext",131,137,27,5,5,-1,0, langEngine( "%{rcm_pithudextext}%") );    
	openPrivButton( "rcm_pitexhudopen",131,148,9,5,5,-1,0, langEngine( "%{rcm_pithudopen}%") );
	openPrivButton( "rcm_pitexhudclosed",140,148,9,5,5,-1,0, langEngine( "%{rcm_pitthudclosed}%") );	
	openPrivButton( "rcm_pitexhudclear",148,148,9,5,5,-1,0, langEngine( "%{rcm_pithudclear}%") );
  openPrivButton( "rcm_pithudr1c1", 132,114,8,15,1,-1,32,"",DoRCpenopen );  	
  openPrivButton( "rcm_pithudr1c2", 140,114,9,15,1,-1,32,"",DoRCpenclosed );
  openPrivButton( "rcm_pithudr1c3", 149,114,8,15,1,-1,32,"",DoRCpenclear );  	
  openPrivButton( "rcm_pithudr2c1", 132,143,8,15,1,-1,32,"",DoRCpexopen );
  openPrivButton( "rcm_pithudr2c2", 140,143,9,15,1,-1,32,"",DoRCpexclosed );  	
  openPrivButton( "rcm_pithudr2c3", 149,143,8,15,1,-1,32,"",DoRCpexclear ); 		
	openPrivButton( "rcm_pithudon",133,87,11,5,5,-1,32, langEngine( "%{rcm_pithudonalt}%") );
	openPrivButton( "rcm_pithudoff",145,87,11,5,5,-1,32, langEngine( "%{rcm_pithudoff}%"),DoRCpithudoff );	
ELSE
	openPrivButton( "rcm_pithudon",133,87,11,5,5,-1,32, langEngine( "%{rcm_pithudon}%"),DoRCpithudon );
	openPrivButton( "rcm_pithudoff",145,87,11,5,5,-1,32, langEngine( "%{rcm_pithudoffalt}%") );
ENDIF	

# Close whole menu
	openPrivButton( "rcm_closemenuback",130,164,29,17,5,-1,32,"");
	openPrivButton( "rcm_closemenu",131,165,27,5,5,-1,16, langEngine( "%{rcm_closemenux}%"),DoRCM );
EndSub

### MESSAGES SECTION
####################

Sub DoRCprivmsg( $KeyFlags,$id )
	closePrivButton ("rcm_instruct&rcm_privmsginst&rcm_closeinstruct&rcm_teammsginst&rcm_queryback&rcm_priv&rcm_closercm&rcm_global");
	openPrivButton( "rcm_instruct",70,20,60,6,5,-1,32, langEngine( "%{rcm_instruct}%"));
	openPrivButton( "rcm_privmsginst",70,26,60,6,5,-1,32, langEngine( "%{rcm_privmsginst}%"));
	openPrivButton( "rcm_closeinstruct",94,48,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCcloseinstruct );
EndSub

Sub DoRCteammsg( $KeyFlags,$id )
	closePrivButton ("rcm_instruct&rcm_privmsginst&rcm_closeinstruct&rcm_teammsginst&rcm_queryback&rcm_priv&rcm_closercm&rcm_global");
	openPrivButton( "rcm_instruct",60,20,80,6,5,-1,32, langEngine( "%{rcm_instruct}%"));
	openPrivButton( "rcm_teammsginst",60,26,80,5,4,-1,32, langEngine( "%{rcm_teammsginst}%"));
	openPrivButton( "rcm_closeinstruct",94,48,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCcloseinstruct );
EndSub

Sub DoRCprivrcm( $KeyFlags,$id )
	closePrivButton ("rcm_instruct&rcm_privmsginst&rcm_closeinstruct&rcm_teammsginst&rcm_queryback&rcm_priv&rcm_closercm&rcm_global");
	openPrivButton( "rcm_queryback",58,38,84,20,1,-1,16,"" );
	openPrivTextButton( "rcm_priv",60,40,80,7,20,32,"Admin Message","^7please click here to open chat window",90,GoRCMprivate );
	openPrivButton( "rcm_closeinstruct",94,50,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCcloseinstruct);
EndSub

Sub GoRCMprivate( $Admin Message,$text )
	closePrivButton ("rcm_instruct&rcm_privmsginst&rcm_closeinstruct&rcm_teammsginst&rcm_queryback&rcm_priv&rcm_closercm&rcm_global");
	privMsg( "^1Admin Message: ^6" . $text );
EndSub

Sub DoRCglobrcm( $KeyFlags,$id )
	closePrivButton ("rcm_instruct&rcm_privmsginst&rcm_closeinstruct&rcm_teammsginst&rcm_queryback&rcm_priv&rcm_closercm&rcm_global");
	openPrivButton( "rcm_queryback",58,38,84,20,1,-1,16,"" );
	openPrivTextButton( "rcm_global",60,40,80,7,20,32,"Admin Message","^7please click here to open chat window",90,GoRCMglobal );
	openPrivButton( "rcm_closeinstruct",94,50,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCcloseinstruct );
EndSub
 
Sub GoRCMglobal( $Admin Message,$text )
	closePrivButton ("rcm_instruct&rcm_privmsginst&rcm_closeinstruct&rcm_teammsginst&rcm_queryback&rcm_priv&rcm_closercm&rcm_global");
	GlobalRcm( "^1Admin: ^6" . $text );
EndSub

Sub DoRCcloseinstruct( $KeyFlags,$id )
	closePrivButton ("rcm_instruct&rcm_privmsginst&rcm_closeinstruct&rcm_teammsginst&rcm_queryback&rcm_priv&rcm_closercm&rcm_global");
EndSub

Sub DoRCsmess1( $KeyFlags,$id )
	$Host = getLapperVar( "HostName" );
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	openPrivButton( "rcm_smess",30,38,140,16,1,5,0, langEngine( "%{rcm_smess1}%"),$Host);
EndSub

Sub DoRCsmess2( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_smess2}%" ));
EndSub

Sub DoRCsmess3( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_smess3}%" ));
EndSub

Sub DoRCsmess4( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_smess4}%" ));
EndSub

Sub DoRCsmess5( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_smess5}%" ));
EndSub

Sub DoRCmess1( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_mess1}%" ));
EndSub

Sub DoRCmess2( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_mess2}%" ));
EndSub

Sub DoRCmess3( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_mess3}%" ));
EndSub

Sub DoRCmess4( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_mess4}%" ));
EndSub

Sub DoRCmess5( $KeyFlags,$id )
	closePrivButton ("rcm_queryback&rcm_instruct&rcm_closeinstruct&rcm_privmsginst&rcm_teammsginst");
	globalRcm( langEngine( "%{rcm_mess5}%" ));
EndSub
 

### TRACK SECTION
####################

Sub DoRCyellowflag( $KeyFlags,$id )
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");
	closeGlobalButton ("hud_trackstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5&hud_message");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5");
	globalRcm( langEngine( "%{rcm_yellowflagmessage}%" ));
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_yellowmessage}%" ) );	
  openGlobalButton( "hud_blinkleft",71,1,58,5,4,8,64 + 8,langEngine( "%{hud_blink_yellow}%" ));
	openGlobalButton( "hud_blinkright",71,1,58,5,4,8,128 + 8,langEngine( "%{hud_blink_yellow}%" ));     
EndSub

Sub DoRCgreenflag( $KeyFlags,$id )
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");
	closeGlobalButton ("hud_trackstatus&hud_pexstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5&hud_message");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5");
	globalRcm( langEngine( "%{hud_greenmessage}%" )); 
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_greenmessage}%" ) );	
	openGlobalButton( "hud_blinkleft",71,1,58,5,4,8,64 + 8,langEngine( "%{hud_blink_green}%" ));
	openGlobalButton( "hud_blinkright",71,1,58,5,4,8,128 + 8,langEngine( "%{hud_blink_green}%" ));

IF ( $HUDoffon == "on" )
THEN
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));  	
ENDIF	

EndSub

Sub DoRCblueflag( $KeyFlags,$id )
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");
	closeGlobalButton ("hud_trackstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5&hud_message");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5");
	globalRcm( langEngine( "%{rcm_blueflagmessage}%" ));
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_bluemessage}%" ) );   
  openGlobalButton( "hud_blinkleft",71,1,58,5,4,8,64 + 8,langEngine( "%{hud_blink_blue}%" ));
	openGlobalButton( "hud_blinkright",71,1,58,5,4,8,128 + 8,langEngine( "%{hud_blink_blue}%" ));      
EndSub
 
Sub DoRCredflag( $KeyFlags,$id )
	closeGlobalButton ("hud_trackstatus&hud_pexstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5&hud_message");
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");	
	globalRcm( langEngine( "%{rcm_redflagmessage}%" ));
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_redmessage}%" ) );
  openGlobalButton( "hud_blinkleft",71,1,58,5,4,8,64 + 8,langEngine( "%{hud_blink_red}%" ));
	openGlobalButton( "hud_blinkright",71,1,58,5,4,8,128 + 8,langEngine( "%{hud_blink_red}%" ));
  
IF ( $HUDoffon == "on" )
THEN
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusclosed}%")); 	
ENDIF      
EndSub
                                     
Sub DoRCblackflag( $KeyFlags,$id )
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");
	closeGlobalButton ("hud_trackstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5&hud_message");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5");
	globalRcm( langEngine( "%{rcm_blackflagmessage}%" ));
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_blackmessage}%" ) );	
  openGlobalButton( "hud_blinkleft",71,1,58,5,4,8,64 + 8,langEngine( "%{hud_blink_red}%" ));
	openGlobalButton( "hud_blinkright",71,1,58,5,4,8,128 + 8,langEngine( "%{hud_blink_red}%" ));
IF ( $HUDoffon == "on" )
THEN
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusclosed}%")); 	
ENDIF        
EndSub

Sub DoRCcheqflag( $KeyFlags,$id )
	closeGlobalButton ("hud_trackstatus&hud_pexstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5&hud_message");
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");	
	globalRcm( langEngine( "%{rcm_chequeredflag}%" )); 
	openGlobalButton( "rcm_backflag",92,64,15,16,1,6,32," "); # backing for whole flag
  openGlobalButton( "rcm_contrast",92,64,15,16,1,6,16," "); # backing for contrast
  openGlobalButton( "rcm_contrast2",92,64,15,16,1,6,16," "); # another layer for contrast
  openGlobalButton( "rcm_bl_bsr1",95,64,3,4,1,6,32," "); # first of little black squares on flag
  openGlobalButton( "rcm_bl_bsr2",92,68,3,4,1,6,32," ");
  openGlobalButton( "rcm_bl_bsr3",95,72,3,4,1,6,32," ");
  openGlobalButton( "rcm_bl_bsr4",92,76,3,4,1,6,32," ");
  openGlobalButton( "rcm_bl_bsr5",101,64,3,4,1,6,32," ");
  openGlobalButton( "rcm_bl_bsr6",98,68,3,4,1,6,32," ");
  openGlobalButton( "rcm_bl_bsr7",101,72,3,4,1,6,32," ");
  openGlobalButton( "rcm_bl_bsr8", 98,76,3,4,1,6,32," "); 
  openGlobalButton( "rcm_bl_bsr9",104,68,3,4,1,6,32," ");
 	openGlobalButton( "rcm_bl_bsr0",104,76,3,4,1,6,32," ");
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_trackstatuscheq}%" ) ); 	
	openGlobalButton( "hud_blinkleftback",$HUDorigL+12,$HUDorigT+39,$HUDWidth+2,$HUDHeight+8,$HUDspacing+1,$HUDtime_alt,16,"");	
	openGlobalButton( "hud_blinkleft",$HUDorigL+12,$HUDorigT+39,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,16,"");
	openGlobalButton( "hud_blinkleft1",$HUDorigL+14,$HUDorigT+39,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,32,"");
	openGlobalButton( "hud_blinkleft2",$HUDorigL+14,$HUDorigT+43,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,16,"");
	openGlobalButton( "hud_blinkleft3",$HUDorigL+12,$HUDorigT+43,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,32,"");  
 	openGlobalButton( "hud_blinkleft4",$HUDorigL+12,$HUDorigT+47,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,16,"");
	openGlobalButton( "hud_blinkleft5",$HUDorigL+14,$HUDorigT+47,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,32,"");
  openGlobalButton( "hud_blinkleftback",$HUDorigL+70,$HUDorigT+39,$HUDWidth+2,$HUDHeight+8,$HUDspacing+1,$HUDtime_alt,16,"");	
 	openGlobalButton( "hud_blinkright",$HUDorigL+70,$HUDorigT+39,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,16,"");
 	openGlobalButton( "hud_blinkright1",$HUDorigL+72,$HUDorigT+39,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,32,"");
	openGlobalButton( "hud_blinkright2",$HUDorigL+72,$HUDorigT+43,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,16,""); 	
	openGlobalButton( "hud_blinkright3",$HUDorigL+70,$HUDorigT+43,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,32,"");
	openGlobalButton( "hud_blinkright4",$HUDorigL+70,$HUDorigT+47,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,16,"");
	openGlobalButton( "hud_blinkright5",$HUDorigL+72,$HUDorigT+47,$HUDWidth,$HUDHeight,$HUDspacing+1,$HUDtime_alt,32,""); 
  
IF ( $HUDoffon == "on" )
THEN
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusclosed}%"));	
ENDIF
  	 	
EndSub

Sub DoRCsafetycarout( $KeyFlags,$id )
	closeGlobalButton ("hud_trackstatus&hud_pexstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5&hud_message");
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");	
	globalRcm( langEngine( "%{rcm_safetycarmessageout}%" ));
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_trackstatussafetyout}%" ) ); 
  openGlobalButton( "hud_blinkleft",71,1,58,5,4,8,64 + 8,langEngine( "%{hud_blink_white}%" ));
	openGlobalButton( "hud_blinkright",71,1,58,5,4,8,128 + 8,langEngine( "%{hud_blink_white}%" ));
  
IF ( $HUDoffon == "on" )
THEN
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusclosed}%")); 	
ENDIF  
EndSub

Sub DoRCsafetycarin( $KeyFlags,$id )
	closeGlobalButton ("hud_trackstatus&hud_pexstatus&hud_blinkleft&hud_blinkleft1&&hud_blinkleft2&&hud_blinkleft3&&hud_blinkleft4&&hud_blinkleft5");
	closeGlobalButton ("hud_blinkright&hud_blinkright1&hud_blinkright2&hud_blinkright3&hud_blinkright4&hud_blinkright5&hud_message");
	closeGlobalButton ("rcm_backflag&rcm_contrast&rcm_contrast2&rcm_bl_bsr1&rcm_bl_bsr2&rcm_bl_bsr3&rcm_bl_bsr4&rcm_bl_bsr5&rcm_bl_bsr6&rcm_bl_bsr7&rcm_bl_bsr8&rcm_bl_bsr9&rcm_bl_bsr0");	
	globalRcm( langEngine( "%{rcm_safetycarmessagein}%" ));
	openGlobalButton( "hud_message",74,1,52,5,4,8,0,langEngine( "%{hud_trackstatussafetyin}%" ) ); 
  openGlobalButton( "hud_blinkleft",71,1,58,5,4,8,64 + 8,langEngine( "%{hud_blink_white}%" ));
	openGlobalButton( "hud_blinkright",71,1,58,5,4,8,128 + 8,langEngine( "%{hud_blink_white}%" ));
  
IF ( $HUDoffon == "on" )
THEN
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%")); 	
ENDIF  
EndSub

Sub DoRCDpitallPenalties( $KeyFlags,$id ) # Pit everyone on track
	closePrivButton ("rcm_pitqueryback&rcm_pitpenallmessage&rcm_pitqueryq");
	
	openPrivButton( "rcm_pitqueryback",82,25,36,30,1,-1,16,"" );
	openPrivButton( "rcm_pitqueryq",83,26,34,5,5,-1,0,langEngine( "%{rcm_pitqueryq}%") );
	openPrivButton( "rcm_pitquery",83,32,34,9,3,-1,16,langEngine( "%{rcm_pitquery}%") );
	openPrivButton( "rcm_pitqueryyes",86,42,12,7,2,-1,32,langEngine( "%{rcm_pitqueryyes}%"),DoRCpitallyes );
	openPrivButton( "rcm_pitqueryno",102,42,12,7,2,-1,32,langEngine( "%{rcm_pitqueryno}%"),DoRCpitallno );
EndSub

Sub DoRCpitallyes( $KeyFlags,$id )
	closePrivButton ("rcm_pitqueryback&rcm_pitpenallmessage&rcm_pitqueryback&rcm_pitquery&rcm_pitqueryyes&rcm_pitqueryno&rcm_pitqueryq");
  cmdLFS( "/pit_all"); 	
EndSub

Sub DoRCpitallno( $KeyFlags,$id )
	closePrivButton ("rcm_pitqueryback&rcm_pitpenallmessage&rcm_pitqueryback&rcm_pitquery&rcm_pitqueryyes&rcm_pitqueryno&rcm_pitqueryq");
EndSub 

Sub DoRCpitonepenalties( $KeyFlags,$id ) # Only pit specific player
	closePrivButton ("rcm_pitpenonemessage");

	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_pitqueryone",60,35,80,7,20,32,"^7NICKNAME ^0of driver to be pitted is","^7Click here to enter ^2NICKNAME ^7of driver to be pitted",70,Applypitone );
	openPrivButton( "rcm_closepitquery",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepitquery );	
EndSub	
	
Sub Applypitone( $NICKNAME of driver to be pitted is,$text )	
	closePrivButton ("rcm_pitpenonemessage&rcm_penqueryback&rcm_pitqueryone&rcm_closepitquery");
	privRCM("^6". $text ." ^7has been pitted by Admin");
	globalMsg("^6". $text ." ^7has been pitted by Admin");	  
  cmdLFS( "/pitlane " . $text );  	
EndSub

Sub DoRCclosepitquery( $KeyFlags,$id )
	closePrivButton ("rcm_pitpenonemessage&rcm_penqueryback&rcm_pitqueryone&rcm_closepitquery");
EndSub



### PENALTIES SECTION
#####################       

Sub DoRC30pen( $KeyFlags,$id )# 30 sec penalty
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );	
  openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given ^130 second ^7penalty",70,Apply30penalty );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub
   
Sub Apply30penalty( $NICKNAME of offender is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^130 second ^7penalty");
	globalMsg("^6". $text ." ^7has been given ^130 second ^7penalty");		
  cmdLFS( "/p_30 " . $text ); 	
EndSub  

Sub DoRC45pen( $KeyFlags,$id )# 45 sec penalty
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given ^145 second ^7penalty",70,Apply45penalty );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub
   
Sub Apply45penalty( $NICKNAME of offender is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^145 second ^7penalty");
	globalMsg("^6". $text ." ^7has been given ^145 second ^7penalty");		
  cmdLFS( "/p_45 " . $text ); 	
EndSub     

Sub DoRCdtpen( $KeyFlags,$id )# Drive Through penalty
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );	
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given ^1DT ^7penalty",70,Applydtpenalty );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub
   
Sub Applydtpenalty( $NICKNAME of offender is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^1DRIVE THROUGH ^7penalty");
	globalMsg("^6". $text ." ^7has been given ^1DRIVE THROUGH ^7penalty");		
  cmdLFS( "/p_dt " . $text ); 	
EndSub

Sub DoRCsgpen( $KeyFlags,$id )# Stop and Go penalty
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );	
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given ^1SG ^7penalty",70,Applysgpenalty );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub
   
Sub Applysgpenalty( $NICKNAME of offender is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^1STOP and GO ^7penalty");
	globalMsg("^6". $text ." ^7has been given ^1STOP and GO ^7penalty");		
  cmdLFS( "/p_sg " . $text ); 	
EndSub

Sub DoRCspecpen( $KeyFlags,$id )# Spectate penalty
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );	
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given ^1spec ^7penalty",70,Applyspecpenalty );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub
   
Sub Applyspecpenalty( $NICKNAME of offender is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^1SPECTATE ^7penalty");
	globalMsg("^6". $text ." ^7has been given ^1SPECTATE ^7penalty");		
  cmdLFS( "/spec " . $text ); 	
EndSub

Sub DoRCkickpen( $KeyFlags,$id )# Kick penalty
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );	
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given ^1kick ^7penalty",70,Applykickpenalty );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub
   
Sub Applykickpenalty( $NICKNAME of offender is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been ^1KICKED ^7from server");
	globalMsg("^6". $text ." ^7has been ^1KICKED ^7from server");	
  cmdLFS( "/kick " . $text ); 	
EndSub 

Sub DoRCclearpen( $KeyFlags,$id )# Kick penalty
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to have penalty ^3CLEARED",70,Applyclearpenalty );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub

Sub Applyclearpenalty( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privRCM("^6". $text ." ^7has had their penalty ^2CLEARED");
	globalMsg("^6". $text ." ^7has had their penalty ^2CLEARED");	
  cmdLFS( "/p_clear " . $text ); 	
EndSub 

Sub DoRCclosepenalty( $KeyFlags,$id )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
EndSub

### BAN SECTION
###############

Sub DoRCban12 ( $KeyFlags,$id )
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
  openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given a ^112 hour ^7ban",70,Applyban12 );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub   

Sub Applyban12 ( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^112 hour ban ^7from server");
	globalMsg("^6". $text ." ^7has been given ^112 hour ban ^7from server");	
  cmdLFS( "/ban " . $text. " 0" );	#	ban user X for Y days (if Y = 0, then 0 = 12hrs)
EndSub

Sub DoRCban1 ( $KeyFlags,$id  )
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given a ^11 day ^7ban",70,Applyban1 );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub         

Sub Applyban1 ( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^11 day ban ^7from server");
	globalMsg("^6". $text ." ^7has been given ^11 day ban ^7from server");	
cmdLFS( "/ban " . $text. " 1" );
EndSub

Sub DoRCban7 ( $KeyFlags,$id )
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given a ^17 day ^7ban",70,Applyban7 );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub

Sub Applyban7 ( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^17 day ban ^7from server");
	globalMsg("^6". $text ." ^7has been given ^17 day ban ^7from server");	
cmdLFS( "/ban " . $text. " 7" );
EndSub

Sub DoRCban30 ( $KeyFlags,$id )
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given a ^130 day ^7ban",70,Applyban30 );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub

Sub Applyban30 ( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^130 day ban ^7from server");
	globalMsg("^6". $text ." ^7has been given ^130 day ban ^7from server");	
cmdLFS( "/ban " . $text. " 30" );
EndSub

Sub DoRCban90 ( $KeyFlags,$id )
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given a ^190 day ^7ban",70,Applyban90 );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub 

Sub Applyban90 ( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^190 day ban ^7from server");
	globalMsg("^6". $text ." ^7has been given ^190 day ban ^7from server");	
cmdLFS( "/ban " . $text. " 90" );
EndSub 

Sub DoRCban999( $KeyFlags,$id )
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7NICKNAME ^0of driver is","^7Click here to enter ^2NICKNAME ^7of driver to be given a ^1999 day ^7ban",70,Applyban999 );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub       

Sub Applyban999 ( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");
	privMsg( "^1Offender NickName:^7 " . $text );
	privRCM("^6". $text ." ^7has been given ^1999 day ban ^7from server");
	globalMsg("^6". $text ." ^7has been given ^1999 day ban ^7from server");	
cmdLFS( "/ban " . $text. " 999" );
EndSub

Sub DoRCunbanpen1( $KeyFlags,$id )# Unban
	openPrivButton( "rcm_penqueryback",58,33,84,19,1,-1,16,"" );
	openPrivTextButton( "rcm_penquery",60,35,80,7,20,32,"^7KULLANICI ^0ADINI YAZ","^7Ban Kaldirmek icin Buraya Tikla ! ",70,Applyunbanpenalty1 );
	openPrivButton( "rcm_closepenmess",94,44,12,6,5,-1,16, langEngine( "%{rcm_closemenu}%"),DoRCclosepenalty );
EndSub
   
Sub Applyunbanpenalty1( $NICKNAME of driver is,$text )
	closePrivButton ("rcm_penqueryback&rcm_penquery&rcm_closepenmess");	
	privRCM("^6". $text ." ^7has been ^2UNBANNED ^7from server");
	globalMsg("^6". $text ." ^7has been ^2UNBANNED ^7from server");	
  cmdLFS( "/unban " . $text ); 	
EndSub



### HUD SECTION
###############

# Pit HUD Off/On

Sub DoRCpithudon( $KeyFlags,$id )

	$HUDoffon = "on";

	closePrivButton ("hud_penback&hud_pentext&hud_penfront&hud_pexback&hud_pextext&hud_pexfront");
  
  openPrivButton( "rcm_pithudon",133,87,11,5,5,-1,32, langEngine( "%{rcm_pithudonalt}%") );
	openPrivButton( "rcm_pithudoff",145,87,11,5,5,-1,32, langEngine( "%{rcm_pithudoff}%"),DoRCpithudoff );	
	openPrivButton( "hud_penback",$HUDorigL,$HUDorigT,$HUDWidth+11,$HUDHeight+6,$HUDspacing,$HUDtime,32,"");
	openPrivButton( "hud_pentext",$HUDorigL,$HUDorigT,$HUDWidth+11,$HUDHeight,$HUDspacing+4,$HUDtime,0,langEngine("%{hud_pentext}%"));
	openPrivButton( "hud_penfront",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");	
	openPrivButton( "hud_pexback",$HUDorigL+73,$HUDorigT,$HUDWidth+11,$HUDHeight+6,$HUDspacing,$HUDtime,32,"");
	openPrivButton( "hud_pextext",$HUDorigL+73,$HUDorigT,$HUDWidth+11,$HUDHeight,$HUDspacing+4,$HUDtime,0,langEngine("%{hud_pextext}%"));	
	openPrivButton( "hud_pexfront",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");
  openPrivButton( "rcm_pithudentback", 131,107,27,27,1,-1,16,"" );
	openPrivButton( "rcm_pithudenttext",131,108,27,5,5,-1,0, langEngine( "%{rcm_pithudenttext}%") );
	openPrivButton( "rcm_pitenthudopen",131,119,9,5,5,-1,0, langEngine( "%{rcm_pithudopen}%") );
	openPrivButton( "rcm_pitenthudclosed",140,119,9,5,5,-1,0, langEngine( "%{rcm_pitthudclosed}%") );
	openPrivButton( "rcm_pitenthudclear",148,119,9,5,5,-1,0, langEngine( "%{rcm_pithudclear}%") );
  openPrivButton( "rcm_pithudexback", 131,136,27,27,1,-1,16,"" );
	openPrivButton( "rcm_pithudextext",131,137,27,5,5,-1,0, langEngine( "%{rcm_pithudextext}%") );   
	openPrivButton( "rcm_pitexhudopen",131,148,9,5,5,-1,0, langEngine( "%{rcm_pithudopen}%") );
	openPrivButton( "rcm_pitexhudclosed",140,148,9,5,5,-1,0, langEngine( "%{rcm_pitthudclosed}%") );	
	openPrivButton( "rcm_pitexhudclear",148,148,9,5,5,-1,0, langEngine( "%{rcm_pithudclear}%") );
  openPrivButton( "rcm_pithudr1c1", 132,114,8,15,1,-1,32,"",DoRCpenopen );  	
  openPrivButton( "rcm_pithudr1c2", 140,114,9,15,1,-1,32,"",DoRCpenclosed );
  openPrivButton( "rcm_pithudr1c3", 149,114,8,15,1,-1,32,"",DoRCpenclear );  	
  openPrivButton( "rcm_pithudr2c1", 132,143,8,15,1,-1,32,"",DoRCpexopen );
  openPrivButton( "rcm_pithudr2c2", 140,143,9,15,1,-1,32,"",DoRCpexclosed );  	
  openPrivButton( "rcm_pithudr2c3", 149,143,8,15,1,-1,32,"",DoRCpexclear );
  
IF ( $HUDoffon == "on" )
THEN
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");  	
ENDIF	   
  	
EndSub

Sub DoRCpithudoff( $KeyFlags,$id )

	$HUDoffon = "off";
	closePrivButton ("hud_penback&hud_pentext&hud_penfront&hud_pexback&hud_pextext&hud_pexfront&hud_penstatus&hud_pexstatus");
  closePrivButton ("rcm_pithudr1c1&rcm_pithudr1c2&rcm_pithudr1c3&rcm_pithudr2c1&rcm_pithudr2c2&rcm_pithudr2c3");
  closePrivButton ("rcm_pithudentback&rcm_pithudenttext&rcm_pitenthudopen&rcm_pitenthudclosed&rcm_pitenthudclear");
  closePrivButton ("rcm_pithudexback&rcm_pithudextext&rcm_pitexhudopen&rcm_pitexhudclosed&rcm_pitexhudclear");
  
	openPrivButton( "rcm_pithudon",133,87,11,5,5,-1,32, langEngine( "%{rcm_pithudon}%"),DoRCpithudon );
	openPrivButton( "rcm_pithudoff",145,87,11,5,5,-1,32, langEngine( "%{rcm_pithudoffalt}%") );
 		
EndSub

Sub DoRCpenclear( $KeyFlags,$id )
IF ( $HUDoffon == "on" )
THEN
	closeGlobalButton ("hud_penstatus");
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");
ENDIF	
EndSub

Sub DoRCpexclear( $KeyFlags,$id )
IF ( $HUDoffon == "on" )
THEN
	closeGlobalButton ("hud_pexstatus");
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,"");
ENDIF	
EndSub

Sub DoRCpenopen( $KeyFlags,$id )
IF ( $HUDoffon == "on" )
THEN
	closeGlobalButton ("hud_penstatus");
	globalRcm( langEngine( "%{rcm_penopenmsg}%" ) );
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
ELSE
	closePrivButton ("hud_penback&hud_pentext&hud_penfront&hud_pexback&hud_pextext&hud_pexfront");  	
ENDIF	
EndSub

Sub DoRCpexopen( $KeyFlags,$id )
IF ( $HUDoffon == "on" )
THEN
	closeGlobalButton ("hud_pexstatus");
	globalRcm( langEngine( "%{rcm_pexopenmsg}%" ) );
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusopen}%"));
ELSE
	closePrivButton ("hud_penback&hud_pentext&hud_penfront&hud_pexback&hud_pextext&hud_pexfront");	
ENDIF	
EndSub

Sub DoRCpenclosed( $KeyFlags,$id )
IF ( $HUDoffon == "on" )
THEN
	closeGlobalButton ("hud_penstatus");
	globalRcm( langEngine( "%{rcm_penclosedmsg}%" ) );
	openGlobalButton( "hud_penstatus",$HUDorigL+1,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusclosed}%"));	
ELSE
	closePrivButton ("hud_penback&hud_pentext&hud_penfront&hud_pexback&hud_pextext&hud_pexfront");	
ENDIF	
EndSub

Sub DoRCpexclosed( $KeyFlags,$id )
IF ( $HUDoffon == "on" )
THEN
	closeGlobalButton ("hud_pexstatus");
	globalRcm( langEngine( "%{rcm_pexclosedmsg}%" ) );
	openGlobalButton( "hud_pexstatus",$HUDorigL+74,$HUDorigT+4,$HUDWidth+9,$HUDHeight,$HUDspacing,$HUDtime,16,langEngine( "%{hud_pstatusclosed}%"));
ELSE
	closePrivButton ("hud_penback&hud_pentext&hud_penfront&hud_pexback&hud_pextext&hud_pexfront");  	
ENDIF	
EndSub

# English Language Section
##########################

Lang "EN"
rcm_30pen = "^030%nl%^3Saniye";
rcm_45pen = "^045%nl%^3Saniye";
rcm_ban1 = "^01%nl%^3Gun";
rcm_ban12 = "^012%nl%^3Saat";
rcm_ban30 = "^030%nl%^3Guns";
rcm_ban7 = "^07%nl%^3Gun";
rcm_ban90 = "^090%nl%^3Gun";
rcm_ban999 = "^0999%nl%^3Gun";
rcm_bansheader = "^7BAN ^0BUTONU";
rcm_blackflag = "^0Siyah%nl%^0Bayrak";
rcm_blackflagmessage = "^0!! BLACK FLAG !! RACE STOPPED !!";
rcm_blueflag = "^4Blue%nl%^4Flag";
rcm_blueflagmessage = "^4BLUE FLAG - LET LEADER(S) THROUGH";
rcm_by = "^8Yasin Mert";
rcm_cheqflag = "^0Chequered%nl%^0Flag";
rcm_cheqflagmessage = "^0Chequered Flag";
rcm_chequeredflag = "^0CHEQUERED FLAG";
rcm_clearpen = "^2Ceza ^3Kaldirma ^2Butonu";
rcm_closemenu = "^1KAPAT";
rcm_closemenux = "%nl%^7Menuyu Kapat [ ^1X ^7]%nl%";
rcm_dtpen = "^0Pit%nl%^7Ceza";
rcm_globrcm = "^7Ekrana%nl%^3Yazi%nl%^7Yazdir";
rcm_greenflag = "^2Green%nl%^2Flag";
rcm_instruct = "^2Mesaj^7 Sistemleri";
rcm_kickpen = "^7Izleyiciye%nl%^0at";
rcm_menu = "^7SUNUCU KONTROL%nl%^0PANELI";
rcm_menumanager = "^2Paneli AC";
rcm_mess1 = "^7Özel Mesaj Sistemi Aktif ^2!mesaj ^7Komutunu Kullanın^0.";	
rcm_mess2 = "^3Shift S ^2or ^3Shift P ^2to get out of everyone's way.";	
rcm_mess3 = "^2The race will start shortly";	
rcm_mess4 = "^2Qualifying will start shortly";
rcm_message1 = "^2Özel%nl%^2Mesaj";
rcm_message2 = "^4Face%nl%^0Grup";
rcm_message3 = "^7Iyı Oyunlar%nl%^2Mesaji";
rcm_message4 = "^7Race%nl%^7shortly";
rcm_message5 = "^7Qualy%nl%^7shortly";
rcm_messagesheader = "^6MESAJ";
rcm_penaltiesheader = "^0CEZA ^7VER";
rcm_penclosedmsg = "^3Pitlane Entrance ^1KAPATd";
rcm_penopenmsg = "^3Pitlane Entrance ^2AC";
rcm_pexclosedmsg = "^3Pitlane Cikis ^1KAPATd";
rcm_pexopenmsg = "^3Pitlane Cikis ^2AC";
rcm_pitall = "^7Herkezi%nl%^0Pite%nl%7At";
rcm_pithud = "^3Pit Giris & Cikis";
rcm_pithudenttext = "^3Giris";
rcm_pithudextext = "^3Cıkis";
rcm_pithudoff = "%nl%^1OFF%nl%";
rcm_pithudoffalt = "%nl%off%nl%";
rcm_pithudon = "%nl%^2ON%nl%";
rcm_pithudonalt = "%nl%on%nl%";
rcm_pithudopen = "^2AC";
rcm_pitthudclosed = "^0KAPAT";	
rcm_pithudclear = "^7CLEAR";
rcm_pitlaneheader = "^6PITLANE";
rcm_pitone = "^7Oyuncuyu%nl%^0Pite At";
rcm_pitpenone = "^7Oyuncuyu%nl%^3Pite At";
rcm_pitquery = "^0Herkez Pite Atilsin mi ?";
rcm_pitqueryq = "^7Pite Gönderme Butonu";
rcm_pitqueryyes = "%nl%^2Evet%nl%";
rcm_pitqueryno = "%nl%^0HAYIR%nl%";
rcm_privmsg = "^3Özel%nl%^7Mesaj";
rcm_privmsginst = "^7Mesaj Bölümüne%nl%^2!mesaj ^7Yazarak %nl%^7özel mesajlarinizi gönderebilirsiniz,";
rcm_privrcm = "^7Admin%nl%^3Konusmasi";
rcm_rcmheader = "^7Admin ^0Kontrol^7Paneli";
rcm_rcmversionheader = "^8TalhaTIGCI";
rcm_redflag = "^1Red%nl%^1Flag";
rcm_redflagmessage = "^1!! RED FLAG !! SESSION SUSPENDED !!";
rcm_safetycar = "^3Safety Car%nl%^1OUT";
rcm_safetycarin = "^3Safety Car%nl%^2IN";
rcm_safetycarmessagein = "^7!! SAFETY CAR ^1IN ^7THIS LAP !!";
rcm_safetycarmessageout = "^7!! SAFETY CAR DEPLOYED !!";
rcm_sgpen = "^7Stop%nl%^7n Go";
rcm_smess1 = "^7Servere Hosgeldiniz";	
rcm_smess2 = "^7Küfür^1/^7 Fly^1/^7 Flood^1/^7 Crash Yasaktir";	
rcm_smess3 = "^7Sikayetlerinizi ^1Adminlerimize^7 Bildiriniz^0.";	
rcm_smess4 = "^7Iletisim ^4FACEBOOK^7/^4TalhaTIGCI.";	
rcm_smess5 = "^7Iletisim ^4Skype ^7: ^4TalhaTIGCI";
rcm_smessage1 = "^7Servere%nl%^7Hosgeldiniz";
rcm_smessage2 = "^7Yasaklar";
rcm_smessage3 = "^7Sikayet%nl%^7Bildir.";
rcm_smessage4 = "^7FaceBook";
rcm_smessage5 = "^7Skype";
rcm_specpen = "^7Spec%nl%^3Driver";
rcm_teammsg = "^2Yapim%nl%^7Asamasinda !";
rcm_teammsginst = "^7To use in game, make sure that you and the other members of your team%nl%^7have their teamname set with their team name in square brackets%nl%^7(this can be changed in the config file) i.e. Krayy[LFSNZ]%nl%^7Then when you type '^3!tc <msg>^7'%nl%^7only people with the same team name will see the message";	
rcm_trackheader = "^6Mesaj 2";
rcm_unbanpen1 = "^2Ban ^7Kaldirma ^2Butonu";
msg_yellowflag = "^3Yellow%nl%^3Flag";
rcm_yellowflagmessage = "^3YELLOW FLAG - BE PREPARED TO SLOW OR STOP";

# HUD System
############

hud_blackmessage = "^0!! RACE HAS BEEN STOPPED !!";
hud_blink_cheq = "^7• •%at%^0• •";
hud_blink_blue = "^4• •";
hud_blink_green = "^2• •";
hud_blink_red = "^1• •";
hud_blink_white = "^7• •";
hud_blink_yellow = "^3• •";
hud_bluemessage = "^4!! Blue Flag - Let leader(s) through !!";
hud_greenmessage = "^2!! GREEN FLAG !! CONTINUE RACING !!";
hud_pentext = "^7Pitlane Giris"; 
hud_pextext = "^7Pitlane Cikis" ;
hud_pstatusclosed = "^1KAPATD";
hud_pstatusopen = "^2AC";
hud_openrcm = " IYI OYUNLAR";
hud_redmessage = "^1> ^7Race has been ^1RED ^7flagged ^1<";
hud_trackstatusblue = "^4BLUE%nl%^4FLAG";
hud_trackstatuscheq = "^3RACE COMPLETE";
hud_trackstatusqualy = "^3QUALIFYING IN PROGRESS";
hud_trackstatusrace = "^2RACE IN PROGRESS";
hud_trackstatusred = "^1RED FLAG";
hud_trackstatussafetyin = "^7SAFETY CAR IN THIS LAP";
hud_trackstatussafetyout = "^7SAFETY CAR DEPLOYED - ^1NO ^7OVERTAKING";
hud_yellowmessage = "^1ACCIDENT: ^7Be prepared to slow down or stop";
       	
EndLang



# Clock V1.00	30-10-15	- Initial release	#
#########################################################

CatchEvent OnConnect( $userName ) # Player event
	OnConnect_Clock();
EndCatchEvent

Sub OnConnect_Clock() # Player event
	Clock_tick( $KeyFlags );
EndSub

Sub Clock_tick( $KeyFlags )
	### Display button ###   
	#openGlobalButton( "Clock",50,5,25,5,1,-1,36,"^6Saat : ^7". GetLapperVar ( "LongTime" ),"" );
	#openGlobalButton( "tarih",87,5,25,5,1,-1,36,"^6Tarih : ^7". GetLapperVar ( "ShortDate" ),"" );

openGlobalButton( "önemli",70,5,65,5,0,-1,96,"^T^1LFS ^7TURKIYE ^3DRIFT ^7Sunucumuza Hosgeldiniz! ^7Sunucumuzda ^1KÜFÜR ^7Yasaktır.");
openGlobalButton( "admins_presen",90,0,20,5,6,-1,32,"^3Tarih:^7 " . GetLapperVar( "ShortDate" ) );
openGlobalButton( "aralik13",0,94,20,4,6,-1,37,"^T^7Discord:gg/EXDxYvzgRy");
openGlobalBUtton( "admins_present",0,190,25,4,5,-1,97"^0|^1Moderator ^7Alımı Yakında.");


	### End ### 

	### End ### 

	HostDelayedCommand( 1, Clock_tick );
EndSub

# Admin notify V1.00	01-11-15	- Initial release	#
#################################################################

CatchEvent OnLapperStart()
	OnLapperStart_Admin_Notify();
EndCatchEvent

CatchEvent OnConnect( $userName )
	OnConnect_Admin_Notify();
EndCatchEvent

CatchEvent OnDisConnect( $userName, $reason )
	OnDisConnect_Admin_Notify();
EndCatchEvent

Sub OnLapperStart_Admin_Notify()
	### Declare global variables ###
	GlobalVar $admins_present;
	GlobalVar $admin_status;
	GlobalVar $admin_name;
	GlobalVar $admin_time_online;
	### End ###

	### Give global variables a value to start with ###
	$admins_present=0;
	### End ###
EndSub

Sub OnConnect_Admin_Notify()
	### Set userName variable and load the nicknames of admins specified in admin.txt ###
	$userName = GetCurrentPlayerVar( "UserName" );
	UserGroupFromFile( "admin", "./admin.txt" );
	### End ###

	### Check if connecting player is an admin, if so, raise number by one ###
	IF( UserInGroup( "admin", $userName ) == 1 )
	THEN
		$admins_present=$admins_present+1;
		$admin_name = GetCurrentPlayerVar( "NickName" );
		$admin_time_online = getLapperVar( "ShortTime" );
	ENDIF
	### End ###


	Admin_status( $KeyFlags );
EndSub

Sub OnDisConnect_Admin_Notify()
	### Check if discconnecting player is an admin, if so, lower number by one ###
	IF( UserInGroup( "admin", $userName ) == 1 )
	THEN
		$admins_present=$admins_present-1;
	ENDIF
	### End ###

	Admin_status( $KeyFlags );
EndSub

Sub Admin_status ( $KeyFlags )
	### Check how many admins are online , if value above 0 ,status is 'online' , otherwise status is 'offline' and last name and time are removed ###
	IF ( $admins_present > 0 )
	THEN
		$admin_status="^7Aktif";
	ELSE
		$admin_status="^7Kapali";
		$admin_name="^7DahaGirmedi";
		$admin_time_online="^7(-N.A.-)";
	ENDIF
	### End ###

	### Display button ###

        openPrivButton( "admins_present",0,196,20,4,5,-1,97,"^0|^7Admin ^0:^7 " . $admin_name . " ^0| " . $ );

      

	### End ###
EndSub

CatchEvent OnLapperStart()
	# List of LFS Cars...can be reordered or added to
	GlobalVar $LFSCarList;
	$LFSCarList = "UF1,XFG,XRG,LX4,LX6,RB4,FXO,XRT,RAC,FZ5,UFR,XFR,FXR,XRR,FZR,MRT,FBM,FOX,FO8,BF1";

	# Set the DEBUG flag and global var
	GlobalVar $DebugOn;
	$DebugOn = FALSE;

	### Global vars for penalty short names ####
	GlobalVar $penalty_shortnames;
	$penalty_shortnames[0] = "--";
	$penalty_shortnames[1] = "DT";
	$penalty_shortnames[2] = "DT";
	$penalty_shortnames[3] = "SG";
	$penalty_shortnames[4] = "SG";
	$penalty_shortnames[5] = "30";
	$penalty_shortnames[6] = "45";
	$penalty_shortnames[7] = "";
    
    GlobalVar $MONTHS;
    $MONTHS[1] = "January";
    $MONTHS[2] = "February";
    $MONTHS[3] = "March";
    $MONTHS[4] = "April";
    $MONTHS[5] = "May";
    $MONTHS[6] = "June";
    $MONTHS[7] = "July";
    $MONTHS[8] = "August";
    $MONTHS[9] = "September";
    $MONTHS[10] = "October";
    $MONTHS[11] = "November";
    $MONTHS[12] = "December";

    GlobalVar $TYRE_TYPES;
	$TYRE_TYPES["TYRE_R1"] = 0;
	$TYRE_TYPES["TYRE_R2"] = 1;
	$TYRE_TYPES["TYRE_R3"] = 2;
	$TYRE_TYPES["TYRE_R4"] = 3;
	$TYRE_TYPES["TYRE_ROAD_SUPER"] = 4;
	$TYRE_TYPES["TYRE_ROAD_NORMAL"] = 5;
	$TYRE_TYPES["TYRE_HYBRID"] = 6;
	$TYRE_TYPES["TYRE_KNOBBLY"] = 7;
	$TYRE_TYPES["TYRE_NUM"] = 8;
    $TYRE_TYPES["TYRE_NO_CHANGE"] = 9;

    GlobalVar $TYRE_TYPE_NUMS;
	$TYRE_TYPE_NUMS[0] = "R1";
	$TYRE_TYPE_NUMS[1] = "R2";
	$TYRE_TYPE_NUMS[2] = "R3";
	$TYRE_TYPE_NUMS[3] = "R4";
	$TYRE_TYPE_NUMS[4] = "SUP";
	$TYRE_TYPE_NUMS[5] = "NOR";
	$TYRE_TYPE_NUMS[6] = "HYB";
	$TYRE_TYPE_NUMS[7] = "KNB";
	$TYRE_TYPE_NUMS[8] = "NUM";
    $TYRE_TYPE_NUMS[9] = "--"];
EndCatchEvent

CatchEvent OnMSO( $userName, $text ) # Player event
	$text = Tolower( $text );
	$idxOfFirstSpace = indexOf( $text, " ");
	IF( $idxOfFirstSpace == -1 ) THEN
	  $command = $text;
	  $argv = "";
	ELSE
	  $command = subStr( $text,0,$idxOfFirstSpace );
	  $argv = trim( subStr( $text,$idxOfFirstSpace ) );
	ENDIF

	SWITCH( $command )
		CASE "!am":
			AdminMsg($argv);
		BREAK;
		CASE "!debug":
			IF ( GetUserStoredNum ("DebugOn") == 1 )
			THEN
				SetUserStoredValue ( "DebugOn", 0 );
				privMsg ( "DEBUG messages are now ^3OFF" );
			ELSE
				SetUserStoredValue ( "DebugOn", 1 );
				privMsg ( "DEBUG messages are now ^3ON" );
			ENDIF
		BREAK;
	ENDSWITCH
EndCatchEvent

# For use in debugging scripts, use !debug command to turn debugging on
# then call this Sub using: DEBUG("This is a debug message");
Sub DEBUG ($msg)
	$ListOfPlayers = GetListOfPlayers("N");
	FOREACH ( $Player IN $ListOfPlayers)
		IF ( UserIsAdmin( $Player["value"] ) == 1 )
		THEN
			IF ( GetUserStoredNum ($Player["value"], "DebugOn") == 1 )
			THEN
				privMsg( $Player["value"], "^7DEBUG: ^8" . $msg );
			ENDIF
		ENDIF
	ENDFOREACH
EndSub

# Send a message to all ADMINS on the admin channel using: ADMIN("This is an admin only message");
Sub ADMIN ( $msg )
	AdminMsg ( $msg )
EndSub

Sub AdminMsg ( $msg )
	$lop = getListOfPlayers( $userName );
    FOREACH ( $de in $lop )
        $userName = $de["value"];
        IF ( UserIsAdmin( $userName ) == 1 )
		THEN
			privMsg( $userName,"^7ADMIN: ^8" . $msg );
		ENDIF
	ENDFOREACH
EndSub

Sub closeButtonRegex ( $userName, $exp )
	$lob = getListOfPlayerButtons( $userName );
    FOREACH ( $de in $lob )
        $nameOfButton = $de["value"];
        IF ( isRegexMatch( $exp, $nameOfButton ) == 1 ) THEN
            closeButton ( $userName, $nameOfButton );
        ENDIF
	ENDFOREACH
EndSub

Sub closeButtonRegexAll ( $exp )
    $LoP = GetListOfPlayers( );
    FOREACH ( $Pid IN $LoP )
    closeButtonRegex ($Pid["value"], $exp);
    ENDFOREACH
EndSub  

Sub ButtonExists( $userName, $ButtonToFind )
	$lob = getListOfPlayerButtons( $userName );
    FOREACH ( $de in $lob )
        $nameOfButton = $de["value"];
        IF ( isRegexMatch( $ButtonToFind, $nameOfButton ) == 1 ) THEN
            return(1);
        ENDIF
	ENDFOREACH
	return(0);
EndSub

Sub DialogCreateCentered ( $userName, $DialogPrefix, $Width, $Height, $Title, $showClose, $secondsDisplayed) #$origL & $origT are no longer needed up here
	$origL = round(ToNum(ToNum(200 - $Width)/2),0);
	$origT = round(ToNum(ToNum(200 - $Height)/2),0);

	DialogCreate ( $userName, $DialogPrefix, $origL, $origT, $Width, $Height, $Title, $showClose, $secondsDisplayed);
EndSub

Sub DialogCreate ( $userName, $DialogPrefix, $origL, $origT, $Width, $Height, $Title, $showClose, $secondsDisplayed)
	# Draw window titles with Prev, Next and Close buttons
	openButton ( $userName, $DialogPrefix . "_bg1",$origL-1,$origT-7,$Width+2,$Height+9,1,$secondsDisplayed,ISB_DARK,"");
	openButton ( $userName, $DialogPrefix . "_title",$origL,$origT-6,$Width,5,5,$secondsDisplayed,ISB_LEFT,"^7" . $Title );
	openButton ( $userName, $DialogPrefix . "_bg2",$origL,$origT,$Width,$Height,1,$secondsDisplayed,ISB_LIGHT,"");

	IF ( $showClose == true )
	THEN
		openButton ( $userName, $DialogPrefix . "_close",87,$origT+$Height+1,27,6,8,$secondsDisplayed,ISB_LIGHT,"^0[  Close  ]",DialogClose );
	ENDIF

	# Draw the main contents window on top of the titles
	openButton ( $userName, $DialogPrefix . "_contents_bg",$origL,$origT,$Width,$Height,1,-1,ISB_DARK,"");
	#	openButton ( $userName, $DialogPrefix . "_contents_bg",$origL,$origT,$Width,$Height,1,-1,ISB_LIGHT,"");

EndSub

Sub DialogClose ( $KeyFlags, $id )
	$currPly = GetPlayerInfo();
	$DialogPrefix = split( $id,"_",0 );
	DEBUG ("Closing dialogs " . $DialogPrefix );
	closeButtonRegex ($currPly["UserName"], $DialogPrefix . ".*");
EndSub

Sub SpecAll()
	$LoP = GetListOfPlayers( );  				
	FOREACH ( $Pid IN $LoP )
		IF ( GetPlayerVar( $Pid["value"], "OnTrack" ) == "1" )
		THEN
			cmdLFS( "/spec " . $Pid["value"] );
		ENDIF
	ENDFOREACH
EndSub

Sub GetMonth()
    $date = getLapperVar("ShortDate");    # Get date in dd/mm/yyyy format
    return ($MONTHS[ToNum((substr($date, 3, 2)))]);        # Strip the month from the short date
EndSub

# Replace a string within a string
Sub StrReplace( $String, $Find, $Replace )
	$DONE = FALSE;
	$NewString = $String;
	WHILE ( $DONE == FALSE )
		$FindIndex = indexOf($NewString, $Find);
		IF ( $FindIndex == -1 )
		THEN
			$DONE = TRUE;
		ELSE
			$Split1 = subStr( $NewString ,0, $FindIndex );
			$SplitMid = strLen($Split1) + strLen($Find);
			$Split2 = subStr( $NewString ,$SplitMid, strLen($NewString) - $SplitMid );
			$NewString = $Split1 . $Replace . $Split2;
		ENDIF
	ENDWHILE
	return ($NewString);
EndSub

Sub AllRacersFinished ()
	$haveAllRacersFinished = TRUE;
	$thisLOP = GetListOfPlayers("N");
	FOREACH ( $Player IN $thisLOP)
#		DEBUG ("Checking result for: " . $Player["value"] . " = " . GetPlayerVar($Player["value"], "FinishedPos") );
		IF ( ToNum(GetPlayerVar($Player["value"], "FinishedPos")) < 0 && ToNum(GetPlayerVar($Player["value"], "OnTrack")) == 1)
		THEN
			DEBUG ("Player has yet to finish race: " . $Player["value"] );
			$haveAllRacersFinished = FALSE;
		ENDIF
	ENDFOREACH
	return ( $haveAllRacersFinished );
EndSub

Sub UserIsAdmin($userName)
	UserGroupFromFile( "superusers", "./superusers.txt" );
	IF ( UserIsServerAdmin( $userName ) == 1 ||  GetPlayerVar($userName,"UCID") == 0 ||  UserInGroup( "superusers",$userName) == 1 )
	THEN
		return(ToNum(1));
	ELSE
		return(ToNum(0));
	ENDIF
EndSub
CatchEvent OnLapperStart()

	# Set CIF specific globals
	GlobalVar $cifEnabled; $cifEnabled = TRUE;	# This is set when CIF has been loaded
	
	GlobalVar $cifGroups;			# Create global array to hold list of CIF modules
	$cifGroups = "";		# Initialise array with index items
	GlobalVar $cifModules;			# Create global array to hold list of CIF modules
	$cifModules["CIF"] = "CIF";		# Initialise array with index items


	### Set initial dialog coordinates & size ###
	GlobalVar $CifOrigT; $CifOrigT = 34;			# Top edge of window
	GlobalVar $CifOrigL; $CifOrigL = 68;	# Left edge of main content window
	GlobalVar $CifWidth; $CifWidth = 100;			# ...width of Dialog box
	GlobalVar $CifTabOrigL; $CifTabOrigL = 42;			# Left edge of Tab
	GlobalVar $CifTabWidth; $CifTabWidth = 23;			# ...width of Tab
	GlobalVar $CifRowHeight; $CifRowHeight = 6;			# ...height of row of text
	GlobalVar $CifHeight; $CifHeight = $CifRowHeight * 19;			# ...height of window
	GlobalVar $CifCommandTop; $CifCommandTop = $CifOrigT + $CifHeight - ($CifRowHeight + 2);
	GlobalVar $CifCommandWidth; $CifCommandWidth = $CifTabWidth + 2;

EndCatchEvent

Sub CifRegisterModule(  $cifGroupName, $cifModuleName, $CifModuleVersion )
	# Register a new CIF Group if it does not already exist
	IF ( indexOf( $cifGroups, $cifGroupName) < 0 ) THEN
		$cifGroups = $cifGroups . "," . $cifGroupName;
	ENDIF

	# Register a new module if it does not already exist
	IF ( indexOf( $cifModules[$cifGroupName], $cifModuleName) < 0 ) THEN
		$cifModules[$cifGroupName] = $cifModules[$cifGroupName] . "," . $cifModuleName;
	ENDIF
EndSub

Sub CifDraw(  $cifGroupName, $cifModuleName, $cifTitle )

	$HostName = getLapperVar( "HostName" );

	$currPly = GetPlayerInfo();
	$isCifRunning = GetCurrentPlayerVar("cifRunning");
	IF ( ButtonExists( $currPly["UserName"], "cMain_main") == FALSE) THEN
		$isCifRunning = FALSE;
	ENDIF

	# Redraw the dialogs tabs only if the GroupName is different so that it clears the buttons
	IF ( $isCifRunning == FALSE) THEN
		closeButtonRegex ( $currPly["UserName"], "CIF.*");

		# Draw the background and the title bar
		openPrivButton ( "cMain_AllBg1", $CifTabOrigL - 2, $CifOrigT - 8, $CifTabWidth + $CifWidth + 7, $CifHeight + ($CifRowHeight * 1.5), 1, -1,ISB_LIGHT,"");
		openPrivButton ( "cMain_AllBg2", $CifTabOrigL - 2, $CifOrigT - 8, $CifTabWidth + $CifWidth + 7, $CifHeight + ($CifRowHeight * 1.5), 1, -1,ISB_LIGHT,"");
		openPrivButton ( "cMain_Version", $CifTabOrigL + $CifTabWidth + $CifWidth - 17, $CifOrigT - 8, 20, 4, 4, -1, ISB_RIGHT + 7, "^TYusuf Emre%nl%v1.0.0 by KIPER");
		# Draw the main contents window on top of the titles and clear them
		openPrivButton( "cMain_main",$CifOrigL,$CifOrigT,$CifWidth,$CifHeight-(($CifRowHeight*2)-3),5,-1,32," " );

		# Tab background and tab names to click on
		openPrivButton ( "cMain_TabMain", $CifTabOrigL, $CifOrigT, $CifTabWidth + 2, $CifHeight - (($CifRowHeight * 2) - 3), 5, -1, 32," " );
	ELSE
		closeButtonRegex ( $currPly["UserName"], "CIF" . GetCurrentPlayerVar("cifGroupName") . ".*");
		closeButtonRegex ( $currPly["UserName"], "CIFCmdButton.*");
	ENDIF

	# Add the title & Close Command Button
	openPrivButton ( "cMain_TabbedGuiTitle", $CifTabOrigL, $CifOrigT - 8, $CifTabWidth + $CifWidth + 7, 8, 1, -1, ISB_LEFT + 2, $HostName . "^0 - " . $cifTitle );
	CifCmdButton( 0, "Close", CloseCifAll );

	SetCurrentPlayerVar("cifGroupName", $cifGroupName);
	SetCurrentPlayerVar("cifRunning", TRUE);

	$CIF_GROUPS = SplitTOArray( $cifGroups , "," );
	$CIF_GROUPS_MAX = arrayCount( $CIF_GROUPS );
	$j=0;
	$ButOrigT = $CifOrigT + 1;

	$CifTabRowHeight = $CifRowHeight - 1;
	WHILE ($j <= $CIF_GROUPS_MAX)
		$thisCifGroupName = $CIF_GROUPS[$j];
		IF ( $thisCifGroupName != "" ) THEN
	
		IF ( $isCifRunning == FALSE) THEN
			openPrivButton ( "CIFTab_" . $thisCifGroupName,$CifTabOrigL+1,$ButOrigT,$CifTabWidth,$CifTabRowHeight,5,-1,32,"^7" . $thisCifGroupName );
		ENDIF
		$ButOrigT = $ButOrigT + $CifTabRowHeight + 1;
		
		$CIF_MODULES = SplitTOArray( $cifModules[$thisCifGroupName] , "," );
		$CIF_MODULES_MAX = arrayCount( $CIF_MODULES );
		$i=0;
		WHILE ($i <= $CIF_MODULES_MAX)
			$thisCifModule = $CIF_MODULES[$i];
			IF ( $thisCifModule != "" ) THEN
				IF ( ($thisCifModule == $cifModuleName) && ($thisCifGroupName == $cifGroupName) ) THEN
					IF ( $isCifRunning == FALSE) THEN
						openPrivButton ( "CIFTab_" . $thisCifGroupName . $thisCifModule,$CifTabOrigL+1,$ButOrigT,$CifTabWidth,$CifTabRowHeight,4,-1,16,"^3" . StrReplace( $thisCifModule, "_", " " ), "DoCif" . $thisCifGroupName . $thisCifModule );
					ELSE
						TextPrivButton( "CIFTab_" . $thisCifGroupName . $thisCifModule, "^3" . StrReplace( $thisCifModule, "_", " " ));
					ENDIF
				ELSE
					IF ( $isCifRunning == FALSE) THEN
						openPrivButton ( "CIFTab_" . $thisCifGroupName . $thisCifModule,$CifTabOrigL+1,$ButOrigT,$CifTabWidth,$CifTabRowHeight,4,-1,16, StrReplace( $thisCifModule, "_", " " ), "DoCif" . $thisCifGroupName . $thisCifModule );
					ELSE
						TextPrivButton( "CIFTab_" . $thisCifGroupName . $thisCifModule, StrReplace( $thisCifModule, "_", " " ));
					ENDIF
				ENDIF
				$ButOrigT = $ButOrigT + $CifTabRowHeight + 1;
			ENDIF
			$i = $i + 1;
		ENDWHILE
		ENDIF
		$j = $j + 1;
	ENDWHILE

EndSub

# CIF Command Buttons can be numbered from 0 to 4, with 0 being reserved for the Close button.
Sub CifCmdButton( $CcbNum, $CcbText, $CcbCallBack )
	IF ( $CcbNum == 0 ) THEN
		openPrivButton( "cMain_CmdClose", ($CifTabOrigL+1)+($CifCommandWidth*$CcbNum), $CifCommandTop, $CifCommandWidth-2, $CifRowHeight, 4, -1, 32, "^7Close", CloseCifAll );
	ELSE
		openPrivButton( "CIFCmdButton_" . $CcbNum, ($CifTabOrigL+1)+($CifCommandWidth*$CcbNum), $CifCommandTop, $CifCommandWidth-2, $CifRowHeight, 4, -1, 32, "^7" . $CcbText, $CcbCallBack );
	ENDIF
EndSub

Sub CloseCifAll ($KeyFlags, $id )
	$currPly = GetPlayerInfo();
	closeButtonRegex ( $currPly["UserName"], "CIF.*");
	closeButtonRegex ( $currPly["UserName"], "cMain.*");
	SetCurrentPlayerVar("cifRunning", FALSE);
EndSub

Sub CountItems ( $ItemList )
	$ItemArray = SplitTOArray(  $ItemList , "," );
	$ItemCount = arrayCount( $ItemArray );
	return ( $ItemCount );
EndSub
CatchEvent OnLapperStart()
	# Set TeamChat globals
	GlobalVar $tcDelimiterStart;
	GlobalVar $tcDelimiterEnd;
	
	# Set the inital values to be square brackets
	$tcDelimiterStart = "[";
	$tcDelimiterEnd = "]";
EndCatchEvent

CatchEvent OnConnect( $userName ) # Player event
	 SetTeamName();
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

	SWITCH( $command )
		CASE "!tc":
				TeamChat($argv);
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
		#privMsg (" ^6LFS TURKIYE ^7SUNUCULARINA ^2HOSGELDINIZ  ^3" . $NickName);
	        #privMsg ("^6KLANA KATILMAK ICIN ^2DC ^6GELINIZ  ^3" . $NickName);
               #privMsg ("^7DISCORD::^6https://discord.gg/gBHQe5vMcv  ^3" . $NickName);
               #privMsg ("^2INSTAGRAM:^6_kpryusuf23  ^3" . $UserName);
                
	ELSE
		#privMsg (" ^6LFS TURKIYE ^7SUNUCULARINA ^2HOSGELDINIZ : ^3" . $NickName);
	        #privMsg ("^6BIZI TERCIH ETTIGINIZ ICIN TSK EDERIZ  ^3" . $NickName);
                #privMsg ("^7SUNUCULARIMIZ ^27/24 ^7Aktiftir iyi Oyunlar..  ^3" . $NickName);
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
				privMsg ( $userName, "" . $msg );
			ENDIF
		ENDFOREACH
	ELSE
		privMsg ("You must have your Team name in your Nick to use TeamChat!");
	ENDIF
EndSub
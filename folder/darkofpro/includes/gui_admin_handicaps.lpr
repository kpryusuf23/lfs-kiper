#############################################################################
# LFS Handicapping Interface by Krayy
#############################################################################
# Ver 1.0.1 11-08-09 Initial release
# Ver 1.0.5 22-08-09 Major changes to functionality
#                    Added Save/Load code to store and retreive values
#                    Multiple column support for up to 32 players
#                    Changed button names to be unique
# Ver 1.0.6 27/12/09 Updated to be compatible with LFSLapper v5.918
#############################################################################

CatchEvent OnLapperStart()
	### Set up global var for GUI Tab & increase AG_MAX ####
	GlobalVar $AG_HANDICAPS; $AG_HANDICAPS = $AG_MAX;
	$AG_MAX = $AG_MAX + 1;
	# Append comma separated string for menu item
	$GUI_ADMIN_ITEMS = $GUI_ADMIN_ITEMS . "Handicaps,";
EndCatchEvent

CatchEvent OnMSO( $userName, $text ) # Player event
	$idxOfFirstSpace = indexOf( $text, " ");
	IF( $idxOfFirstSpace == -1 ) THEN
	  $command = $text;
	  $argv = "";
	ELSE
	  $command = subStr( $text,0,$idxOfFirstSpace );
	  $argv = trim( subStr( $text,$idxOfFirstSpace ) );
	ENDIF

	SWITCH( $command )
		CASE "!hc":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
				DoAdminHandicaps(0,0);
			ELSE
				privMsg( langEngine( "%{main_notadmin}%" ) );
			ENDIF
   		BREAK;
	ENDSWITCH
EndCatchEvent

Sub DoAdminHandicaps ( $KeyFlags, $id )
	# Draw the main Admin Framework dialog box
	DrawAdminGUI($AG_HANDICAPS, "Handicap Administration");

	$DialogPrefix = $AGPrefix . "Hc_";
	$origT = $AGorigT+1;			# Top edge of main content window
	$origL = $AGorigL+1;	# Left edge of main content window
	$origR = $AGorigL+50;
	
	$rowHeight=5;

	# Left hand titles
	openPrivButton ($DialogPrefix . "hc_luser",$origL,$origT,27,$rowHeight,1,-1,99,"Nickname");
	openPrivButton ($DialogPrefix . "hc_lweight",$origL+27,$origT,11,$rowHeight,1,-1,35,"Weight");
	openPrivButton ($DialogPrefix . "hc_lintake",$origL+38,$origT,11,$rowHeight,1,-1,35,"Intake");

	# Right hand titles
	openPrivButton ($DialogPrefix . "hc_ruser",$origR,$origT,27,$rowHeight,1,-1,99,"Nickname");
	openPrivButton ($DialogPrefix . "hc_rweight",$origR+27,$origT,11,$rowHeight,1,-1,35,"Weight");
	openPrivButton ($DialogPrefix . "hc_rintake",$origR+38,$origT,11,$rowHeight,1,-1,35,"Intake");

	$mList = GetListOfPlayers("N");
	$mCount = arrayCount( $mList );
	$plyNum=0;
	WHILE ($plyNum < $mCount)
		$uName = $mList[$plyNum];
		$uUCID = GetPlayerVar($uName,"UCID");
		$uNick = GetPlayerVar($uName,"NickName");
		$Pref = $DialogPrefix . $uUCID . "_" . $plyNum . "_";

		$IsOdd = $plyNum & 1;
		IF ($IsOdd == 0)	# Check if we are on left or right side
		THEN
			$origRow = $origT + $rowHeight + (Round($plyNum / 2,0) * $rowHeight);
			$origCol = $origL;
		ELSE
			$origCol=$origR;
		ENDIF

		openPrivButton ($Pref . "hUser",$origCol,$origRow,27,$rowHeight,1,-1,96,"^7". $uNick);
			
		# Set the header row and display different info for Admins vs Players
		IF ( UserIsAdmin( GetCurrentPlayerVar("UserName") ) == 1 )
		THEN
			openPrivButton ($Pref . "wCurr",$origCol+27,$origRow,8,$rowHeight,1,-1,32,GetPlayerVar($uName,"P_Mass") ."/^3" . GetPlayerVar($uName,"H_Mass"));
			openPrivButton ($Pref . "wLess",$origCol+35,$origRow+2,3,3,1,-1,32,"^2-",DoHandicapper_wLess);
			openPrivButton ($Pref . "wMore",$origCol+35,$origRow,3,3,1,-1,32,"^1+",DoHandicapper_wMore);
			openPrivButton ($Pref . "iCurr",$origCol+38,$origRow,8,$rowHeight,1,-1,32,GetPlayerVar($uName,"P_Tres") ."/^3" . GetPlayerVar($uName,"H_Tres"));
			openPrivButton ($Pref . "iLess",$origCol+46,$origRow+2,3,3,1,-1,32,"^2-",DoHandicapper_iLess);
			openPrivButton ($Pref . "iMore",$origCol+46,$origRow,3,3,1,-1,32,"^1+",DoHandicapper_iMore);
		ENDIF
		$plyNum=$plyNum+1;
	ENDWHILE
EndSub

Sub DoHandicapper_wLess ( $KeyFlags, $id )
	$DialogPrefix = split( $id,"_",0 );
	$Ucid = ToNum(split( $id,"_",1 ));
	$plyNum = ToNum(split( $id,"_",2 ));
	$uName = GetPlayerVarByUcid($Ucid, "UserName");
	$uMass = GetPlayerVar($uName,"H_Mass");
	IF ($KeyFlags > 1)
	THEN
	    $uMass=$uMass-5;
	ELSE
	    $uMass=$uMass-1;
	ENDIF
	IF ( $uMass < 0 )
	THEN
		$uMass = 0;
	ENDIF
	SetPlayerVar($uName,"H_Mass",$uMass);
	$StatusButton = $DialogPrefix . "_" . $Ucid . "_" . $plyNum . "_wCurr";
	DEBUG ("Updating button " . $StatusButton);
	TextPrivButton( $StatusButton, GetPlayerVar($uName,"P_Mass") ."/^3" . GetPlayerVar($uName,"H_Mass"));
EndSub

Sub DoHandicapper_wMore ( $KeyFlags, $id )
	$DialogPrefix = split( $id,"_",0 );
	$Ucid = ToNum(split( $id,"_",1 ));
	$plyNum = ToNum(split( $id,"_",2 ));
	$uName = GetPlayerVarByUcid($Ucid, "UserName");
	$uMass = GetPlayerVar($uName,"H_Mass");
	IF ($KeyFlags > 1)
	THEN
	    $uMass=$uMass+5;
	ELSE
	    $uMass=$uMass+1;
	ENDIF
	IF ( $uMass > 200 )
	THEN
		$uMass = 200;
	ENDIF
	SetPlayerVar($uName,"H_Mass",$uMass);
	$StatusButton = $DialogPrefix . "_" . $Ucid . "_" . $plyNum . "_wCurr";
	DEBUG ("Updating button " . $StatusButton);
	TextPrivButton( $StatusButton, GetPlayerVar($uName,"P_Mass") ."/^3" . GetPlayerVar($uName,"H_Mass"));
EndSub

Sub DoHandicapper_iLess ( $KeyFlags, $id )
	$DialogPrefix = split( $id,"_",0 );
	$Ucid = ToNum(split( $id,"_",1 ));
	$plyNum = ToNum(split( $id,"_",2 ));
	$uName = GetPlayerVarByUcid($Ucid, "UserName");
	$uTres = GetPlayerVar($uName,"H_Tres");
	IF ($KeyFlags > 1)
	THEN
	    $uTres=$uTres-5;
	ELSE
	    $uTres=$uTres-1;
	ENDIF
	IF ( $uTres < 0 )
	THEN
		$uTres = 0;
	ENDIF
	SetPlayerVar($uName,"H_Tres",$uTres);
	$StatusButton = $DialogPrefix . "_" . $Ucid . "_" . $plyNum . "_iCurr";
	DEBUG ("Updating button " . $StatusButton);
	TextPrivButton( $StatusButton, GetPlayerVar($uName,"P_Tres") ."/^3" . GetPlayerVar($uName,"H_Tres"));
EndSub

Sub DoHandicapper_iMore ( $KeyFlags, $id )
	$DialogPrefix = split( $id,"_",0 );
	$Ucid = ToNum(split( $id,"_",1 ));
	$plyNum = ToNum(split( $id,"_",2 ));
	$uName = GetPlayerVarByUcid($Ucid, "UserName");
	$uTres = GetPlayerVar($uName,"H_Tres");
	IF ($KeyFlags > 1)
	THEN
	    $uTres=$uTres+5;
	ELSE
	    $uTres=$uTres+1;
	ENDIF
	IF ( $uTres > 50 )
	THEN
		$uTres = 50;
	ENDIF
	SetPlayerVar($uName,"H_Tres",$uTres);
	$StatusButton = $DialogPrefix . "_" . $Ucid . "_" . $plyNum . "_iCurr";
	DEBUG ("Updating button " . $StatusButton);
	TextPrivButton( $StatusButton, GetPlayerVar($uName,"P_Tres") ."/^3" . GetPlayerVar($uName,"H_Tres"));
EndSub

Sub DoHandicapper_Save($KeyFlags, $id)
	$ListOfPlayers = GetListOfPlayers("N");
	FOREACH ( $Player IN $ListOfPlayers)
		SetUserStoredValue( $Player, "H_Mass", GetPlayerVar($Player,"H_Mass"));
		SetUserStoredValue( $Player, "H_Tres", GetPlayerVar($Player,"H_Tres"));
	ENDFOREACH
EndSub

Sub Handicapper_DbLoad()
	$ListOfPlayers = GetListOfPlayers("N");
	FOREACH ( $Player IN $ListOfPlayers)
		$uMass = GetUserStoredValue( $Player, "H_Mass");
		$uTres = GetUserStoredValue( $Player, "H_Tres");
		SetPlayerVar($Player,"H_Mass",$uMass);
		SetPlayerVar($Player,"H_Tres",$uTres);
	ENDFOREACH
EndSub

Sub DoHandicapper_Load($KeyFlags, $id)
	Handicapper_DbLoad();
	DoAdminHandicaps(0,0);
EndSub

Lang "EN" # Race Events messages
	khc_header_admin = "^0Set Player Handicaps (Admin Mode)";
	khc_header = "^0Current Player Handicaps";
EndLang

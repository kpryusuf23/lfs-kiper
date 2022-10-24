#############################################################################
# Gui Template Module by Krayy
#############################################################################
# Ver 1.0.1 - 05 March 2010 Initial release
#############################################################################

CatchEvent OnLapperStart()
	### Set up global var for GUI Tab & increase TEMPLATE_MAX ####
	GlobalVar $TEMPLATE_MODULE1; $TEMPLATE_MODULE1 = $TEMPLATE_MAX;
	$TEMPLATE_MAX = $TEMPLATE_MAX + 1;
	# Append comma separated string for menu item
	$GUI_TEMPLATE_ITEMS = $GUI_TEMPLATE_ITEMS . "Module1,";
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
		CASE "!module1":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
				DoTemplateModule1(0,0);
			ELSE
				privMsg( langEngine( "%{main_notadmin}%" ) );
			ENDIF
   		BREAK;
	ENDSWITCH
EndCatchEvent

Sub DoTemplateModule1($KeyFlags,$id)
	# Draw the main Admin Framework dialog box
	DrawTemplateGUI($TEMPLATE_MODULE1,"Template Module1");

	# Set various vars for GUI size and location
	$DialogPrefix = $TEMPLATEPrefix . "Module1_";
	$origT = $TEMPLATEorigT+1;			# Top edge of main content window
	$origL = $TEMPLATEorigL+1;	# Left edge of main content window
	$origR = $TEMPLATEorigL+50;
	$rowHeight = 5;

EndSub

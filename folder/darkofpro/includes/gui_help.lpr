#############################################################################
# LFS Lapper Multi-Page Help System by Krayy
#############################################################################
# This is a more flexible Help system that allows the addition of extra help
# descriptions without encroaching on available screen area.
#############################################################################
# Ver 1.0.1 - 15 Jan 2010 Initial release
# Ver 1.0.2 - 16 Jan 2010 Minor updates to display
# Ver 1.0.4 - 16 Feb 2010 Updated to support v 5.926b
# Ver 1.0.5 - 7 July 2010, Updated for common look & feel interface
#############################################################################

CatchEvent OnLapperStart()
	### Set Dialog prefix and initial left/right and top/bottom coordinates ###
	GlobalVar $HLPRoot; $HLPRoot = "HLP";
	GlobalVar $HLPPrefix; $HLPPrefix = $HLPRoot . "-";		# Dialog prefix...used in Close Regex
	GlobalVar $HLPorigT; $HLPorigT = 35;			# Top edge of window
	GlobalVar $HLPorigL; $HLPorigL = 68;	# Left edge of main content window

	### Set up global var for Help GUI Items ####
	GlobalVar $GUI_HELP_ITEMS; 	$GUI_HELP_ITEMS = ":^2Sistem ^7Kurallari,";
	GlobalVar $HLP_MAX; $HLP_MAX = 1;

	# Just reorder these lines to change order of help item tabs
	GlobalVar $HLP_GENERAL; $HLP_GENERAL = $HLP_MAX; $HLP_MAX = $HLP_MAX + 1; $GUI_HELP_ITEMS = $GUI_HELP_ITEMS ."General,";
	GlobalVar $HLP_STATS;   $HLP_STATS = $HLP_MAX;   $HLP_MAX = $HLP_MAX + 1; $GUI_HELP_ITEMS = $GUI_HELP_ITEMS . "Stats,";
	GlobalVar $HLP_ADMIN;   $HLP_ADMIN = $HLP_MAX;   $HLP_MAX = $HLP_MAX + 1; $GUI_HELP_ITEMS = $GUI_HELP_ITEMS . "Admin,";
	GlobalVar $HLP_CUSTOM;  $HLP_CUSTOM = $HLP_MAX;  $HLP_MAX = $HLP_MAX + 1; $GUI_HELP_ITEMS = $GUI_HELP_ITEMS . "Custom,";
	$HLP_MAX = $HLP_MAX + 1; $GUI_HELP_ITEMS = $GUI_HELP_ITEMS . ":Cruise,";
	GlobalVar $HLP_CRUISE_Help;  $HLP_CRUISE_Help = $HLP_MAX;  $HLP_MAX = $HLP_MAX + 1; $GUI_HELP_ITEMS = $GUI_HELP_ITEMS . "Cruise Help,";
	GlobalVar $HLP_CRUISE_Rules;  $HLP_CRUISE_Rules = $HLP_MAX;  $HLP_MAX = $HLP_MAX + 1; $GUI_HELP_ITEMS = $GUI_HELP_ITEMS . "Cruise Rules,";

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
		CASE "!yardim":
			DoHelpGeneral(0, "gui_help_header_General");
			BREAK;
	ENDSWITCH
EndCatchEvent

############################
#Replacement Help Functions#
############################

Sub DrawHelpGUI($HighLightedItemNum, $TabTitle)
	# Draw the main Admin Framework dialog box
	DrawGUI(  $HLPRoot, $TabTitle, $HLPorigT, $HLPorigL, "DoHelp", $HighLightedItemNum, $GUI_HELP_ITEMS );

	# Now display the help text
	$HighLightedItemNum = ToNum($HighLightedItemNum);
	$HELP_ITEMS = SplitTOArray(  $GUI_HELP_ITEMS , "," );
	openPrivButton ( $HLPPrefix . "contents",$HLPorigL+1,$HLPorigT,98,6,5,-1,64,langEngine( "%{gui_help_contents_" . StrReplace( $HELP_ITEMS[$HighLightedItemNum], " ", "_" ) . "}%") );
EndSub

Sub DoHelpGeneral ( $KeyFlags, $id )
	DrawHelpGUI($HLP_GENERAL,"Kurallar");
EndSub

Sub DoHelpStats ( $KeyFlags, $id )
	DrawHelpGUI($HLP_STATS,"Stats Commands");
EndSub

Sub DoHelpAdmin ( $KeyFlags, $id )
	DrawHelpGUI($HLP_ADMIN,"Admin Commands");
EndSub

Sub DoHelpCustom ( $KeyFlags, $id )
	DrawHelpGUI($HLP_CUSTOM,"Custom Commands");
EndSub

Sub DoHelpCruise_Help ( $KeyFlags, $id )
	DrawHelpGUI($HLP_CRUISE_Help,"Cruise Commands");
EndSub

Sub DoHelpCruise_Rules ( $KeyFlags, $id )
	DrawHelpGUI($HLP_CRUISE_Rules,"Cruise Rules");
EndSub

Lang "EN" # Race Events messages
	gui_help_contents_General = "^7Sistem ^7Yardim "
			. "%nl%^3!cleanspb ^8- Reset this sessions PBs"
			. "%nl%^3!groupqual ^8- Show group qualifying pos"
			. "%nl%^3!hand [name] ^8- Show current handicap"
			. "%nl%^3!hc ^8- Show all players current handicaps"
			. "%nl%^3!laps ^8- Total laps done for this car/track + session"
			. "%nl%^3!license [name] ^8- Display license status"
			. "%nl%^3!myconfig ^8- Configure split time display"
			. "%nl%^3!mypb [cars] ^8- Show user PBs for set of cars"
			. "%nl%^3!pos ^8- Show friendly position"
			. "%nl%^3!stats [name] ^8- Display user stats"
			. "%nl%^3!statsqual [name] ^8- Display user stats"
			. "%nl%^3!who ^8- Display connected user info and stats"
			. "%nl%"
			. "%nl%^2Pit Board Setup and Info"
			. "%nl%^3!pbclose ^8- Close pit board"
			. "%nl%^3!pbconfig ^8- Configure Pit Board"
			. "%nl%^3!pit ^8- Pit stop info"
			. "%nl%^3!pitwindow ^8- Configure pit windows";
	gui_help_contents_Stats = "^2Track/Race Info"
			. "%nl%^3!distance ^8- Show track distance"
			. "%nl%^3!near [name] ^8- Show top 14 drivers near your ranking"
			. "%nl%^3!nearqual [name] ^8- Show top qualifiers near your time"
			. "%nl%^3!spb ^8- Show splits"
			. "%nl%^3!top [car] ^8- Show top drivers with this track/car"
			. "%nl%^3!topqual [car] ^8- Show top qual times with this car"
			. "%nl%^3!track ^8- Show current track information"
			. "%nl%"
			. "%nl%^2Drifting Info"
			. "%nl%^3!drf [name] ^8- "
			. "%nl%^3!drfnear [name] ^8- "
			. "%nl%^3!drfnearqual [name] ^8- "
			. "%nl%^3!drfqual [name] ^8- "
			. "%nl%^3!dstats [name] ^8- "
			. "%nl%^3!dstatsqual [name] ^8- "
			. "%nl%"
			. "%nl%^2LFSLapper Info"
			. "%nl%^3!time ^8- Show local server time"
			. "%nl%^3!powered ^8- Show Copyright Notice"
			. "%nl%^3!ver ^8- Show LFSLapper version";
	gui_help_contents_Admin = "^2Admin Commands"
			. "%nl%^3!offmod [username] Admin Tarafından Ban Atılmıştır ^8- Admin Tarafından Ban Atılmıştır [username] from server"
			. "%nl%^3!ctrack ^8- Configure track (GUI)"
			. "%nl%^3!groupcmdlfs [cmd] ^8- Execute [cmd] on all players"
			. "%nl%^3!gui ^8- Update race config GUI"
			. "%nl%^3!hc ^8- Set player handicaps"
			. "%nl%^3!mod [username] ^8- Admin Tarafından Kick Atılmıştır [username] from server"
			. "%nl%^3!node ^8- LFS Server Node number"
			. "%nl%^3!pwgui ^8- GUI to set race pit windows"
			. "%nl%^3!sc ^8- Deploy Safety Car"
			. "%nl%^3!term ^8- Terminate LFSLapper"
			. "%nl%^3!zone ^8- Display current node on track";
	gui_help_contents_Custom = "^2Custom Commands"
			. "%nl%^3!event ^8- Set up race event"
			. "%nl%^3!admins ^8- Add or display admins"
			. "%nl%^3!sc ^8- Deploy or Manage Safety Car";
	gui_help_contents_Cruise_Help = "^2Cruise commands"
    . "%nl%^3!cruiseh ^8- Shows this help"
    . "%nl%^3!km  ^8- Show current amount of km you have"
    . "%nl%^3!cash  ^8- Show current amount of cash you have"
    . "%nl%^3!cars  ^8- Show the current cars you own"
    . "%nl%^3!show  ^8- Shows Everyone Your Stats"
    . "%nl%^3!buy [car]  ^8- Buy the listed car"
    . "%nl%^3!sell [car]  ^8- Sell the listed car"
    . "%nl%^3!pitlane  ^8- Sends you to pitlane"
    . "%nl%^3!price [car]  ^8- Display price of the listed car"
    . "%nl%^3!send [amount] [user]  ^8- sends the listed amount of cash to the listed user"
    . "%nl%^3!pitsafe  ^8- Displays whether your safe to pit"
    . "%nl%^3!officer  ^8- Go on/off duty"
    . "%nl%"
    . "%nl%^2Police Commands"
    . "%nl%^7!chase [user]"
    . "%nl%^6!unchase"
    . "%nl%^7!Fine [amount]"
    . "%nl%^6!clock [user]";
  gui_help_contents_Cruise_Rules = "%nl%^3Try to avoid swearing"
		. "%nl%^3Drive on the right side"
		. "%nl%^3Do NOT ram or crash other"
		. "%nl%^3The use of vob mods will result in a 365 day ban"
		. "%nl%^3Please say 'sorry' when u hit some one";
EndLang

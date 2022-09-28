#############################################################################
# GUI Template by Krayy
#############################################################################
# Ver 1.0.1 - 05 March 2010 Initial release
#############################################################################

CatchEvent OnLapperStart()
	### Set Dialog prefix and initial left/right and top/bottom coordinates ###
	GlobalVar $TEMPLATERoot; $TEMPLATERoot = "TEMPLATE";
	GlobalVar $TEMPLATEPrefix; $TEMPLATEPrefix = $TEMPLATERoot . "-";		# Dialog prefix...used in Close Regex
	GlobalVar $TEMPLATEorigT; $TEMPLATEorigT = 35;			# Top edge of window
	GlobalVar $TEMPLATEorigL; $TEMPLATEorigL = 68;	# Left edge of main content window

	# Set the initial counter for how many menu items there are
	GlobalVar $TEMPLATE_MAX; $TEMPLATE_MAX = 0;
	# Create an empty Global to store menu items
	GlobalVar $GUI_TEMPLATE_ITEMS;	$GUI_TEMPLATE_ITEMS = "";
EndCatchEvent

Sub DrawTemplateGUI($HighLightedItemNum, $TabTitle)
	# Draw the main Admin Framework dialog box
	DrawGUI(  $TEMPLATERoot, $TabTitle, $TEMPLATEorigT, $TEMPLATEorigL, "DoTemplate", $HighLightedItemNum, $GUI_TEMPLATE_ITEMS );
EndSub


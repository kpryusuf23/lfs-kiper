#############################################################################
# Administration Framework by Krayy
#############################################################################
# This addon provides wrapper functions for the administration system. This
# is a tabbed dialog that is used by admins to set various Lapper system
# settings via external modules. Modules will be listed below.
#############################################################################
# Ver 1.0.1 - 05 March 2010 Initial release
#############################################################################

CatchEvent OnLapperStart()
	### Set Dialog prefix and initial left/right and top/bottom coordinates ###
	GlobalVar $AGRoot; $AGRoot = "AG";
	GlobalVar $AGPrefix; $AGPrefix = $AGRoot . "-";		# Dialog prefix...used in Close Regex
	GlobalVar $AGorigT; $AGorigT = 35;			# Top edge of window
	GlobalVar $AGorigL; $AGorigL = 68;	# Left edge of main content window

	# Set the initial counter for how many menu items there are
	GlobalVar $AG_MAX; $AG_MAX = 0;
	# Create an empty Global to store menu items
	GlobalVar $GUI_ADMIN_ITEMS;	$GUI_ADMIN_ITEMS = "";
EndCatchEvent

Sub DrawAdminGUI($HighLightedItemNum, $TabTitle)
	# Draw the main Admin Framework dialog box
	DrawGUI(  $AGRoot, $TabTitle, $AGorigT, $AGorigL, "DoAdmin", $HighLightedItemNum, $GUI_ADMIN_ITEMS );
EndSub


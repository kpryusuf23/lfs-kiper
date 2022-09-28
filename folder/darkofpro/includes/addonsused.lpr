#------------------------------------------------------------------------------#
# Zorunlu içerir - en üstte olmalıdır
#------------------------------------------------------------------------------#
include( "./utils.lpr");
include( "./myInc.lpr");	# Pubstat IDK'nızı buraya girin
include( "./dpo.lpr");
#include( "./cruise.lpr");


#------------------------------------------------------------------------------#
# CIF şunları içerir:
# Alt menülerdeki sekme sırasını değiştirmek için bu satırları yeniden sıralayabilirsiniz.
#------------------------------------------------------------------------------#
include ("./cif/cif.lpr");	# Bu, tüm CIF globallerini tanımlayan ilk önce ZORUNLU

# CIF Bilgi Modülleri ##################
include ("./cif/info_tops.lpr"); # Etkileşimli düğmelerle üst çıkış, tops.lpr,! Top,! Near,! qual,! Nearqual'in yerini alır
include ("./cif/info_who.lpr"); # Who, replaces the who,lpr module and !who command

# CIF Yapılandırma Modülleri #################
#include ("./cif/config_membership.lpr"); # Üyelik yönetimi
include ("./cif/config_handicaps.lpr"); # Oyuncu Handikap Bilgisi

# CIF Yardım Modülleri ##################
include ("./cif/help_general.lpr"); # Genel Yardım ve! Help komutu
include ("./cif/help_admin.lpr"); # Admin yardım
include ("./cif/help_stats.lpr"); # kulanıcı yardım
include ("./cif/help_custom.lpr"); # Özel sunucu Yardımı


#------------------------------------------------------------------------------#
# Bilgileri bölmek için içerir ####
#------------------------------------------------------------------------------#
#include( "./pitboard.lpr");
#include( "./pitwindow_gui.lpr");
# OR
include( "./defPitInfo.lpr");


#------------------------------------------------------------------------------#
# Sürüklenen bilgiler için dahil et ####
#------------------------------------------------------------------------------#
#include( "./driftdef.lpr");
# OR
#include( "./driftmeter.lpr");


#------------------------------------------------------------------------------#
# Genel içerir
#------------------------------------------------------------------------------#

include( "./safetycar.lpr");
include( "./ctrack.lpr");
#include( "./racecontrol.lpr");
include( "./guiconfig.lpr");

include( "./menu.lpr");
include( "./dpo.lpr");
include( "./multipage-help.lpr");
#include( "./cruise.lpr");

include( "./winnerflags.lpr");
include ("./race_duration.lpr");		# Yarış süresinin dakika veya kilometre olarak ayarlanmasına izin verir
include ("./pit_reminder");
				# Yarış sırasında pite girmemişse bir yarışçıyı uyarır
include( "./blabla.lpr");

include( "./dpo.lpr");
#include( "./saat eklenti.lpr");
#include( "./cruise.lpr");
# test rutinleri - yalnızca geliştirme sırasında gereklidir
#include( "./optional/test.lpr");
include( "./racecontrol.lpr");
include( "./gui_help.lpr");

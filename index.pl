#!/usr/bin/perl

use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use utf8;
use Net::SNMP;
use Time::Local;

if (param('IPAddress')) {$IPAddress=param('IPAddress');}

@IPAddress = ("192.168.0.50", "192.168.0.51", "192.168.0.52"); #IP Addresses

$versjon = "2c" ;
$community = "public";
$oidCyan = "1.3.6.1.2.1.43.11.1.1.9.1.1";
$oidBlack = "1.3.6.1.2.1.43.11.1.1.9.1.4";
$oidMagenta ="1.3.6.1.2.1.43.11.1.1.9.1.2";
$oidYellow = "1.3.6.1.2.1.43.11.1.1.9.1.3";
$oidHostname = "1.3.6.1.2.1.1.5.0";
$oidSerial ="1.3.6.1.2.1.43.5.1.1.17.1";
$oidModell ="1.3.6.1.2.1.25.3.2.1.3.1";

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year = $year+1900;
$mon = $mon+1;

print qq {<HTML>
<body>
<h1> Printers $hour:$min:$sec $mday.$mon.$year </h1>


};


foreach $IP (@IPAddress){

$resultatCyan = `snmpwalk -v$versjon -Ovq -c $community $IP $oidCyan`;

$resultatBlack = `snmpwalk -v$versjon -Ovq -c $community $IP $oidBlack`;

$resultatMagenta = `snmpwalk -v$versjon -Ovq -c $community $IP $oidMagenta`;

$resultatYellow = `snmpwalk -v$versjon -Ovq -c $community $IP $oidYellow`;

$resultatHostname = `snmpwalk -v$versjon -Ovq -c $community $IP $oidHostname`;

$resultatSerial = `snmpwalk -v$versjon -Ovq -c $community $IP $oidSerial`;

$resultatModell = `snmpwalk -v$versjon -Ovq -c $community $IP $oidModell`;


print qq {

Hostname: $resultatHostname <br>
Modell: $resultatModell <br>
Serial: $resultatSerial <br>
Cyan: $resultatCyan % <br>
Black: $resultatBlack % <br>
Magenta: $resultatMagenta % <br>
Yellow: $resultatYellow % <br><br><br>
};

print qq {

</center>
</body>
};
}

sub plog {
@temp=@_;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year = $year+1900;
$mon=$mon+1;
open(LOG, '>', 'log.printersjekk.log') or die "Could not open file '$filename' $!";
print LOG "$hour:$min:$sec $mday.$mon $year - @temp\n";
close LOG;
}


#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : init.pp
# @created : 12 Feb 2010 09:05:47 +1100
# @last changed: Thur 29 Jul 2010 12:15:21 +1000
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# Class: sysstat
#
# This class installs sysstat, and takes care of setting up sar and sadc  
# to gather disk/io stats as well as CPU.  
# Only tested on CentOS/RHEL5.
#
# Parameters:
#	$sardays	-	number of days to keep stats for.
#				-	defaults to 28
#
# Actions:
#   Ensures the sysstat package is installed and sets up the config files  
#	based on the server achitecture
#
# Requires:
#   - Package["sysstat"]
#
class sysstat {

  package { "sysstat" : ensure => present }
  # there is no process/daemon running here;
  # the init script just sets a counter at boot time
  service { 'sysstat' :
    enable  => true,
    require => Package['sysstat']
  }

  $sardays = 28
  file { "/etc/sysconfig/sysstat":
    content => template("sysstat/sysconfig/sysstat.erb"),
    mode    => 444,
    require => Package['sysstat']
  }

  if $architecture == 'x86_64' {
    file { '/usr/lib64/sa/sa1':
      content => template('sysstat/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    } 
  } else {
    file { '/usr/lib/sa/sa1':
      content => template('sysstat/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    }
  }
}

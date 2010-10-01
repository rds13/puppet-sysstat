#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : ubuntu.pp
# @created : Tue 28 Sep 2010 21:48:43 EST
# @last changed: Fri 01 Oct 2010 21:08:34 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# Class: sysstat::ubuntu
#
# This class configures sysstat, the Ubuntu way.  
#
# Parameters:
#	$sardays	-	number of days to keep stats for.
#				-	defaults to 28
#
# Actions:
#  sets up the sysstat config files for Ubuntu
#
# Requires:
#   - Package["sysstat"]
#
class sysstat::ubuntu {

  file { "/etc/default/sysstat":
    owner   => root,
    group   => root,
    mode    => 444,
    source  => "puppet:///modules/sysstat/ubuntu/sysstat",
    require => Package['sysstat']
  }

  if $architecture == 'x86_64' {
    file { '/usr/lib64/sysstat/sa1':
      content => template('sysstat/ubuntu/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    } 
  } else {
    file { '/usr/lib/sysstat/sa1':
      content => template('sysstat/ubuntu/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    }
  }
}

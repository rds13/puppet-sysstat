#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : centos.pp
# @created : Tue 28 Sep 2010 21:48:43 EST
# @last changed: Tue 28 Sep 2010 22:18:59 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# Class: sysstat::centos
#
# This class configures sysstat, the CentOS way.  
#
# Parameters:
#	$sardays	-	number of days to keep stats for.
#			-	defaults to 28
#
# Actions:
#  sets up the sysstat config files for CentOS
#
# Requires:
#   - Package["sysstat"]
#
class sysstat::centos {

  $sardays = 28

  file { "/etc/sysconfig/sysstat":
    content => template("centos/sysstat.erb"),
    mode    => 444,
    require => Package['sysstat']
  }

  if $architecture == 'x86_64' {
    file { '/usr/lib64/sa/sa1':
      content => template('centos/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    } 
  } else {
    file { '/usr/lib/sa/sa1':
      content => template('centos/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    }
  }
}

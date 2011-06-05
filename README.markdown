# sysstat puppet module  
  
## Class: sysstat  

This class installs sysstat, and takes care of setting up sar and sadc  
to gather disk/io stats as well as CPU.  

### Parameters:  
	$sardays	-	number of days to keep stats for.  
			-	defaults to 28  

### Actions:  

Ensures the sysstat package is installed and sets up the config files based on the server achitecture  

### Requires:  
	Package["sysstat"]  

### Usage

    node default {
      class { 'sysstat': sardays => '30' }
    }

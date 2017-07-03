class swagent {
	case $::osfamily {
	'redhat': {
		package { 'falcon-sensor':
 		ensure		=> installed,
 		install_options	=> [ '--nogpgcheck' ],
		}
	# Copy  FFCNix Script to Agents
	file { "/opt/crowdstrike":
      		ensure => directory
   		}
	file { '/opt/crowdstrike/goldarid_FFCNix_2017_02_16.run':
 		ensure		=> 'present',
 		source 		=> 'puppet:///modules/crowdstrike/goldarid_FFCNix_2017_02_16.run',
 		mode		=> '0755',
 		require		=> [ File['/opt/crowdstrike'], Package['falcon-sensor'] ],
 		}
        cron { 'Run_FFCNix':
                ensure  => 'present',
                command => '/opt/crowdstrike/goldarid_FFCNix_2017_02_16.run',
		require => File['/opt/crowdstrike/goldarid_FFCNix_2017_02_16.run'],
		user	=> "root",
		hour 	=> '23', 
		minute	=> '00',
		month	=> '4',
		monthday	=> '5',
		weekday	=> '*',
        	}
	}

'debian': {
	file { "/opt/crowdstrike":
      		ensure => directory
   		}
 	File {
     		owner   => root,
    		group   => root,
   		mode    => '755',
  		ensure  => present,
  		}
	file { "/opt/crowdstrike/falcon-sensor_2.0.24-1407_amd64.deb":
      		source 	=> 'puppet:///modules/crowdstrike/falcon-sensor_2.0.24-1407_amd64.deb',
		notify	=> Package['falcon-sensor'],
  		}
 	file { "/opt/crowdstrike/goldarid_FFCNix_2017_02_16.run":
    		source	=> 'puppet:///modules/crowdstrike/goldarid_FFCNix_2017_02_16.run',
   		}
	exec { 'apt-update':
		command	=> '/usr/bin/apt-get update',
		}	
	package { "auditd":
		require	=> Exec['apt-update'],
		ensure 	=> 'installed',
		}
	package { "libauparse0":
		require	=> Exec['apt-update'],
		ensure 	=> 'installed',
		}
  	package { "falcon-sensor":
		ensure  => installed,
		provider=> 'dpkg',
		source	=> "/opt/crowdstrike/falcon-sensor_2.0.24-1407_amd64.deb",
		require	=> Package["auditd", 'libauparse0'],
		}
        cron { 'Run_FFCNix':
                ensure  => 'present',
                command => '/opt/crowdstrike/goldarid_FFCNix_2017_02_16.run',
		require => File['/opt/crowdstrike/goldarid_FFCNix_2017_02_16.run'],
		user	=> "root",
		hour 	=> '23', 
		minute	=> '00',
		month	=> '4',
		monthday	=> '5',
		weekday	=> '*',
        	}
	}

'windows': {
	file { 'c:\SolarWinds-Agent.msi':
        	ensure 	=> 'file',
            	owner 	=> 'administrator',
    		group  => ["administrators","everyone"],
     		mode   => "1777",
            	source 	=> 'puppet:///modules/swagent/SolarWinds-Agent.msi',
         	}
	file { 'c:/SolarWinds-Agent.mst':
        	ensure 	=> 'file',
            	owner 	=> 'administrator',
    		group  => ["administrators","everyone"],
            	source 	=> 'puppet:///modules/swagent/SolarWinds-Agent.mst',
     		mode   => "1777",
                	}
    	package { 'swagent':
		ensure		=> 'present',
            	source 		=> 'c:\SolarWinds-Agent.msi',
            	install_options	=>['/q'],
            	}
			}	
   }
}

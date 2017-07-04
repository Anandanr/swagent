class swagent {
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
		ensure		=> 'file',
            	source 		=> 'c:\SolarWinds-Agent.msi',
            	install_options	=>  [ '/qn', {'TRANSFORMS' => 'C:\SolarWinds-Agent.mst'}], 
            	}	
}

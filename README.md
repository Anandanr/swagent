"# swagent"

Puppet command That I used: 
puppet apply --modulepath=C:\ProgramData\PuppetLabs\puppet\etc\modules -e "include swagent"

Please modify the modulepath and include name

see the host and IP are there in the following files:
C:\Program Files (x86)\SolarWinds\Agent\SolarWinds.Agent.Service.exe.cfg
C:\ProgramData\SolarWinds\Agent\SolarWinds.Agent.Service.exe.ini

These entries are taken from the MST file you created and send to me. For more details check the init.pp file.
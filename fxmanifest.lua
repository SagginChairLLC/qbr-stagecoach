fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'SagginChair'
description 'Saggin\'s Scripts https://discord.gg/jcKENQ6edp'

client_script { 
    'client/main.lua',
    'warmenu.lua',
}
shared_script 'config.lua'
server_script 'server/main.lua'

lua54 'yes'
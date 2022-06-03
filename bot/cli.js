process.shell = true
require ("script.min.js")
var lib = require ("script.min.js/src")
let {define} = lib
let {zero, one} = lib
let j_son = require ("/var/bot/cli.json")
let instance = {ip: {address: j_son.interfaces [zero].ipv4.address, gateway: j_son.interfaces [zero].ipv4.gateway, mask: j_son.interfaces [zero].ipv4.netmask}}
var argument = lib.process ()
var program = argument.begin ()
var action = argument [one]
var $1 = argument [one + 1]
var $2 = argument [one + 2]
var $3 = argument [one + 3]
var $4 = argument [one + 4]
var $5 = argument [one + 5]

var ng_config_log = "/var/log/www"
var ng_config_site_enabled = "/etc/nginx/sites-enabled"
var ng_config_file = "/var/bot/node_process/ng.config"
var ng_config_template = lib.file.get.content (ng_config_file)

if (program === "ng") {
	if (action === "config") {
		var file = ng_config_site_enabled.concat ("/", $1)
		var template = ng_config_template
		template = template.replace ("__name__", $2)
		template = template.replace ("__host__", $3.replace ("__ip__", instance.ip.address))
		template = template.replace ("__port__", $4)
		lib.file.write (file, template)
		lib.dir.create (ng_config_log.concat ("/", $2))
		}
	}

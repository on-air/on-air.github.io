require ("script.min.js")
var lib = require ("script.min.js/src/index")
let {define} = lib
let {zero, one} = lib
let virtual = require ("/var/shell/cli.min.js")
let ng_template = lib.file.get.content (virtual.ng.template)

var argument = lib.process ()
var program = argument.begin ()
var action = argument [one]
var $1 = argument [one + 1]
var $2 = argument [one + 2]
var $3 = argument [one + 3]
var $4 = argument [one + 4]
var $5 = argument [one + 5]

function ng_setup (program, action, $1, $2, $3, $4, $5) {
	if (program === "ng") {
		if (action === "config") {
			var file = virtual.ng.dir.concat ("/", $1)
			var template = ng_template
			template = template.replace ("__name__", $2)
			template = template.replace ("__host__", $3.replace ("__ip__", virtual.ip.address))
			template = template.replace ("__port__", $4 || 3000)
			lib.file.write (file, template)
			lib.dir.create (virtual.ng.log.concat ("/", $2))
			}
		}
	}

if (argument.length) {
	ng_setup (program, action, $1, $2, $3, $4, $5)
	}

define (module).export ({
	ng_setup,
	})

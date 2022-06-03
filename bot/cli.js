process.shell = true
require ("script.min.js")
var lib = require ("script.min.js/src")

var ng_config_file = lib.path.join (__dirname, "node_process", "ng.config")
var ng_config_template = lib.file.get.content (ng_config_file)

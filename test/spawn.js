$path = require ("path")
$fs = require ("fs")
$process = require ("child_process")

var ng_config = $process.spawn ("bot", ["ng", "config", "default", "3000"])

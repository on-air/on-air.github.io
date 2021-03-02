/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

function Define (proto, key, value, option) {
	if (Array.isArray (key)) for (var i in key) Define.value (proto, key [i], value, option)
	else if (key) return Define.value (proto, key, value, option)
	else if (("__") in proto) return proto ["__"]
	else return Define.value (proto, ("__"), (new Define.properties (proto)), option)
	}

Define.properties = class {
	constructor (proto) { Define.value (this, ("__"), proto) }
	function (key, value, option) { return this.apply (key, value, option) }
	class (key, value, option) { return this.apply (key, value, option) }
	clone (key, value, option) { return this.apply (key, value, option) }
	on (key, value, option) { return this.apply (key, value, option) }
	set (key, value, option) { return this.apply (key, value, option) }
	apply (key, value, option) {
		if (Array.isArray (key)) for (var i in key) Define.value (this ["__"], key [i], value, option)
		else Define.value (this ["__"], key, value, option)
		return value
		}
	export (value) {
		if (arguments.length) return this ["__"].exports = value
		else return this ["__"].exports
		}
	}

Define.property = function (proto, key, value, option) {
	if (typeof value === "object") value = Object.assign (value, option)
	else value = Object.assign ({value: value}, option)
	Object.defineProperty (proto, key, value)
	return value
	}

Define.get = function (proto, key, value, option) { if (Object.defineProperty (proto, key, Object.assign ({get: value}, option)) || true) return value }
Define.set = function (proto, key, value, option) { if (Object.defineProperty (proto, key, Object.assign ({set: value}, option)) || true) return value }
Define.value = function (proto, key, value, option) { if (Object.defineProperty (proto, key, Object.assign ({value: value}, option)) || true) return value }
Define.function = function (proto, key, value, option) { return Define.value (proto, key, value, option) }
Define.class = function (proto, key, value, option) { return Define.value (proto, key, value, option) }
Define.descriptor = function (key, value, option) { return Define.property (Define.properties.prototype, key, value, option) }

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Define (Object, "define", Define);

Define (Object, "type", function (input) { return typeof input; });
Define (Object.type, "array", function () { if (arguments.length) return (arguments [0] instanceof Array); else return Array; });
Define (Object.type, "boolean", function () { if (arguments.length) return (arguments [0] instanceof Boolean); else return Boolean; });
Define (Object.type, "date", function () { if (arguments.length) return (arguments [0] instanceof Date); else return Date; });
Define (Object.type, "error", function () { if (arguments.length) return (arguments [0] instanceof Error); else return Error; });
Define (Object.type, "function", function () { if (arguments.length) return (arguments [0] instanceof Function); else return Function; });
Define (Object.type, "number", function () { if (arguments.length) return (arguments [0] instanceof Number); else return Number; });
Define (Object.type, "object", function () { if (arguments.length) return (arguments [0] instanceof Object); else return Object; });
Define (Object.type, "regex", function () { if (arguments.length) return (arguments [0] instanceof RegExp); else return RegExp; });
Define (Object.type, "promise", function () { if (arguments.length) return (arguments [0] instanceof Promise); else return Promise; });
Define (Object.type, "string", function () { if (arguments.length) return (arguments [0] instanceof String); else return String; });

Define (Object.type, "of", function (input) { return Object.prototype.toString.call (input); });
Define (Object.type.of, "array", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object Array]"); else return "[object Array]"; });
Define (Object.type.of, "boolean", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object Boolean]"); else return "[object Boolean]"; });
Define (Object.type.of, "date", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object Date]"); else return "[object Date]"; });
Define (Object.type.of, "function", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object Function]"); else return "[object Function]"; });
Define (Object.type.of, "null", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object Null]"); else return "[object Null]"; });
Define (Object.type.of, "number", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object Number]"); else return "[object Number]"; });
Define (Object.type.of, "object", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object Object]"); else return "[object Object]"; });
Define (Object.type.of, "regex", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object RegExp]"); else return "[object RegExp]"; });
Define (Object.type.of, "string", function () { if (arguments.length) return (Object.type.of (arguments [0]) === "[object String]"); else return "[object String]"; });

Define (Object.is, "array", function (input) { return Array.isArray (input); });
Define (Object.is, "boolean", function (input) { if (Object.type.of.boolean (input)) return true; else return Object.type.boolean (input); });
Define (Object.is, "date", function (input) { if (Object.type.of.date (input)) return true; else return Object.type.date (input); });
Define (Object.is, "decimal", function (input) { return Object.is.float (input); });
Define (Object.is, "double", function (input) { return Object.is.float (input); });
Define (Object.is, "finite", function (input) { return Number.isFinite (input); });
Define (Object.is, "float", function (input) { if (Object.is.number (input)) return (input.toString ().split (".").length === 2); else return false; });
Define (Object.is, "function", function (input) { if (Object.type.of.function (input)) return true; else return Object.type.function (input); });
Define (Object.is, "integer", function (input) { return Number.isInteger (input); });
Define (Object.is, "nan", function (input) { return Number.isNaN (input); });
Define (Object.is, "null", function (input) { if (Object.type.of.null (input)) return true; else return (input === null); });
Define (Object.is, "number", function (input) { if (Object.is.nan (Number (input)) === false) { if (Object.type.of.number (input)) return true; else if (Object.type.of.string (input)) if (input) return true; else return false; else return false; } else { return Object.type.number (input); } });
Define (Object.is, "object", function (input) { if (Object.is.function (input)) return false; else if (Object.is.array (input)) return false; else if (Object.type.of.object (input)) return true; else return Object.type.object (input); });
Define (Object.is, "regex", function (input) { if (Object.type.of.regex (input)) return true; else return Object.type.regex (input); });
Define (Object.is, "promise", function (input) { return Object.type.promise (input); });
Define (Object.is, "stream", function (input) { return Object.type.stream (input); });
Define (Object.is, "string", function (input) { if (Object.type.of.string (input)) return true; else return Object.type.string (input); });
Define (Object.is, "define", function (input) { return ! Object.un.define (input); });
Define (Object.is, "set", function (input, value) { if (arguments.length > 1) { if (Object.is.set (input)) return input; else return value; } return ! Object.un.set (input); });
Define (Object.is, "value", function (input) { return ! ((input === Object.un.define ()) || (input === null)); });
Define (Object.is, "scalar", function (input) { return ((Object.type (input) === "function") || (Object.type (input) === "object") || (Object.type (input) === "array")); });
Define (Object.is, "stringify", function (input) { return ((Object.type (input) === "string") || (Object.type (input) === "number")); });
Define (Object.is, "option", function (input) { return Object.is.object (input); });
Define (Object.is, "empty", function (input) { if (Object.is.string (input) || Object.is.integer (input)) return (input.toString ().trim () === ""); });
Define (Object.is, "json", function (input) { try { JSON.parse (input); return true; } catch (error) { return false; } });
Define (Object.is, "url", function (input) { try { if (new URL (input)) return true; else return false; } catch (error) { return false; } });
Define (Object.is, "ip", function (input) { if (Object.is.string (input)) { if ((input = input.split (".")).length === 4) { for (var i in input) { if (Object.is.number (input [i]) === false) return false; if (Number (input [i]) < 1) return false; if (Number (input [i]) > 255) return false; } return true; } } return false; });

Define (Object, "un", function (input) { return ! input; });
Define (Object.un, "define", function (input) { if (arguments.length) return (input === undefined); else return undefined; });
Define (Object.un, "set", function (input) { if (Object.un.define (input)) return true; else if (Object.is.null (input)) return true; else return false; });
Define (Object.un, "value", function (input) { return ! Object.is.value (input); });

Define (Object, "to", function (input) {});
Define (Object.to, "string", function (input) { if (Object.is.set (input)) return input.toString (); else return ""; });
Define (Object.to, "number", function (input) { if (Object.is.number (input)) return Number (input); else return 0; });
Define (Object.to, "integer", function (input) { if (Object.is.nan (input = parseInt (input))) return 0; else return input; });
Define (Object.to, "float", function (input) { if (Object.is.nan (input = parseFloat (input))) return 0; else return input; });
Define (Object.to, "boolean", function (input) { if (input) if (["false", "null", "undefined"].includes (input)) return false; else return true; else return false; });

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Define (Object, "descriptor", function () { return Define.property (Object.prototype, key, value, option); });
Define (Object, "concat", function (... object) { return Object.assign ({}, ... object); });
Define (Object, "exist", function (value, object, offset) { return Object.values (object).includes (value, offset); });
Define (Object, "find", function () {});
Define (Object, "flip", function (object) { var data = {}; for (var key in object) data [object [key]] = key; return data; });
Define (Object, "format", function (object = {}, input, format) { if (input = input.toString ()) for (var key in (object = Object.keys.format (object, format))) input = input.replace (key, object [key]); return input; });
Define (Object, "get", function (object, key, value) { if (key in object) return object [key]; else return value; });
Define (Object, "has", function (key, object) { return key in object; });
Define (Object, "length", function (object) { var length = 0; for (var key in object) length ++; return length; });
Define (Object, "merge", function (object, data, recursive) { if (Object.un.set (object)) { return Object.assign ({}, data); } else if (recursive) { return Object.merge (object, data); } else { for (var key in data) { if (key in object) if (Object.is.object (object [key])) object [key] = Object.merge (object [key], data [key], true); else object [key] = data [key]; else object [key] = data [key]; } return object; } });
Define (Object, "normalize", function (object) { var data = {}; for (var key in object) data [key] = object [key]; return data; });
Define (Object, "replace", function (object, input) { if (input = input.toString ()) for (var key in object) input = input.replace (key, object [key]); return input; });

Define (Object.keys, "exist", function (key, object, offset) { return Object.keys (object).includes (key, offset); });
Define (Object.keys, "find", function (value, object) { for (var key in object) if (object [key] === value) return key; });
Define (Object.keys, "format", function (object, format = "%s") { var data = {}; for (var key in object) data [format.format (key)] = object [key]; return data; });

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Define (Array, "descriptor", function (key, value, option) { return Define.property (Array.prototype, key, value, option); });
Define (Array.prototype, "string", function () { return this.toString (); });
Define (Array.prototype, "begin", function (value = "") { for (var i in this) return this [i]; return value; });
Define (Array.prototype, "count", function (value, offset) { if (arguments.length) { var array = this.slice (offset), count = 0; for (var i in array) if (array [i] === value) count ++; return count; } else { return (this.length - 1); } });
Define (Array.prototype, "delete", function (offset, length = 1) { return this.splice (offset, length); });
Define (Array.prototype, "each", function (array) { this.forEach (array); });
Define (Array.prototype, "end", function (value = "") { for (var i in this) value = this [i]; return value; });
Define (Array.prototype, "exist", function (value, offset) { return this.includes (value, offset); });
Define (Array.prototype, "format", function (input, format) { var array; if (input = input.toString ()) for (var i in (array = Array.keys.format (this, format))) input = input.replace (array [i], format); return input; });
Define (Array.prototype, "include", function (value, offset) { for (var i in value) if (this.includes (value [i], offset) === false) return false; return true; });
Define (Array.prototype, "index", function (value, offset) { var array; if (Object.is.function (value)) array = this.slice (offset).findIndex (value); else array = this.indexOf (value, offset); return Function.util.index.of (array); });
Define (Array.prototype, "insert", function (offset, ... value) { return this.splice (offset, 0, ... value); });
Define (Array.prototype, "key", function () { var array = []; for (var [i] of this.entries ()) array.push (i); return array; });
Define (Array.prototype, "max", function () { return Math.max (... this); });
Define (Array.prototype, "min", function () { return Math.min (... this); });
Define (Array.prototype, "rand", function () { return this [(this.length - 1).random ()]; });
Define (Array.prototype, "replace", function (value, input) { if (input = input.toString ()) for (var i in this) input = input.replace (this [i], value); return input; });
Define (Array.prototype, "shuffle", function (offset) { var array = this.slice (offset), step = (this.length - 1).decrease (); for (var i in step) { var rand = step [i].random (), shuffle = array [step [i]]; array [step [i]] = array [rand]; array [rand] = shuffle; } return array; });
Define (Array.prototype, "trim", function () { var array = []; for (var i in this) array.push (this [i].toString ().trim ()); return array; });
Define (Array.prototype, "unique", function () { return Array.from (new Set (this)); });
Define (Array.prototype, "update", function (offset, ... value) { return this.splice (offset, 1, ... value); });
Define (Array.prototype, "value", function () { return this; });
Define (Array.prototype, "next", function (offset) { return this [Number (offset) + 1]; });
Define (Array.prototype, "previous", function (offset) { return this [Number (offset) - 1]; });

Define (Array, "keys", function () {});
Define (Array.keys, "exist", function (i, array) { return i in array; });
Define (Array.keys, "find", function (value, array) { return array.findIndex (value); });
Define (Array.keys, "format", function (array, format = "{%s}") { var data = []; for (var i in array) data.push (format.format (array [i])); return data; });

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Define (String, "descriptor", function (key, value, option) { return Define.property (String.prototype, key, value, option); });
Define (String.prototype, "string", function () { return this.toString (); });
Define (String.prototype, "number", function () { return Object.to.number (this); });
Define (String.prototype, "integer", function () { return Object.to.integer (this); });
Define (String.prototype, "float", function () { return Object.to.float (this); });
Define (String.prototype, "char", function () { return this.charCodeAt (); });
Define (String.prototype, "md", function () { return Function.Crypto.md (this.toString ()).toString (); });
Define (String.prototype, "sha", function () { return Function.Crypto.sha (this.toString ()).toString (); });
Define (String.prototype, "__sha", function () { return Function.Crypto.__sha (this.toString ()).toString (); });
Define (String.prototype, "after", function (input, offset) { if ((offset = this.indexOf (input, offset)) >= 0) return this.substr (offset + input.length); else return ""; });
Define (String.prototype, "begin", function (length = 1, offset) { if (Object.is.string (length)) return this.startsWith (length, offset); else return this.substr (0, length); });
Define (String.prototype, "before", function (input, offset) { if ((offset = this.indexOf (input, offset)) >= 0) return this.substr (0, offset); else return ""; });
Define (String.prototype, "big", function () { return this.toUpperCase (); });
Define (String.prototype, "count", function (input, offset) { if (arguments.length) return (this.substr (offset).split (input).length - 1); else return (this.length - 1); });
Define (String.prototype, "decode", function () { return atob (this); });
Define (String.prototype, "delete", function (input) { return this.split (input).join (""); });
Define (String.prototype, "encode", function (format) { if (format === "base") return this.encode ("base64"); else if (format === "md") return this.md (); else if (format === "sha") return this.sha (); else return btoa (this); });
Define (String.prototype, "end", function (length = 1, offset) { if (Object.is.string (length)) return this.endsWith (length, offset); else return this.substr (- length); });
Define (String.prototype, "exist", function (input, offset) { return this.includes (input, offset); });
Define (String.prototype, "format", function (... format) { return Function.util.format (this.toString (), ... format); });
Define (String.prototype, "include", function (input, offset) { for (var i in input) if (this.includes (input [i], offset) === false) return false; return true; });
Define (String.prototype, "index", function (input, offset) { return Function.util.index.of (this.indexOf (input, offset)); });
Define (String.prototype, "pad", function (input, length, pad = "begin") { if (pad === "begin") return this.padStart (length, input); else if (pad === "end") return this.padEnd (length, input); else return this; });
Define (String.prototype, "pop", function (length = 1) { if (Object.is.string (length)) return this.substr (0, (this.length - length.length)) === length; else return this.substr (0, (this.length - length)); });
Define (String.prototype, "pos", function (offset, length = 1) { return this.substr (offset, length); });
Define (String.prototype, "rand", function () { return this [(this.length - 1).random ()]; });
Define (String.prototype, "replace", function (input, format) { if (Object.is.regex (input)) return input [Symbol.replace] (this, format); else return this.split (input).join (Object.is.set (format, "")); });
Define (String.prototype, "reverse", function () { return this.split ("").reverse ().join (""); });
Define (String.prototype, "shift", function (length = 1) { if (Object.is.string (length)) return this.substr (length.length) === length; else return this.substr (length); });
Define (String.prototype, "shuffle", function () { return this.split ("").shuffle ().join (""); });
Define (String.prototype, "small", function () { return this.toLowerCase (); });
Define (String.prototype, "splice", function (length = 1) { var splice = [], slice = [], offset = length; for (var i in this) { slice.push (this [i]); if (i == (offset - 1)) { splice.push (slice.join ("")); slice = []; offset = (offset + length); } } if (slice.length) splice.push (slice.join ("")); return splice; });
Define (String.prototype, "trim", function (trim) { if (trim === "begin") { return this.trimStart (); } else if (trim === "end") { return this.trimEnd (); } else { var string = this.replace (/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, ""); if (trim) { trim = []; for (var i in (string = string.split (" "))) if (string [i].trim ()) trim.push (string [i]); return trim.join (" "); } else { return string; } } });
Define (String.prototype, "password", function (offset, length) { return Function.hash.password (this, offset, length); });
Define (String.prototype, "uc_first", function () { return this.substr (0, 1).toUpperCase () + this.substr (1); });
Define (String.prototype, "uc_word", function () { var string = this.split (" "), data = []; for (var i in string) data.push (string [i].uc_first ()); return data.join (" "); });

Define (String, "decode", function (input) { return new StringDecoder (input); });
Define (String, "encode", function (input) { return new StringEncoder (input); });

Define (String, "char", function () {});
Define (String.char, "alpha", {small: "abcdefghijklmnopqrsyuvwxyz", big: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", number: "0123456789", numeric: ("abcdefghijklmnopqrsyuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789")});
Define (String.char, "separator", {eol: "; ", c: ", "});
Define (String.char, "under", {score: "_"});
Define (String.char, "c", ",");
Define (String.char, "s", " ");
Define (String.char, "equal", "=");
Define (String.char, "ls", ":");
Define (String.char, "eol", ";");
Define (String.char, "ln", {s: "\n", r: "\r", tab: "\t"});
Define (String.char, "line", {r: "\r\n"});

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Define (Math, "BYTE", function () {});
Define (Math.BYTE, "log", [], {configurable: true, enumerable: true, writable: true});
Define (Math.BYTE, "unit", [], {configurable: true, enumerable: true, writable: true});

Define.get (Number.prototype, "length", function () { return this.toString ().length; });
Define (Number, "descriptor", function (key, value, option) { return Define.property (Number.prototype, key, value, option); });
Define (Number.prototype, "string", function () { return this.toString (); });
Define (Number.prototype, "number", function () { return Number (this); });
Define (Number.prototype, "integer", function () { return parseInt (this); });
Define (Number.prototype, "float", function () { return parseFloat (this); });
Define (Number.prototype, "char", function () { return String.fromCharCode (this); });
Define (Number.prototype, "second", function () { return (this * 1000); });
Define (Number.prototype, "absolute", function () { return Math.abs (this); });
Define (Number.prototype, "ceil", function () { return Math.ceil (this); });
Define (Number.prototype, "decrease", function (n = 0, step = 1) { var number = []; if (this >= n) for (var i = this; i >= n; i -= step) number.push (i); return number; });
Define (Number.prototype, "exponent", function (exponent) { return Math.pow (this, exponent); });
Define (Number.prototype, "floor", function () { return Math.floor (this); });
Define (Number.prototype, "increase", function (n, step = 1) { var number = []; if (this <= n) for (var i = this; i <= n; i += step) number.push (i); return number; });
Define (Number.prototype, "log", function () { return Math.log (this); });
Define (Number.prototype, "rand", function (n = 0) { var number = [this, n], min = Math.min (... number), max = Math.max (... number); return ((max - min).absolute ().random () + min); });
Define (Number.prototype, "random", function () { return Math.floor (Math.random () * (this + 1)); });
Define (Number.prototype, "round", function () { return Math.round (this); });
Define (Number.prototype, "percent", function (number) { return (this / 100); });
Define (Number.prototype, "percentage", function (number) { return (this / number) * 100; });
Define (Number.prototype, "format", function (option) { return Number.format (this, option); });
Define (Number, "format", function (number, option) { if ((option = Number.properties (option)).byte === true) { option.byte = false; return Number_BYTE (number, option); } var number = number.toString ().split (Number.float); var thousand = number [0], decimal = number [1]; var format = thousand.reverse ().splice (option.thousand).join (option.separator).reverse (); if (decimal) format = format.concat (option.float, decimal.begin (option.decimal)); return format; });

Define (Number, "BYTE", class { constructor () { Math.BYTE.log = []; Math.BYTE.unit = Number.BYTE.unit.key ().reverse (); for (var [i] of Number.BYTE.unit.entries ()) Math.BYTE.log.push (Number.BYTE.log.exponent (i)); } });
Define (Number.BYTE, "log", 1024);
Define (Number.BYTE, "unit", ["B", "KB", "MB", "GB", "TB", "PB", "XB"]);
function Number_BYTE (number, option) { var i; return Number.format (Number_BYTE_log (number, (i = Number_BYTE_unit (number))), (option = Number.properties (option))).concat (option.delimiter, Number.BYTE.unit [i]); }
function Number_BYTE_log (number, log) { return (number / Math.BYTE.log [log]); }
function Number_BYTE_unit (number) { for (var i in Math.BYTE.unit) if (number > (Math.BYTE.log [Math.BYTE.unit [i]] - 1)) return Math.BYTE.unit [i]; return 0; }

Define (Number, "properties", function (option) { return Object.assign ({thousand: Number.thousand, decimal: Number.decimal, separator: Number.separator, delimiter: Number.delimiter, float: Number.float, byte: false}, option); });
Define (Number, "thousand", 3, {configurable: true, enumerable: true, writable: true});
Define (Number, "decimal", 3, {configurable: true, enumerable: true, writable: true});
Define (Number, "separator", ",", {configurable: true, enumerable: true, writable: true});
Define (Number, "delimiter", " ", {configurable: true, enumerable: true, writable: true});
Define (Number, "float",  (1 / 2).toString ().substr (1, 1));

new Number.BYTE;

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Define (Function, "LocalStorage", class LocalStorage {
	constructor () {}
	static clear () { localStorage.clear () }
	static delete (key) { localStorage.removeItem (key) }
	static set (key, value) { localStorage.setItem (key, value) }
	static get (key, value) {
		if (key) {
			value = localStorage.getItem (key) || value
			if (value === "null") return null
			else if (value === "true") return true
			else if (value === "false") return false
			else if (value === "undefined") return undefined
			else return value
			}
		else {
			var data = {}
			var storage = Object.keys (localStorage)
			for (var i in storage) data [storage [i]] = localStorage.getItem (storage [i])
			return data
			}
		}
	static json (key, value, check) {
		var data = localStorage.getItem (key)
		if (check) if (data) return JSON.parse (data)
		if (arguments.length > 1) localStorage.setItem (key, JSON.stringify (value))
		return JSON.parse (localStorage.getItem (key))
		}
	});

Define (Function, "Session", class Session {
	constructor () {}
	static clear () { sessionStorage.clear () }
	static delete (key) { sessionStorage.removeItem (key) }
	static set (key, value) { sessionStorage.setItem (key, value) }
	static get (key, value) {
		if (key) {
			value = sessionStorage.getItem (key) || value
			if (value === "null") return null
			else if (value === "true") return true
			else if (value === "false") return false
			else if (value === "undefined") return undefined
			else return value
			}
		else {
			var data = {}
			var storage = Object.keys (sessionStorage)
			for (var i in storage) data [storage [i]] = sessionStorage.getItem (storage [i])
			return data
			}
		}
	static json (key, value, check) {
		var data = sessionStorage.getItem (key)
		if (check) if (data) return JSON.parse (data)
		if (arguments.length > 1) sessionStorage.setItem (key, JSON.stringify (value))
		return JSON.parse (sessionStorage.getItem (key))
		}
	});

Define (Function, "Cookie", class Cookie {
	constructor () { this.data = {} }
	start () {
		var cookies = document.cookie.split (";")
		for (var i in cookies) {
			var cookie = cookies [i].split ("=")
			var key = cookie [0].trim ()
			var value = cookie [1]
			if (value) this.data [key] = value
			}
		}
	set (key, value, option) {
		var cookie = [], option = Object.assign ({path: (this.path || "/"), domain: this.domain, expire: this.expire, mode: (this.mode || "lax")}, option)
		cookie.push (key + "=" + value)
		if (option.expire) cookie.push ("expire" + "=" + option.expire)
		if (option.domain) cookie.push ("domain" + "=" + option.domain)
		if (option.path) cookie.push ("path" + "=" + option.path)
		if (option.mode === "lax") cookie.push ("samesite=lax")
		document.cookie = cookie.join (";")
		return this.data [key] = value
		}
	get (key, value) {
		if (key) if (key in this.data) return this.data [key] || value
		return this.data
		}
	delete (key, option) {
		if (key) this.set (key, "", option)
		else for (var i in this.data) if (delete this.data [i]) this.set (i, "", option)
		}
	});

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Object.defineProperty (Date, "Time", {
	value: class {
		constructor (date, option) {
			this.option = {
				zone: {year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, ms: 0},
				month: {name: Date.month.name}, day: {name: Date.day.name},
				}
			this.get = {year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, ms: 0}
			this.date = {input: date}
			this.zone (option.zone);
			}
		zone (zone) {
			if (zone) for (var i in zone) this.option.zone [i] = zone [i];
			return this.set ();
			}
		input () {
			this.date.input = arguments;
			return this.set ();
			}
		offset () {
			var offset, stamp;
			for (var i in arguments) {
				if (typeof arguments [i] === "object") offset = arguments [i];
				if (typeof arguments [i] === "number") stamp = arguments [i];
				}
			if (stamp) return new Date.Time ([stamp], this.option).set (offset);
			return this;
			}
		set (offset) {
			if (offset === null) {
				return {
					year: {s: this.get.year, pad: this.get.year.toString ()},
					month: {s: this.get.month, name: this.option.month.name [this.get.month], pad: Date.pad (this.get.month + 1)},
					day: {s: this.get.day, name: this.option.day.name [this.get.week], pad: Date.pad (this.get.day)},
					hour: {s: this.get.hour, pad: Date.pad (this.get.hour), suffix: {pad: Date.pad ((this.get.hour > 12) ? (this.get.hour - 12) : this.get.hour)}, map: ((this.get.hour > 12) ? "PM" : "AM")},
					minute: {s: this.get.minute, pad: Date.pad (this.get.minute)},
					second: {s: this.get.second, pad: Date.pad (this.get.second)},
					ms: this.get.ms,
					week: this.get.week,
					stamp: this.get.stamp,
					query: {stamp: this.get.query.stamp},
					}
				}
			else {
				var offset = Date.offset (offset);
				var date = new Date (... this.date.input), stamp = date.getTime ();
				date = Date.property (new Date (stamp - Date.universal.offset), stamp);
				date = new Date ((date.year + offset.year + this.option.zone.year), (date.month + offset.month + this.option.zone.month), (date.day + offset.day + this.option.zone.day), (date.hour + offset.hour + this.option.zone.hour), (date.minute + offset.minute + this.option.zone.minute), (date.second + offset.second + this.option.zone.second), (date.ms + offset.ms + this.option.zone.ms));
				this.get = Date.property (date, stamp);
				return this;
				}
			}
		object () {
			var date = this.set (null);
			return {
				"Y": date.year.pad,
				"M": date.month.pad,
				"F": date.month.name,
				"D": date.day.pad,
				"L": date.day.name,
				"H": date.hour.pad,
				"I": date.minute.pad,
				"S": date.second.pad,
				"Q": date.ms,
				"A": date.hour.map,
				"J": date.hour.suffix.pad,
				"W": date.week,
				"X": date.stamp,
				}
			}
		format () {
			var format = "default", offset, stamp;
			for (var i in arguments) {
				if (typeof arguments [i] === "string") format = arguments [i];
				if (typeof arguments [i] === "object") offset = arguments [i];
				}
			if (offset) return this.offset (this.get.query.stamp, offset).format (format);
			var date = [];
			var object = this.object ();
			format = Date.format [format || "default"] || format;
			format = format.split ("");
			for (var i in format) date.push (object [format [i]] || format [i]);
			return date.join ("");
			}
		},
	});

Object.defineProperty (Date, "create", {
	value: function (option) {
		return function (... date) {
			return new Date.Time (date, option);
			}
		},
	});

Object.defineProperty (Date, "universal", {value: function (offset) { var date = new Date (); if (offset = Date.offset (offset)) return Date.universal.offset = Date.now () - new Date ((date.getUTCFullYear () + offset.year), (date.getUTCMonth () + offset.month), (date.getUTCDate () + offset.day), (date.getUTCHours () + offset.hour), (date.getUTCMinutes () + offset.minute), (date.getUTCSeconds () + offset.second), (date.getUTCMilliseconds () + offset.ms)).getTime (); }}), Object.defineProperty (Date.universal, "offset", {value: 0, configurable: true, enumerable: true, writable: true});
Object.defineProperty (Date, "zone", {value: function (offset) { if (offset) for (var i in offset) Date.zone.offset [i] = offset [i]; }}), Object.defineProperty (Date.zone, "offset", {value: {year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, ms: 0}});
Object.defineProperty (Date, "stamp", {value: function () { return Date.now (); }});
Object.defineProperty (Date, "sleep", {value: function (context, second = 1, ... param) { return setTimeout (context, (second * 1000), ... param); }}), Object.defineProperty (Date.sleep, "clear", {value: function (context) { clearTimeout (context); }});
Object.defineProperty (Date, "interval", {value: function (context, second = 1, ... param) { return setInterval (context, (second * 1000), ... param); }}), Object.defineProperty (Date.interval, "clear", {value: function (context) { clearInterval (context); }});
Object.defineProperty (Date, "expire", {value: function (current, expire, offset) { return new Date (... Date.properties (new Date (expire), offset)).getTime () < current; }});
Object.defineProperty (Date, "offset", {value: function (offset) { return Object.assign ({year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, ms: 0}, offset); }});
Object.defineProperty (Date, "pad", {value: function (value, length = 2) { return value.toString ().padStart (length, "0"); }});
Object.defineProperty (Date, "month", {value: {name: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]}});
Object.defineProperty (Date, "day", {value: {name: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]}});
Object.defineProperty (Date, "format", {
	value: {
		"default": "L, F D, Y - H:I:S A",
		"date": "Y-M-D",
		"date:time": "Y-M-D H:I:S",
		"time": "H:I:S",
		"time:s": "H:I",
		},
	});

Object.defineProperty (Date, "property", {
	value: function property (date, stamp) {
		if (stamp) stamp = stamp
		else stamp = date.getTime ()
		return {
			year: date.getFullYear (),
			month: date.getMonth (),
			day: date.getDate (),
			hour: date.getHours (),
			minute: date.getMinutes (),
			second: date.getSeconds (),
			ms: date.getUTCMilliseconds (),
			week: date.getDay (),
			query: {stamp: date.getTime ()},
			stamp: stamp,
			}
		},
	})

Object.defineProperty (Date, "properties", {
	value: function properties (date, offset) {
		if (offset) offset = Date.offset (offset)
		else offset = Date.offset (offset)
		return [
			date.getFullYear () + offset.year,
			date.getMonth () + offset.month,
			date.getDate () + offset.day,
			date.getHours () + offset.hour,
			date.getMinutes () + offset.minute,
			date.getSeconds () + offset.second,
			date.getUTCMilliseconds () + offset.ms,
			]
		},
	})

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Object.defineProperty (URL, "host", {value: "0.0.0.0"});
Object.defineProperty (URL, "path", {value: "/"});
Object.defineProperty (URL, "protocol", {value: {scheme: "http", secure: "https", file: {scheme: "ftp", secure: "ftps"}}});
Object.defineProperty (URL, "scheme", {value: ["http", "https", "ftp", "ftps"]});
Object.defineProperty (URL, "decode", {value: function (url) { return decodeURIComponent (url); }});
Object.defineProperty (URL, "encode", {value: function (url) { return encodeURIComponent (url); }});

Object.defineProperty (URL, "format", {
	value: function (url, option) {
		if (typeof url === "object") option = url;
		option = Object.assign ({protocol: URL.protocol.scheme, host: URL.host, path: URL.path}, option);
		var protocol = option.protocol, host = option.host, path = option.path, query = URL.query.format (option.query);
		if (option.secure) protocol = protocol.concat ("s");
		if (typeof url === "string") { if ((url = url.concat (query)).begin ("//")) return protocol.concat (":").concat (url); else if (url.begin ("/")) return protocol.concat ("://", host, url); else return protocol.concat ("://", url); }
		else { return protocol.concat ("://", host, path.concat (query)); }
		},
	});

Object.defineProperty (URL, "parse", {
	value: function (url, option, format = true) {
		var parse = URL.parse.component (url), host;
		option = Object.assign ({strict: false, protocol: {s: URL.scheme, scheme: URL.protocol.scheme}, host: URL.host, path: URL.path}, option);
		if (parse) {
			parse.location = parse.protocol.concat ("://").concat (parse.host.name);
			host = URL.parse.element (parse.host.name, option.domain);
			if (parse.domain = {name: "", base: {name: ""}, extension: "", sub: "", s: ""}) {
				if (host) {
					parse.host.s = parse.domain.name = host.domain;
					parse.host.star = (".") + parse.host.s;
					parse.host ["*"] = (parse.domain.sub = host.sub) || host ["*"];
					parse.domain.base.name = host.name;
					parse.domain.extension = host.extension;
					parse.domain.s = host.s;
					}
				}
			if (parse.search) parse.query = URL.query.parse (parse.search, option.query);
			if (parse.port) parse.port = Number (parse.port);
			if (option.strict === true) if (option.protocol.s.includes (parse.protocol) === false) return false;
			return parse;
			}
		if (format === true) if (url = URL.parse (URL.format (url, {protocol: option.protocol.scheme, host: option.host}), option, false)) return url;
		return false;
		},
	});

Object.defineProperty (URL.parse, "component", {
	value: function (url) {
		try {
			if (url.includes ("://")) {
				if (url = new URL (url)) {
					return {
						reference: url.href,
						location: (url.protocol.pop () + "://" + url.hostname),
						protocol: url.protocol.pop (), host: {name: url.hostname, base: {name: url.host}, s: url.hostname, star: url.hostname, "*": URL.domain.sub ()},
						port: url.port,
						user: url.username,
						password: url.password,
						search: url.search.shift (),
						query: {},
						path: URL.decode (url.pathname),
						tag: url.hash.shift (),
						}
					}
				}
			}
		catch (error) {}
		},
	});

Object.defineProperty (URL.parse, "element", {
	value: function (url, option) {
		if (url) {
			option = Object.assign ({extension: URL.domain.extension (), sub: URL.domain.sub ()}, option);
			var name, domain, extension, sub, s, length;
			for (var i in option.extension) {
				if (url.end ((length = (extension = option.extension [i]).length)) === extension) {
					if ((sub = url.pop ((domain = (name = url.pop (length).split (".").end ()).concat (extension)).length + 1)) === "") sub = option.sub;
					return {name: name, domain: domain, extension: extension, sub: sub, s: sub.split (".").reverse ().join (".")}
					}
				}
			}
		},
	});

Object.defineProperty (URL, "query", {value: function () {}});
Object.defineProperty (URL.query, "separator", {value: function (value) { if (value) return URL.query.separator.value = value; else return URL.query.separator.value; }}); Object.defineProperty (URL.query.separator, "value", {value: "&", configurable: true, enumerable: true, writable: true});
Object.defineProperty (URL.query, "delimiter", {value: function (value) { if (value) return URL.query.delimiter.value = value; else return URL.query.delimiter.value; }}); Object.defineProperty (URL.query.delimiter, "value", {value: "=", configurable: true, enumerable: true, writable: true});
Object.defineProperty (URL.query, "format", {
	value: function (query, question = true) {
		var data = [];
		if (query) for (var i in query) if (Array.isArray ()) data.push (i.concat (URL.query.delimiter.value).concat ("[" + query [i].join (",") + "]")); else data.push (i.concat (URL.query.delimiter.value).concat (query [i]));
		if (data.length) if (question) return ("?") + data.join (URL.query.separator.value);
		else return data.join (URL.query.separator.value);
		else return "";
		},
	});
Object.defineProperty (URL.query, "parse", {
	value: function (query) {
		var data = {}, q;
		for (var i in (query = query.split (URL.query.separator.value))) for (var x in (q = query [i].split (URL.query.delimiter.value))) data [q [0]] = q [1];
		return data;
		},
	});

Object.defineProperty (URL, "domain", {value: function () {}});
Object.defineProperty (URL.domain, "sub", {value: function (value) { if (value) return URL.domain.sub.value = value; else return URL.domain.sub.value; }}); Object.defineProperty (URL.domain.sub, "value", {value: "www", configurable: true, enumerable: true, writable: true});
Object.defineProperty (URL.domain, "extension", {value: function (value) { if (value) return URL.domain.extension.value = URL.domain.extension.sort (value); else return URL.domain.extension.value; }}); Object.defineProperty (URL.domain.extension, "value", {value: [".com", ".net", ".org"], configurable: true, enumerable: true, writable: true});
Object.defineProperty (URL.domain.extension, "sort", {value: function (extension) { var single = [], sub = [], domain = extension.sort (); for (var i in domain) { if (domain [i].count (".") > 1) sub.push (domain [i]); else single.push (domain [i]); } return sub.concat (single); }});
URL.domain.extension ([
	".com", ".net", ".org", ".info", ".mobi", ".tv",
	".co", ".io", ".me", ".ninja", ".blog", ".site", ".store", ".shop", ".live", ".life", ".cloud", ".online", ".host", ".app", ".dev", ".club",
	".id", ".co.id",
	".xyz", ".xxx",
	".local",
	]);

Object.defineProperty (URL, "fetch", {
	value: class {
		constructor () { this.url = "http://127.0.0.1:3000"; }
		get (url, option) { return new URL.fetch.promise (this.fetch (url, Object.assign ({method: "GET"}, option))); }
		post (url, data, option) {
			const FD = new FormData ();
			if (data) {
				for (var i in data) {
					if (typeof data [i] === "string") FD.append (i, data [i]);
					else if (Array.isArray (data [i])) FD.append (i + "[]", JSON.stringify (data [i]));
					else for (var x = 0; x < data [i].length; x ++) FD.append (i, data [i][x]);
					}
				}
			return new URL.fetch.promise (this.fetch (url, Object.assign ({method: "POST", data: FD}, option)));
			}
		fetch (url, option) {
			var query = [];
			var queries = "";
			if ((option = this.option (option)).query) {
				for (var i in option.query) query.push (i.concat ("=").concat (option.query [i]));
				queries = ("?").concat (query.join ("&"));
				delete option.query;
				}
			if (url.startsWith ("//")) url = url;
			else if (url.startsWith ("http://")) url = url;
			else if (url.startsWith ("https://")) url = url;
			else if (url.startsWith ("/")) url = window.url.location.concat (url);
			else url = this.url.concat ("/").concat (url);
			return fetch (url.concat (queries), option).then (function (response) {
				var data, header = {status: {code: response.status, message: "OK"}, type: (response.headers.get ("content-type") || "").split (";") [0].trim ()}
				if (header.status.code === 200) header.status.message = "OK";
				if (header.status.code === 201) header.status.message = "create";
				if (header.status.code === 403) header.status.message = "error:forbidden";
				if (header.status.code === 404) header.status.message = "error:found";
				if (header.status.code === 500) header.status.message = "error:s";
				var T_error = function () { if (header.status.code = 1000) if (header.status.message = "error:type") return {header} }
				var html = async function () {
					if (header.type === "text/html") return {header, body: await response.text ()}
					return T_error ();
					}
				var json = async function () {
					if (header.type === "application/json") {
						var body = await response.json ();
						if (typeof body === "string") body = {body: body}
						return Object.assign ({header}, body);
						}
					return T_error ();
					}
				var text = async function () {
					if (header.type === "text/plain") return {header, body: await response.text ()}
					return T_error ();
					}
				var blob = async function () { return {header, body: await response.blob ()} }
				return {__: header, html: html, json: json, text: text, blob: blob}
				});
			}
		option (input) {
			input = Object.assign ({}, input);
			var option = {redirect: "follow", cache: "no-cache", mode: "cors", headers: {}}
			if (input.method) option.method = input.method;
			if (input.redirect) option.redirect = input.redirect;
			if (input.cache) option.cache = input.cache;
			if (input.mode) option.mode = input.mode;
			if (input.credential) option.credentials = input.credential;
			if (input.body) option.body = input.body;
			if ("query" in input) option.query = input.query;
			if (null) if ("type" in input) option.headers ["x-type"] = input.type;
			if (null) if ("credential" in input) option.headers ["x-credential"] = input.credential;
			if (null) if ("key" in input) option.headers ["x-key"] = input.key;
			if (null) if ("secret" in input) option.headers ["x-secret"] = input.secret;
			if (input.header) for (var i in input.header) option.headers [i] = input.header [i];
			if (this) if (this.header) for (var i in this.header) option.headers [i] = this.header [i];
			return option;
			}
		},
	});

Object.defineProperty (URL.fetch, "promise", {
	value: class {
		constructor (promise) {
			this.fetch = promise;
			}
		html (context) {
			if (context) return this.fetch.then (function (response) { return response.html () }).then (context);
			else return this.fetch.then (function (response) { return response.html () });
			}
		json (context) {
			if (context) return this.fetch.then (function (response) { return response.json () }).then (context);
			else return this.fetch.then (function (response) { return response.json () });
			}
		text (context) {
			if (context) return this.fetch.then (function (response) { return response.text () }).then (context);
			else return this.fetch.then (function (response) { return response.text () });
			}
		blob (context) {
			if (context) return this.fetch.then (function (response) { return response.blob () }).then (context);
			else return this.fetch.then (function (response) { return response.blob () });
			}
		},
	});

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Object.defineProperty (Function, "http", {value: function () {}});
Object.defineProperty (Function.http, "header", {value: function () {}});
Object.defineProperty (Function.http.header, "status", {
	value: {
		OK: 200,
		error: {request: 400, forbidden: 403, found: 404, legal: 451, s: 500},
		message: {},
		code: {
			100: "Continue",
			101: "Switching Protocols",
			102: "Processing",
			200: "OK",
			201: "Created",
			202: "Accepted",
			203: "Non-authoritative Information",
			204: "No Content",
			205: "Reset Content",
			206: "Partial Content",
			207: "Multi-Status",
			208: "Already Reported",
			226: "IM Used",
			300: "Multiple Choices",
			301: "Moved Permanently",
			302: "Found",
			303: "See Other",
			304: "Not Modified",
			305: "Use Proxy",
			307: "Temporary Redirect",
			308: "Permanent Redirect",
			400: "Bad Request",
			401: "Unauthorized",
			402: "Payment Required",
			403: "Forbidden",
			404: "Not Found",
			405: "Method Not Allowed",
			406: "Not Acceptable",
			407: "Proxy Authentication Required",
			408: "Request Timeout",
			409: "Conflict",
			410: "Gone",
			411: "Length Required",
			412: "Precondition Failed",
			413: "Payload Too Large",
			414: "Request-URI Too Long",
			415: "Unsupported Media Type",
			416: "Requested Range Not Satisfiable",
			417: "Expectation Failed",
			418: "I'm a teapot",
			421: "Misdirected Request",
			422: "Unprocessable Entity",
			423: "Locked",
			424: "Failed Dependency",
			426: "Upgrade Required",
			428: "Precondition Required",
			429: "Too Many Requests",
			431: "Request Header Fields Too Large",
			444: "Connection Closed Without Response",
			451: "Unavailable For Legal Reasons",
			499: "Client Closed Request",
			500: "Internal Server Error",
			501: "Not Implemented",
			502: "Bad Gateway",
			503: "Service Unavailable",
			504: "Gateway Timeout",
			505: "HTTP Version Not Supported",
			506: "Variant Also Negotiates",
			507: "Insufficient Storage",
			508: "Loop Detected",
			510: "Not Extended",
			511: "Network Authentication Required",
			599: "Network Connect Timeout Error",
			},
		},
	});

/**
 * title
 * description
 * sub description
 *
 * xxx://xxx.xxx.xxx/xxx
 */

Object.defineProperty (Function, "query", {value: function () {}});
Object.defineProperty (Function.query, "selector", {value: function (key) { return document.querySelector (key.split (":").join ("\\:")); }});

Object.defineProperty (Function, "attribute", {value: function () {}});
Object.defineProperty (Function.attribute, "get", {value: function (key, dom) { if (dom) return dom.getAttribute (key) || ""; }});

/**
 * the end
 *
 * xxx://xxx.xxx.xxx/xxx
 */

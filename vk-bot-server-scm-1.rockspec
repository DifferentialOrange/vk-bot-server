package = 'vk-bot-server'
version = 'scm-1'
source  = {
	url = '/dev/null',
}
-- Put any modules your app depends on here
dependencies = {
	'tarantool',
	'lua >= 5.1',
	'http == 1.1.0'
}
build = {
	type = 'none';
}

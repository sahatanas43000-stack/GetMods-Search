import re
default = open('/usr/local/searxng/searx/settings.yml', encoding='utf-8').read()
names = set(re.findall(r'^\s*-\s*name:\s*(.+?)\s*$', default, re.M))
off_prefix = ('brave', 'duckduckgo', 'google', 'ahmia', 'torch')
on = ['bing', 'bing images', 'bing news', 'bing videos', 'yahoo', 'yahoo news', 'mojeek', 'mojeek images',
      'mojeek news', 'startpage', 'startpage images', 'startpage news', 'qwant', 'qwant images', 'qwant news',
      'qwant videos', 'yandex', 'yandex images', 'wikipedia', 'wikidata', 'wikimedia commons', 'openverse',
      'youtube', 'dailymotion', 'stract', 'marginalia', 'presearch', 'ecosia', 'bing images', 'github', 'stackoverflow', 'reddit', 'piped', 'archive is', 'wiby', 'searchmysite', 'brave goggles']
out = ['', 'engines:']
applied_on, applied_off = [], []
for n in sorted(names):
    if n.lower().startswith(off_prefix):
        out += ['  - name: ' + n, '    disabled: true']
        applied_off.append(n)
for n in on:
    if n in names:
        out += ['  - name: ' + n, '    disabled: false']
        if n in ('wikipedia', 'wikidata', 'bing images', 'qwant images'):
            out += ['    timeout: 7.0']
        applied_on.append(n)
out += ['', 'outgoing:', '  request_timeout: 3.5', '  max_request_timeout: 8.0', '  pool_connections: 100', '  pool_maxsize: 20', '  enable_http2: true', '']
open('/etc/searxng/settings.yml', 'a', encoding='utf-8').write('\n'.join(out))
print('GM engines ON :', applied_on)
print('GM engines OFF:', applied_off)

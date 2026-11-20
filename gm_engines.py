import re
default = open('/usr/local/searxng/searx/settings.yml', encoding='utf-8').read()
names = set(re.findall(r'^\s*-\s*name:\s*(.+?)\s*$', default, re.M))
off_prefix = ('brave', 'duckduckgo', 'google')
on = ['bing', 'bing images', 'bing news', 'bing videos', 'yahoo', 'yahoo news', 'mojeek', 'mojeek images',
      'mojeek news', 'startpage', 'startpage images', 'startpage news', 'qwant', 'qwant images', 'qwant news',
      'qwant videos', 'yandex', 'yandex images', 'wikipedia', 'wikidata', 'wikimedia commons', 'openverse',
      'youtube', 'dailymotion', 'stract', 'marginalia', 'presearch', 'ecosia']
out = ['', 'engines:']
applied_on, applied_off = [], []
for n in sorted(names):
    if n.lower().startswith(off_prefix):
        out += ['  - name: ' + n, '    disabled: true']
        applied_off.append(n)
for n in on:
    if n in names:
        out += ['  - name: ' + n, '    disabled: false']
        applied_on.append(n)
out += ['', 'outgoing:', '  request_timeout: 5.0', '  max_request_timeout: 9.0', '']
open('/etc/searxng/settings.yml', 'a', encoding='utf-8').write('\n'.join(out))
print('GM engines ON :', applied_on)
print('GM engines OFF:', applied_off)

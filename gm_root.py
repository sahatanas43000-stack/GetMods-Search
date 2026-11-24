import os
T='google-site-verification: googlec110e820703bcd93.html'
code='''

# GMROOT
@app.route('/googlec110e820703bcd93.html')
def gm_google_verify():
    from flask import Response
    return Response('%s', mimetype='text/html')
''' % T
for root,_,fs in os.walk('/'):
    if root.startswith(('/proc','/sys')): continue
    if root.endswith('searx') and 'webapp.py' in fs:
        p=os.path.join(root,'webapp.py'); s=open(p).read()
        if 'GMROOT' not in s:
            open(p,'w').write(s+code)
        print('GMDBG-ROOT',p)

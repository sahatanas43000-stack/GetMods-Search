import glob,os
b=open('/tmp/gm_brand.html').read()
for root,_,fs in os.walk('/'):
    if root.startswith(('/proc','/sys')): continue
    if root.endswith('templates/simple') and 'base.html' in fs:
        p=os.path.join(root,'base.html'); s=open(p).read()
        if 'gmbrand' not in s:
            s=s.replace('</head>',b+'</head>',1) if '</head>' in s else s+b
            open(p,'w').write(s)
        print('GMDBG-BASE',p,'gmbrand' in s)

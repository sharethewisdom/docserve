#!/usr/bin/env bash
root=/usr/share/doc
mv -f $root/index.html $root/index.html.old
trap '[[ "$?" -gt 0 ]] && mv -f $root/index.html.old $root/index.html' EXIT
trap 'exit 1' ERR
exec 1>$root/index.html

cat <<EOF
<!DOCTYPE html><html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="main.css">
  <script src="keyboard-nav.js"></script>
</head>
<body>
  <header>
    <h1>$root/**/index.html</h1>
    <pre>$(uname -onr)</pre>
  </header>
  <anchor-group>
EOF

files=( $(find $root/ -mindepth 2 -maxdepth 2 -type f -name index.html|sort) )
for file in ${files[@]#$root/}; do
  printf '       <a href="%s">%s</a>\n' $file ${file%%/*}
done

cat <<EOF
  </anchor-group>
</body>
</html>
EOF

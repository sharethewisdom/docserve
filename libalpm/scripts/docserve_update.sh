#!/usr/bin/env bash
root=/usr/share
[[ -e $root/index.html ]] && mv -f $root/index.html $root/index.html.old
trap '[[ "$?" -gt 0 ]] && mv -f $root/index.html.old $root/index.html' EXIT
trap 'exit 1' ERR
exec 1>$root/index.html

cat <<EOF
<!DOCTYPE html><html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="docserve/main.css">
  <script src="docserve/keyboard-nav.js"></script>
</head>
<body>
  <header>
    <h1>$root/**/index.html</h1>
    <pre>$(uname -onr)</pre>
  </header>
  <anchor-group selected="0">
EOF

files=( $(find $root/doc -mindepth 2 -maxdepth 2 -type f -name index.html|sort) )
for file in ${files[@]#$root/}; do
  printf '       <a href="%s">%s</a>\n' $file ${${file#doc/}%%/*}
done
  1>&2 echo ---------
files=( $(find $root -mindepth 2 -maxdepth 2 -type d -name doc -exec find '{}' -maxdepth 1 -type f -name '*.html' \;) )
for file in ${files[@]#$root/}; do
  printf '       <a href="%s">%s</a>\n' $file ${file%%/*}
done

cat <<EOF
  </anchor-group>
  <script>
    document.body.addEventListener('keydown', function initialFocus() {
      let group = document.getElementsByTagName('anchor-group')[0];
      if (group.hasAttribute('selected')) {
        let sel = group.getAttribute('selected');
        let anchors = Array.from(group.querySelectorAll('a'));
        anchors[sel].focus();
      }
      document.body.removeEventListener('keydown', initialFocus);
    });
  </script>
</body>
</html>
EOF

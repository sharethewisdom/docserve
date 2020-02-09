#!/usr/bin/env bash
set -o pipefail -o errexit
synopsis="$BASH_SOURCE [-h] [-r rootdir]"
OPTS="hr:"
purpose="Create a fresh index.html file with links to sibling index.html files in rootdir."
rights="Copyright (C) 2019 Bart De Roy"
tab=2
ntab=1
verbose=false
spaces="`printf '%0.1s'  \ {1..100}`"

out () {
  printf "%$((tab * ntab))s %s\n" "$@"
}

outv () {
  $verbose && printf "%$((tab * ntab))s %s\n" "$@"
}

err () {
  (>&2 printf "%$((tab * ntab))s %s\n" "$@")
}

for_each () {
  arr="$(declare -p $1)" ; eval "declare -A f="${arr#*=};
  for i in ${!f[@]}; do $2 "$i" "${f[$i]}"; done
}

usage () {
  ntab=2; err "usage:" "$synopsis"
}

show_help () {
  ntab=2; out "synopsis" "$synopsis"
  out "" "$purpose"
  out "" "$rights"
  exit 0
}

main() {
  if [[ $# -ge 1 ]]; then
    OPTIND=1
    while getopts $OPTS opt; do
      case "$opt" in
        h|help) show_help
          ;;
        r) root=$OPTARG
          ;;
      esac
    done
  fi
  shift $((OPTIND-1))
  [[ $1 == "--" ]] && shift
  [[ -z $root ]] && root=/usr/share/doc
  mv -f $root/index.html $root/index.html.old
  trap '[[ "$?" -gt 0 ]] && mv -f $root/index.html.old $root/index.html' EXIT
  trap 'exit 1' ERR
  exec 1>$root/index.html
  out "<!DOCTYPE html><html><head>"
  indent=$(printf "%*.*s" 0 $((tab * ntab + 1)) "$spaces")
  cat <<EOF | sed "s:^:$indent:g"
<style>
  html,body{
    font:16pt sans-serif;
    height:100%;background-color:#b0bfc9;
  }
  body{
    padding-bottom: 10em;
  }
  main{
    display:grid;grid-gap:0.2em 0.8em;
    align-items:center;justify-items:stretch;
    grid-template-columns:repeat(5,minmax(min-content,auto));
    min-height:100%;width:100%;
  }
  a{
    padding:.5em 1em;
    vertical-align:middle;
    text-decoration:none;
  }
  a:hover{
    color:#55c;background-color:#fff;
  }
  h1{font-size:120%;}
  h1,pre{text-align:center}
</style>
</head>
<body>
  <h1>$root/**/*</h1>
  <pre>$(uname -onr)</pre>
  <main>
EOF

  files=( $(find $root/ -mindepth 2 -maxdepth 4 -type f -name index.html|sort) )
  for file in ${files[@]#$root/}; do
    printf '       <a href="%s">%s</a>\n' $file ${file%%/*}
  done
  out "" "</main>"
  out "</body></html>"
}
main $@


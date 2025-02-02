if ! command -v web &>/dev/null; then
  echo Installing \"search-web\" ...
  npm i -g search-web &>/dev/null
  echo \"search-web\" installed
fi

alias mdn='web --engine=mdn'
alias npmjs='web --engine=npm'
alias github='web --engine=github'
alias youtube='web --engine=youtube'
alias yt='web --engine=youtube'
alias ff='web --browser=firefox'

domain() {
  curl --silent --write-out "%{http_code}\n" "https://www.whois.com/whois/$1" | grep -E "Creation Date:|Registry Expiry Date:"
}

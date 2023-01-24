apt install sudo && curl -L -o cirrus https://github.com/cirruslabs/cirrus-cli/releases/latest/download/cirrus-$(uname | tr '[:upper:]' '[:lower:]')-amd64 \
  && sudo mv cirrus /usr/local/bin/cirrus && sudo chmod +x /usr/local/bin/cirrus && cirrus worker run --token 7st43m2qsm55njdflpbq50m94f8s73kmc27u9p4c5qha9eueqptenjj9uen2s98j7hvou9b1oq9v9dv26pq76863tneh9vg5hosqvb --name lang

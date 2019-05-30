# http://stackoverflow.com/questions/5735666/execute-bash-script-from-url
bash <(curl -s http://mywebsite.com/myscript.txt)

# http://stackoverflow.com/questions/4642915/passing-parameters-to-bash-when-executing-a-script-fetched-by-curl
curl http://foo.com/script.sh | bash -s arg1 arg2
#!/bin/bash

# exit if any line fails
set -e

echo "GitHub username:"
read username

echo "Email address associated with GitHub account"
read email

echo "Generating SSH key..."
ssh-keygen -f ~/.ssh/id_rsa -N '' -t rsa -C "$email"
echo "SSH key created. The public key is:"
cat ~/.ssh/id_rsa.pub

echo "\nEnter a name for this computer on GitHub:"
read computerName
if [[ "$computerName" = "The Beast" ]]; then
  echo "\nThat is a great name for this fucking beast of a machine.\n"
  sleep 1
fi
# ideally this would check that a meaningful, alphanumeric value was entered, and if not, loop until it is

echo "Registering key with GitHub..."
echo "{\"title\":\""$computerName"\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}"

curl -u "$username" \
    --data "{\"title\":\"'$computerName'\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" \
    https://api.github.com/user/keys
sleep 1

echo -n "git clone git@github.com:iryan2/.dotfiles.git ~/dotfiles" | pbcopy
echo "Clone command for configuration repo has been copied to the clipboard. Run it to verify successful registration"

#
# Use this script to performs any commands that
# setup or update a fresh checkout

set -e;

# Check for Ruby Gem
command -v gem >/dev/null 2>&1 || {
    echo >&2 "I require 'gem' but it's not installed. Please install ruby. Aborting.";
    exit 1;
}

# check for Appledocs
# TODO

# Check for pod
command -v pod >/dev/null 2>&1 || {
    sudo gem install cocoapods
    pod setup
}

# Update/Install pods

if [ -e "Podfile.lock" ]
then
    echo "Updating pod files";
    pod update --verbose;
else
    echo "Installing pod files";
    pod install --verbose;
fi

#!@shell@

echo "Removing current generated files"
[ -e ./Gemfile.lock ] && rm ./Gemfile.lock
[ -e ./gemset.nix ] && rm ./gemset.nix

echo "Creating a Gemfile.lock by running @bundler@"
@bundler@ lock

echo "Create a gemset.nix by running @bundix@"
@bundix@ --lock

echo "Done"

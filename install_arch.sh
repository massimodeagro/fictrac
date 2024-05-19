#!/bin/sh

echo
echo "+------------------------------+"
echo "|    FicTrac install script    |"
echo "+------------------------------+"
echo

echo
echo "+-- Installing dependencies ---+"
echo

sudo pacman -S base-devel nlopt opencv # PROBABLY NOT EXHAUSTIVE! I HAVE ALREADY THINGS PREINSTALLED ON MY MACHINE. ALSO BASE-DEVEL IS PROBABLY OVERKILL

echo
echo "+------------------------------+"
echo "|    FicTrac install script    |"
echo "+------------------------------+"
echo
	
echo
echo "+-- Creating build directory --+"
echo
FICTRAC_DIR="$(dirname "$0")"
cd "$FICTRAC_DIR"	# make sure we are in fictrac dir
if [ -d ./build ]; then
  echo "Removing existing build dir"
  rm -r ./build
fi
mkdir build
if [ -d ./build ]; then
  echo "Created build dir"
  cd ./build
else
  echo "Uh oh, something went wrong attempting to create the build dir!"
  exit
fi
	
echo
echo "+-- Generating build files ----+"
echo
cmake ..

echo
echo "+-- Building FicTrac ----------+"
echo
cmake --build . --config Release --parallel $(nproc) --clean-first

cd ..
if [ -f ./bin/fictrac ]; then
  echo
  echo "FicTrac built successfully!"
  echo
else
  echo
  echo "Hmm... something seems to have gone wrong - can't find FicTrac executable."
  echo
fi

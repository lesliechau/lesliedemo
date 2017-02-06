#!/bin/bash
# Compiles, debugs, or runs your Swift app in a Docker container

function help {
  cat <<-!!EOF
    Usage: $CMD [ build | run <program> | debug | test ]

    Where:
      build                 Compiles your project
      run                   Runs your project
      debug                 Starts debug server and your program
      test                  Runs test cases
      install-system-libs   Installs any system libraries from dependencies
!!EOF
}

#----------------------------------------------------------
function debugServer {
  lldb-server platform --listen *:9090 &
  echo "Started debug server on port 9090."
}

#----------------------------------------------------------
function installSystemLibraries {

  # Fetch all of the dependencies
  echo "Fetching Swift packages"
  swift package fetch

  echo "Installing system dependencies (if any): "

  # Update the Package cache
  sudo apt-get update &> /dev/null

  egrep -R "Apt *\(" Packages/*/Package.swift \
    | sed -e 's/^.*\.Apt *( *" *//' -e 's/".*$//' \
    | xargs -n 1 echo

  # Install all the APT dependencies
  egrep -R "Apt *\(" Packages/*/Package.swift \
    | sed -e 's/^.*\.Apt *( *" *//' -e 's/".*$//' \
    | xargs -n 1 sudo apt-get install -y &> /dev/null
}

#----------------------------------------------------------
function buildProject {

  echo "Compiling the project..."
  swift build
}

#----------------------------------------------------------
function runTests {
  echo "Running tests..."
  swift test
}

#----------------------------------------------------------
function run {
  echo "Running program..."
  .build/debug/$PROGRAM_NAME
}

#----------------------------------------------------------
# MAIN
# ---------------------------------------------------------

# Runtime arguments
ACTION="$1"
PROGRAM_NAME="$2"

[[ -z $ACTION ]] && help && exit 0

# Enter the build directory
cd $HOME/project

case $ACTION in
"run")                 installSystemLibraries && buildProject && run;;
"build")               installSystemLibraries && buildProject;;
"debug")               debugServer && installSystemLibraries && buildProject && run;;
"test")                runTests;;
"install-system-libs") installSystemLibraries;;
*)                     help;;
esac

#!/bin/sh


# bash script example with yesworkflow
################################################################################
#     @begin InitialSetup  @desc Initalize Setup

################################################################################
#     @begin Check_Homebrew  @desc Check for homebrew on OSX
#     @in path


# which -s brew
# if [[ $? != 0 ]] ; then
#     # Install Homebrew
#     ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# else
#     brew update
# fi

command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew..."; \
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }
echo "Please wait (homebrew update) ^c to skip.."
brew update --verbose

#     @end Check_Homebrew

################################################################################
#     @begin Check_Java  @desc Check for homebrew on OSX
#     @in path
if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME
    _java="$JAVA_HOME/bin/java"
else
    echo "java not present - please install java runtime jre "
    echo "https://www.oracle.com/technetwork/java/javase/downloads/"
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.7" ]]; then
        echo "java version is more than 1.7 - ok"
    else
        echo "version is less than 1.5 - please install a more recent jre"
    fi
fi
#     @end Check_Java


################################################################################
#     @begin Get_Local_Path  @desc get local path for current working directory
#     @in path
# the demo at http://try.yesworkflow.org/ does not like this
pwd=$(which pwd)
local_dir=$($pwd)
bin_dir="$local_dir/.bin"
#     @end Get_Local_Path

################################################################################
#     @begin Create_BIN_directory  @desc create a directory where binary executables reside
#     @in path
if [ ! -d "$bin_dir" ]; then
  echo "creating $bin_dir...."
  mkdir -p "$bin_dir"
fi
#     @end Create_BIN_directory


################################################################################
#     @begin Download_YesWorkflow  @desc download YesWorkflow if it is not in path
#     @in path
# check for yesworkflow libs
FILE1="$bin_dir/yesworkflow-0.2.1-SNAPSHOT-jar-with-dependencies.jar"
FILE2="$bin_dir/yw-matlab-0.2-SNAPSHOT-jar-with-dependencies.jar"
if [ ! -f "$FILE1" ]; then
    echo "download to $FILE1"
    wget -O "$FILE1" "https://raw.githubusercontent.com/yesworkflow-org/yw-idcc-17/master/yw_jar/yesworkflow-0.2.1-SNAPSHOT-jar-with-dependencies.jar"
fi

if [ ! -f "$FILE2" ]; then
    echo "download to $FILE2"
    wget -O "$FILE2" "https://raw.githubusercontent.com/yesworkflow-org/yw-idcc-17/master/yw_jar/yw-matlab-0.2-SNAPSHOT-jar-with-dependencies.jar"
fi
#     @end Download_YesWorkflow


################################################################################
#     @begin Download_GraphViz  @desc download GraphViz if it is not in path
#     @in path
# check for graphviz
if brew ls --versions graphviz > /dev/null; then
  # The package is installed
  echo "graphviz detected"
else
  # The package is not installed
  brew install graphviz
fi
#     @end Download_GraphViz


################################################################################
#     @begin Download_librsvg  @desc download rsvg-convert
#     @in path
# check for rsvg-convert
if brew ls --versions librsvg > /dev/null; then
  # The package is installed
  echo "librsvg detected"
else
  # The package is not installed
  brew install librsvg
fi
#     @end Download_librsvg


################################################################################
#     @begin Check_Alias  @desc ensure yw alias exists
#     @in path
# check for yw alias
if [[ "$(grep '^alias yw=' ~/.bash* ~/.profile /etc/bash* /etc/profile)" ]]; then
   echo "found yw alias"
else
   echo "did not find yw alias"
   echo "" >> ~/.bash_profile
   echo "alias yw='java -jar $FILE1'" >> ~/.bash_profile
   echo "" >> ~/.bash_profile
   echo "alias yw_matlab='java -jar $FILE2'" >> ~/.bash_profile
   echo "" >> ~/.bash_profile
   source ~/.bash_profile
fi
#     @end Check_Alias


################################################################################
#     @end InitialSetup

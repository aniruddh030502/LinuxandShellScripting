#!/bin/bash
#Author : Aniruddha Das
#Purpose : To clone a git repo and deploy maven based java application on tomcat.
#Usage : ./assignment.sh

#Check if git is installed
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

echo "Enter the git repository URL"
read git_repo

#Check if the git repo is valid
if ! git ls-remote $git_repo &> /dev/null; then
  echo 'Error: Invalid git repository URL.' >&2
  exit 1
fi

#Check if maven is installed
if ! [ -x "$(command -v mvn)" ]; then
  echo 'Error: maven is not installed.' >&2
  exit 1
fi

#Check if tomcat is installed
if ! [ -x "$(command -v tomcat)" ]; then
  echo 'Error: tomcat is not installed.' >&2
  exit 1
fi

export CATALINA_HOME="C:/Users/290427/Downloads/apache-tomcat-10.1.34-windows-x64/apache-tomcat-10.1.34"

#Clone the git repo
git clone $git_repo

#Build the maven project
cd $(basename $git_repo .git)
mvn clean package

cp target/*.war C:\Users\290427\Downloads\apache-tomcat-10.1.34-windows-x64\apache-tomcat-10.1.34\webapps

$CATALINA_HOME/bin/catalina.bat start

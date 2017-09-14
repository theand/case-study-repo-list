#!/usr/bin/env bash

red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

CASE_STUDY=( Admin-Case-Study
Algorithm-Case-Study
Angular-Case-Study
Ansible-Case-Study
Atom-Case-Study
Bot-Case-Study
Chrome-Case-Study
Cloud-Case-Study
CodeKata-Case-Study
Crawler-Case-Study
Django-Case-Study
Docker-Case-Study
Electron-Case-Study
Flask-Case-Study
FrontEnd-Case-Study
General-Case-Study
iOS-Case-Study
JS-Case-Study
Java-Case-Study
Koan-Case-Study
Kotlin-Case-Study
Laracast
Laravel-Case-Study
LetsCodeJavaScript-Lab
LetsCodeJavaScript-LessonLearned
Markdown-Documents
My-Translation-Work
NodeJS-Case-Study
PHP-Case-Study
Python-Case-Study
Rails-Case-Study
React-Case-Study
Ruby-Case-Study
Security-Case-Study
Sinatra-Case-Study
Spring-Case-Study
SpringGuides-Case-Study
StaticSite-Case-Study
TIL
TodoXXX-Case-Study
TutsPlus-Resources
TypeScript-Case-Study
UserScript-Case-Study
Vagrant-Case-Study
Vue-Case-Study
Wiki-Case-Study
)

CASE_STUDY_EXCLUDE=( iOS-Case-Study
TutsPlus-Resources
)

shuffle() {
   local i tmp size max rand

   # $RANDOM % (i+1) is biased because of the limited range of $RANDOM
   # Compensate by using a range which is a multiple of the array size.
   size=${#CASE_STUDY[*]}
   max=$(( 32768 / size * size ))

   for ((i=size-1; i>0; i--)); do
      while (( (rand=$RANDOM) >= max )); do :; done
      rand=$(( rand % (i+1) ))
      tmp=${CASE_STUDY[i]} CASE_STUDY[i]=${CASE_STUDY[rand]} CASE_STUDY[rand]=$tmp
   done
}

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}


#################

#서브디렉토리들의 git remote 저장소 주소를 뽑아내기.
function get_all_git_origin(){
    for DIR in `\ls -f`;
    do
        if [[ -d $DIR ]] && [[ -d $DIR/.git ]]
        then
           cd $DIR ;
           git config --get remote.origin.url ;
           cd .. ;
        fi
    done
}

#지정한 디렉토리 목록에 대해서만 저장소 주소를 뽑아냄
function get_git_origin_from_txt(){
    while read line;
    do
        if [[ -d $line ]]
        then
            cd $line ;
            git config --get remote.origin.url ;
            cd ..;
        fi
    done < $1
}


#git 저장소 경로를 담고 있는 txt파일을 읽어서 프로젝트를 모두 clone.
function clone_repo_from_txt(){
    while read line;
    do
        git clone $line ;
    done < $1
}

#################

#서브디렉토리의 모든 git 저장소를 업데이트.
function update_git_all(){
    for DIR in `\ls -f`;
    do
        if [[ -d $DIR ]] && [[ -d $DIR/.git ]]
        then
            echo "Processing : $DIR"
            cd $DIR ;
            if git pull -X theirs;
            then
                echo "pull succeeded";
            else
                echo "${red} ${DIR} !!!git reset hard!!! ${reset}";
                git reset --hard origin/HEAD;
            fi
            git remote prune origin;
            cd .. ;
        fi
    done
}

#서브디렉토리의 모든 git 저장소를 gc
function gc_git_all(){
    for DIR in `\ls -A`;
    do
        if [[ -d $DIR ]] && [[ -d $DIR/.git ]]
        then
            echo "Processing : $DIR"
            cd $DIR ;
            git remote prune origin;
            git gc;
            cd .. ;
        fi
    done
}

function gc_git_all_sub(){
    shopt -u dotglob
    for DIR in `\ls -A`;
    do
        echo "In : $DIR"
        cd $DIR ;
        gc_git_all;
        cd ..;
    done
}



function works_update_all(){

    pushd .

    shuffle;

    for bname in "${CASE_STUDY[@]}"; do
        echo "==================="
        echo "Case Study : $bname"
        echo "==================="

        containsElement "$bname" "${CASE_STUDY_EXCLUDE[@]}"
        no_excludes=$?
        if [[ -d ~/Works/Study/$bname ]] && [[ no_excludes -eq 1  ]]
        then
            cd ~/Works/Study/$bname ;
            update_git_all ;
        else
            echo "${red}skip  ~/Works/Study/$bname${reset}"
        fi
    done

    popd
}
alias wua=works_update_all


function works_gc_all(){

    pushd .

    for bname in "${CASE_STUDY[@]}"; do
        echo "==================="
        echo "Case Study : $bname"
        echo "==================="

        containsElement "$bname" "${CASE_STUDY_EXCLUDE[@]}"
        no_excludes=$?
        if [[ -d ~/Works/Study/$bname ]] && [[ no_excludes -eq 1  ]]
        then
            cd ~/Works/Study/$bname;
            gc_git_all ;
        else
            echo "${red}skip  ~/Works/Study/$bname${reset}"
        fi
    done

    popd
}
alias wga=works_gc_all

#################


function reset_git_origin(){
    if [[ -d .git ]]
    then
        git reset --hard origin
    fi
}

function check_not_git(){
  for DIR in `\ls -f`;
  do
      if [[ ! -d $DIR/.git ]]
      then
          echo "${red}not git : ${DIR} ${reset}"
      fi
  done
}




################
function create_txt_for_all_casestudy(){

    mkdir ~/Works/Study/case-study-repo-list-new/ -p
    rm -f ~/Works/Study/case-study-repo-list-new/*.txt
    for d in ${CASE_STUDY[@]}; do
        echo $d
        cd ~/Works/Study/$d
        get_all_git_origin > ../case-study-repo-list-new/${d}.txt
    done

    cd ~/Works/Study/case-study-repo-list-new
    bcomp  ~/Works/Study/case-study-repo-list-new  ~/Works/Study/case-study-repo-list
}


################
function clone_repo_for_all_casestudy(){

    for d in ${CASE_STUDY[@]}; do
        echo $d
        mkdir -p ~/Works/Study/$d;
        cd ~/Works/Study/$d;
        clone_repo_from_txt ../case-study-repo-list/${d}.txt
    done

    cd ~/Works/Study
}




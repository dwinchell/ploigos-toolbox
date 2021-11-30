#!/bin/bash
STEP=$1
IMPORT_URL=$2
RESULT=0

print_big() {
  MESSAGE=$1
  echo
  echo "####################################################################################################"
  echo "############################     ${MESSAGE}     ##########################################"
  echo "####################################################################################################"
  echo
}

print_result() {
  STEP_NAME=$1
  if [[ ${RESULT} == 0 ]]; then
      print_big "${STEP_NAME} PASS"
  else
      print_big "${STEP_NAME} FAIL"
  fi
}

unit-test() {
  if [ -f "pom.xml" ]; then
   print_big "USING MAVEN"
    echo "Detected pom.xml. Using Maven. You can configure PSR to change this."
    mvn test
    RESULT=$?
  elif [ -f "package.json" ]; then
    print_big "USING_NPM"
    echo "Detected package.json. Using npm. You can configure PSR to change this."
    npm test
    RESULT=$?
  else
    echo "Error: no step implementer specified in configuration and could not auto-detect which one to use."
  fi

}

security() {

  #snyk test
  #mvn org.owasp:dependency-check-maven:check
  dependency-check -s .
  RESULT=$?
}

import() {
  wget ${IMPORT_URL}
}

quality() {

  if [ -f "pom.xml" ]; then
    print_big "USING MAVEN"
    echo "Detected pom.xml. Using Maven. You can configure PSR to change this."
    mvn checkstyle:check
    RESULT=$?
  elif [ -f "package.json" ]; then
    print_big "USING NPM"
    echo "Detected package.json. Using npm. You can configure PSR to change this."
    #cat package.json | jq .devDependencies.jslint | grep \"
    npx jslint .
    RESULT=$?
  else
    echo "Error: no step implementer specified in configuration and could not auto-detect which one to use."
  fi
}

watch() {
 OLD_HASHES=""
 while [[ true ]]
 do
   NEW_HASHES=$(find . -type f -exec md5sum {} \;)
   if [ "${OLD_HASHES}" != "${NEW_HASHES}" ]; then
     all
   fi
   OLD_HASHES=${NEW_HASHES}
   sleep 1
 done
}

all() {
  unit-test
  #security
  #quality
}



display() {
  STEP_FUNC=$1
  STEP_NAME="${2}"

  print_big "RUNNING ${STEP_NAME}"

  ${STEP_FUNC}

  print_result ${STEP_NAME}
}

run() {
  if [ "${STEP}" == "unit-test" ]; then
    display unit-test 'UNIT_TEST'
  elif [ "${STEP}" == "security" ]; then
    display security 'SECURITY_SCAN'
  elif [ "${STEP}" == "quality" ]; then
    display quality 'QUALITY_SCAN'
  elif [ "${STEP}" == "all" ]; then
    all
  elif [ "${STEP}" == "watch" ]; then
    watch
  elif [ "${STEP}" == "import" ]; then
    import
  fi}

run

#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN() {
  if [[ -z $1 ]]
  then
    	echo "Please provide an element as an argument."
  else
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      SELECTED_VALUE=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    else
      SELECTED_VALUE=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
    fi
    if [[ -z $SELECTED_VALUE ]]
    then
      echo "I could not find that element in the database."
    else
      INFORMATION=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$SELECTED_VALUE")
      IFS="|"
      read TYPE_ID NR SYMBOL NAME MASS MELTING BOILING TYPE  <<< $INFORMATION
      echo "The element with atomic number $NR is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    fi
  fi
}

MAIN $1

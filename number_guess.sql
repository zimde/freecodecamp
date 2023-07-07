#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

NUM_TO_GUESS=$((RANDOM % 10))

MAIN() {
  echo "Enter your username:"
  read USERNAME
  if [[ -z $USERNAME || ${#USERNAME} -gt 22 ]]
  then 
    MAIN
  else
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
    if [[ -z $USER_ID ]]
    then 
      echo "Welcome, $USERNAME! It looks like this is your first time here."
      INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES ('$USERNAME')")
      USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
    else
      USER_INFO=$($PSQL "SELECT COUNT(*),MIN(guesses) FROM games WHERE user_id=$USER_ID")
      IFS="|"
      read GAMES_PLAYED MIN_GUESSES <<< $USER_INFO
      echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $MIN_GUESSES guesses."
    fi
    IFS=" "
    echo "Guess the secret number between 1 and 1000:"
    read GUESS
    GUESS_COUNT=1
    while [[ $GUESS != $NUM_TO_GUESS ]]
    do
      if [[ ! $GUESS =~ ^[0-9]+$ ]]
      then
        echo "That is not an integer, guess again:"
      elif [[ $GUESS -gt $NUM_TO_GUESS ]]
      then
        echo "It's lower than that, guess again:"
      else
        echo "It's higher than that, guess again:"
      fi
      read GUESS
      (( GUESS_COUNT++ ))
    done
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $NUM_TO_GUESS. Nice job!"
    INSERT_GAME=$($PSQL "INSERT INTO games(user_id,guesses) VALUES ($USER_ID,$GUESS_COUNT)")
  fi
}

MAIN

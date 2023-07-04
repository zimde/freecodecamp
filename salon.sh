#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t -c"

echo -e "\n~~~~~ MY SALON ~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
    then
      echo -e "\n$1"
  else
    echo -e "Welcome to My Salon, how can I help you?\n"
  fi
  SERVICES=$($PSQL "SELECT service_id,name FROM services")
  if [[ -z $SERVICES ]]
    then
      echo "We are currently unavailable please come back later."
  else
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done
  fi
  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
      MAIN_MENU "Please enter a number! What would you like today?"
  else
    SERVICE=$($PSQL "SELECT service_id,name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    if [[ -z $SERVICE ]]
      then
        MAIN_MENU "I could not find that service. What would you like today?"
    else
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      if [[ -z $CUSTOMER_ID ]]
        then
          echo -e "\nI don't have a record for that phone number, what's your name?"
          read CUSTOMER_NAME
          INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone,name) VALUES ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      fi
      CUSTOMER=$($PSQL "SELECT customer_id,name FROM customers WHERE phone='$CUSTOMER_PHONE'")
      read CUSTOMER_ID BAR CUSTOMER_NAME <<< $CUSTOMER
      read SERVICE_ID BAR SERVICE_NAME <<< $SERVICE
      echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME."
      read SERVICE_TIME
      INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES ($CUSTOMER_ID,$SERVICE_ID,'$SERVICE_TIME')")
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}

MAIN_MENU

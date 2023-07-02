#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo "$($PSQL "TRUNCATE TABLE games,teams")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
    then
      TEAM_ID_WINNER="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
      TEAM_ID_OPPONENT="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"
      if [[ -z $TEAM_ID_WINNER ]]
        then
          INSERT_TEAM_ID_WINNER="$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")"
          if [[ $INSERT_TEAM_ID_WINNER == "INSERT 0 1" ]]
            then
              echo Inserted into teams, $WINNER
          fi
          TEAM_ID_WINNER="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
      fi
      if [[ -z $TEAM_ID_OPPONENT ]]
        then
          INSERT_TEAM_ID_OPPONENT="$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")"
          if [[ $INSERT_TEAM_ID_OPPONENT == "INSERT 0 1" ]]
            then
              echo Inserted into teams, $OPPONENT
          fi
          TEAM_ID_OPPONENT="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"
      fi
      INSERT_GAME_ID="$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES ($YEAR,'$ROUND',$TEAM_ID_WINNER,$TEAM_ID_OPPONENT,$WINNER_GOALS,$OPPONENT_GOALS)")"
      echo Inserted into games, $YEAR:$ROUND:$TEAM_ID_WINNER:$TEAM_ID_OPPONENT:$WINNER_GOALS:$OPPONENT_GOALS
  fi
done

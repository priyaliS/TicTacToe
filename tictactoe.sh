#! /bin/bash
echo "Welcome to TicTakToe game"

function resetting()
{

        player=1
        array=(@ @ @ @ @ @ @ @ @ )
        gamePosition=1
}
function columnChecking()
{

                for (( i=0; i<3; i++ ))
                do
                        j=0
                        if [ ${array[$(( $j *3 + $i ))]} != "@" ] && [ ${array[$(( $j *3 + $i ))]} == ${array[$(( $j+1 *3 + $i ))]} ] && [ ${array[$(( $j+1 *3 + $i ))]} == ${array[$(( $j+2 *3 + $i ))]} ]
                        then
                                gamePosition=0
                        fi
                done
}

function rowChecking()
{

                for (( i=0; i<3; i++ ))
                do
                        j=0
                        if [ ${array[$(( $i *3 + $j ))]} != "@" ] && [ ${array[$(( $i *3 + $j ))]} == ${array[$(( $i *3 + $j+1 ))]} ] && [ ${array[$(( $i *3 + $j+1 ))]} == array[$(( $i *3 + $j+2 ))]} ]
                        then
                                gamePosition=0
                        fi
                done
}

function diagonalChecking()
{
        if [ ${array[0]} != "@" ] && [ ${array[0]} == ${array[4]} ] && [ ${array[4]} == ${array[8]} ]
        then
                gamePosition=0
        elif [ ${array[2]} != "@" ] && [ ${array[2]} == ${array[4]} ] && [ ${array[4]} == ${array[6]} ]
        then
                gamePosition=0

        fi
}
function checkingTie()
{

        if [ ${array[0]} != "@" ] && [ ${array[1]} != "@" ] && [ ${array[2]} != "@" ] && [ ${array[3]} != "@" ] && [ ${array[4]} != "@" ] &&
                [ ${array[5]} != "@" ] && [ ${array[6]} != "@" ] && [ ${array[7]} != "@" ] && [ ${array[8]} != "@" ]
        then
                gamePosition=2
        fi
}
function checkBox()
{

        checkingTie
        rowChecking
        columnChecking
        diagonalChecking
}

function playingBox()
{
        echo "row 0  ${array[0]} ${array[1]} ${array[2]}"
	echo "row 1  ${array[3]} ${array[4]} ${array[5]}"
	echo "row 2  ${array[6]} ${array[7]} ${array[8]}"
}

function toss()
{

        echo "Options :"
        echo "1. Head"
        echo "2. Tails"

        read -r tossOption

        tossNum=$(( (( $RANDOM%2 ))+1 ))

        if [ $tossNum -eq $tossOption ]
        then
                echo "player won the toss"
        elif [ $tossNum -ne $tossOption ] && [ $tossOption -lt 3 ]
        then
                echo "player lost toss"
                player=$(( (( $player%2 ))+1 ))
        else
                echo "enter valid input"
                toss
        fi

}
function symbols()
{
        if [ $(( $RANDOM%2 )) -eq 1 ]
        then
                playerOneSymbol=X
		playerTwoSymbol=O
        else
		playerOneSymbol=O
                playerTwoSymbol=X
        fi

        echo "player one choosed "$playerOneSymbol
	echo "player two choosed "$playerTwoSymbol
	toss

}

function setBox()
{
	arrayId=$(( $(( $1-1 )) * 3 + $(( $2-1)) ))

        if [ ${array[$arrayId]} == "@" ]
        then
                array[$arrayId]=$3
        else
                echo "invalid placing"
                player=$(( (( $player%2 ))+1 ))
        fi
}

function input()
{
 if [ $player -eq 1 ]
        then
                playerSymbol=$playerOneSymbol
        else
                playerSymbol=$playerTwoSymbol
        fi

                echo "to set a value enter : set [row number] [column number]"
                echo "to restart the game enter : reset"
                read -r command row column

                if [ $command == "set" ]
                then
                        setBox $row $column $playerSymbol
                elif [ $command == "reset" ]
                then
                        gameBegins
                else
                        echo "enter a valid input"
                        input
                fi

}
function gameBegins()
{
	resetting
        symbols

        echo "player "$player "can play now"

	while [ $gamePosition -eq 1 ]
	do
        	playingBox
		input
		checkBox

		if [ $gamePosition -eq 0 ]
		then 
			playingBox
			echo "player "$player "won "
		elif [ $gamePosition -eq 2 ]
		then
			playingBox
			echo "tie"
			gamePosition=0
		else
			player=$(( (( $player%2 ))+1 ))

			echo "player "$player "can play now"
		fi
	done
}

gameBegins

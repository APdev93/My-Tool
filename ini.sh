array=( "$@" ); # read command line arguments array

if [[ "$EUID" -ne 0 ]] # check if script was ran with root privileges
then 
	echo "USAGE: sudo bash create-unix-users.sh user1 user1pass user2 user2pass";
	echo "Run the script with root privileges";
  	exit 128;
fi

if [[ -z "$array" ]] # check if login/pass pairs were specified
then
	echo "USAGE: sudo bash create-unix-users.sh user1 user1pass user2 user2pass (specify login/pass pairs delimited by space)";
	exit 128;
fi

if [[ $((${#array[@]}%2)) -ne 0 ]] # check if number of arguments passed is even
then
	echo "USAGE: sudo bash create-unix-users.sh user1 user1pass user2 user2pass (uneven numbers of arguments passed)";
	exit 128;
fi

declare -A credentials; # create an associative array to store login/pass values
i=0;

for element in "${array[@]}" # convert indexed array to associative array (credentials[user1]=user1pass, credentials[user2]=user2pass, ...)
do
	if [[ "$(( i%2 ))" -eq 0 ]] # usernames have even indices (0,2,4, ...); password are on odd indices (1,3,5)
	then
		tmp=$element; # store username in temporary variable, proceed next
	else
		credentials[$tmp]=$element; # add to the associative array in case odd index is reached (password)
	fi
	((i++)); 
done

printf "%-10s \t %-10s\n" "USER" "PASSWORD"; # display the content of associative array
printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -;

for username in "${!credentials[@]}"
do
	password="${credentials[$username]}";
	printf "%-10s \t %-10s\n" $username $password;
done

printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -;

read -p "Continue? (y/n): " proceed;

printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -;

if [[ "${proceed,,}" != "y" ]] # ${proceed,,} converts the input to lowercase
then
	echo "Canceled";
	exit 130;
fi

for username in "${!credentials[@]}" # !credentials[@] means looping through the keys (i.e. usernames)
do
	useradd $username; # user creation
	printf "%-10s \t %-10s\n" $username "CREATED";
done

printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -;

for username in "${!credentials[@]}" # !credentials[@] means looping through the keys (i.e. usernames)
do
	(echo ${credentials[$username]}; echo ${credentials[$username]}) | passwd $username; # password setting
	printf "%-10s \t %-10s\n" $username "PASSWORD SET";
done

printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -;

for username in "${!credentials[@]}" # !credentials[@] means looping through the keys (i.e. usernames)
do
	mkhomedir_helper $username; # homefolder creation
	printf "%-10s \t %-10s\n" $username "HOMEFOLDER CREATED";
done

printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -;

echo -e "Completed.\n";

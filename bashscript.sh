1. File and Directory Operations

#!/bin/bash
# Script to create a file, directory, and copy file into directory

echo -n "Enter filename: "
read filename
touch "$filename"

echo -n "Enter directory name: "
read dirname
mkdir -p "$dirname"

cp "$filename" "$dirname"


# Summary: This script prompts the user for a filename and a directory name, 
# creates them, and then copies the file into the directory.
=======================================================================================

2. File Operations and Symbolic Links

#!/bin/bash
# Script to demonstrate file operations
# Author: Team12 Engineers

echo "Executing as $USER from $(pwd)"

echo -n "Enter your name: "
read name
echo -n "Enter your team at Etech: "
read team

echo "Welcome to EtechDevOps Onboarding" > "$name"
mkdir -p "$team"
cp "$name" "$team/"
ln -s "$team/$name" "/tmp/$name"

ls /tmp | grep "$name"


# Summary: This script creates a file named after the user, places it in a team directory, 
# and creates a symbolic link in /tmp.

==========================================================================================

3. Mounting and Unmounting an EBS Volume

#!/bin/bash
# Automate mounting EBS volumes
# Author: Christian

lsblk
sleep 3

echo -n "Enter mount point directory name: "
read dir_name

sudo mkdir -p "/mnt/$dir_name"
sudo mkfs -t ext4 "/dev/xvdf"
sudo mount "/dev/xvdf" "/mnt/$dir_name"
echo "/dev/xvdf /mnt/$dir_name ext4 defaults 0 1" | sudo tee -a "/etc/fstab"

sleep 3
echo "Unmounting the EBS volume..."
sudo umount "/mnt/$dir_name"
sudo rm -rf "/mnt/$dir_name"
sudo sed -i "/$dir_name/d" /etc/fstab

cat /etc/fstab


# Summary: This script automates mounting, persisting, unmounting, and removing an EBS 
# volume in an EC2 instance.

==========================
another example:

Learning how to Add an EBS Volume in to an EC2 Instance: Improved script with AI with less noise


#!/bin/bash

# EBS Volume Auto Mount
# Author: Christian

echo -n "enter mount point dirctory name: "
read -r dir_name

if [ -z "/mnt/$dir_name" ]; then 
	echo "Directory name cannot be empty"
	exit 1
fi 

if [ -d "/mnt/$dir_name" ]; then 
	echo "Directory already exit"
	exit 1
fi

sudo mkdir -p "/mnt/$dir_name"
sudo mkfs -t ext4 "/dev/xvdf"
sudo mount "/dev/xvdf' "/mnt/$dir_name"
echo "/dev/xvdf" "/mnt/$dir_name" ext4 defaults 0 1" | sudo tee -a "/etc/fstab"

lsblk
sleep 3

sudo umount "/dev/xvdf" "/mnt/$dir_name"
sudo rm -rf /mnt/$dir_name
sudo sed -i "/$dir_name/d" "/etc/fstab"
cat "/etc/fstab"

#raw extract. Run sucessfully: creating and removing EBS volume in CLI
==========================================================================================

4. Array Operations & Looping

#!/bin/bash
# Array and loop operations

fruits=("mango" "banana" "orange" "strawberry")

for fruit in "${fruits[@]}"; do
    echo "$fruit"
    [[ "$fruit" == "orange" ]] && break
done


 # Demonstrates iterating over an array, printing elements, and breaking when a condition 
 # is met.

============	===========		
 original example:

 		  0      1      2        3
fruits=(mango banana orange strawberry)

length=(fruits)=4

fruits[0]=mango
fruits[1]=banana
fruits[2]=orange
fruits[3]=strawberry

fruits[@]=all

for item in ${fruits[@]}; done				
	echo $item
done


# learning

# for item in ${fruits[@]}; do
# 	echo $item
# 	i=[$item +1]
# done



for item in ${fruits[@]}; do
	echo $item
	if [ $item="orange"]; then
		break
	fi
done
 ==========================================================================================

5. Secure File Transfer Across Multiple Servers

#!/bin/bash
# Securely transfer log files to multiple servers

items=$(sudo find / -name "*.log" 2>/dev/null)
servers=("ip1" "ip2" "ip3")
users=("u1" "u2" "u3")

for file in $items; do
    for server in "${servers[@]}"; do
        for user in "${users[@]}"; do
            scp -i key "$file" "$user@$server:$location"
        done
    done
done


# Summary: Finds all .log files and securely copies them to multiple servers and users.
 ==========================================================================================

 6. ATM PIN Verification

#!/bin/bash
# ATM PIN Verification Script

pin="2025"
echo -n "Please enter your PIN: "
read -s entered_pin

if [[ "$entered_pin" == "$pin" ]]; then
    echo -e "\nWelcome to Bank of America"
else
    echo -e "\nIncorrect PIN. Please try again."
fi


# Summary: This script verifies a user's PIN and allows access if correct.
==========================================================================================

7. Summation of Two Numbers

#!/bin/bash
# Simple Calculator for Addition

echo -n "Enter first number: "
read num1
echo -n "Enter second number: "
read num2

sum=$((num1 + num2))
echo "The sum of $num1 and $num2 is: $sum"


# Summary: Prompts the user for two numbers and calculates their sum.


=========	===========
original example: 

if (condition); then 
	action if condition is true
fi

if (condition1); then 
	action if condition is true
elif (condition2); then 
	action if condition2 is true
else
	action if condition1 is false
	action if condition2 is false
fi
fi

		status=$?

		echo $? = 0    ==> Uversal correctness
		echo $? = 1    ==> permission denied
		echo $? = 127  ==> command not found
		echo $? = 130  ==> process terminated with Crtl C 
==========================================================================================

8. Checking File Permissions

#!/bin/bash
# Checks and assigns file permissions
echo -n "Enter filename to check permissions: "
read filename

if [[ -f "$filename" && -r "$filename" && -w "$filename" && -x "$filename" ]]; then
    echo "The file exists and has all required permissions."
else
    echo "Updating permissions for $filename..."
    sudo chmod ugo+rwx "$filename"
    ls -l "$filename"
fi


# Summary: Checks if a file has read, write, and execute permissions. If not, it grants 
# them.
==========================================================================================

9. Checking if a User Exists

#!/bin/bash
# Checks if a user exists in the system

echo -n "Enter username to check: "
read username

if grep -q "^$username:" /etc/passwd; then
    echo "User $username exists in the system."
elif [[ -d "/home/$username" ]]; then
    echo "Home directory for $username exists, but the user account does not."
else
    echo "User and home directory do not exist."
fi


# Summary: Checks if a user exists in the system and whether their home directory is 
# present.
==========================================================================================

10. File Transfer to AWS S3

#!/bin/bash
# Automates log file transfer to an AWS S3 bucket

bucket_name="team12-etech-demo1"
location="logfiles"
common_point="testdir"

mkdir -p "$common_point"

sudo find / -type f -name "*.log" 2>/dev/null | while read -r file; do
    cp "$file" "$common_point"
done

for object in $(ls -A "$common_point"); do
    aws s3 cp "$common_point/$object" "s3://$bucket_name/$location"
done


# Summary: Finds all log files and uploads them to an AWS S3 bucket.
==========================================================================================

11. Function Demonstration: User Management

#!/bin/bash
# Function-based script for user creation

user=$1  # Universal variable

create_user() {
    local env=$2
    sudo mkdir -p "$env"
    sudo adduser "$user"
    echo "User $user has been created in environment $env."
}

assign_sudo() {
    echo "$name ALL=(ALL:ALL) ALL" | sudo tee -a "/etc/sudoers"
}

add_group() {
	echo "adding $user to desired group"
	read group
    sudo usermod -aG $group "$user"
}

create_user
assign_sudo
add_group


# Summary: Creates a user, grants sudo privileges, and assigns them to a group.
==========================================================================================

12. Copying Files to Remote Servers

#!/bin/bash
# Securely copy scripts to remote servers

[ -z "$1" ] && { echo "Error: Username required"; exit 1; }

mapfile -t files < <(sudo find "/home/ubuntu/scripts" -type f -name "*.sh" 2>/dev/null)
[ ${#files[@]} -eq 0 ] && { echo "Error: No files found"; exit 1; }

hosts=("testa" "testb")

for server in "${hosts[@]}"; do
    echo "Copying files to $server..."
    for file in "${files[@]}"; do
        scp "$file" "$1@$server:/tmp/cpfiles/" 2>/dev/null || echo "Error copying $file to $server"
    done
    echo "Finished copying files to $server."
done


# Summary: Copies all script files from a directory to remote servers for a given user.
==========================================================================================

Other examples already explained above

==========================================================================================
Logic functions

functions

!#/bin/bash
students=(john mary peter paul esther james)  #global variable

# function block starts here

create_user(){
	class_name=(team10 team11 team12)  #local variable
	for class in ${class_name[@]}; do
	for student in ${students[@]}; do
		sudo adduser $students
		echo "$student is in $class"
	done
done
file_create  # Nested function is a function whereby you call a function inside another function. 
}

lists=(s1 s2 s3 s4 s5 s6)  #global variable

file_create(){
	for student in ${students[@]}; do 
		touch file-$student.log
	done
}

create_user

#demo only, not run
=======================================================================================
#!/bin/bash
#script to automate file transfer to an aws s3 bucket

bucket_name="team12-etech-demo1"
location="scripts"
common_point="testdir2"

# files=$(ls -l *.log)
mkdir testdir2

search_log(){

	files=$(sudo find . -type f -name "*.sh")
	for file in ${files[@]}; do
		cp "$file" "$common_point"
	done
}

file_copy(){
	objects=$(ls "$common_point")
	for object in ${objects[@]}; do
		aws s3 cp "$common_point/$object" "s3://$bucket_name/$location"
	done
}

search_log
file_copy

#sucessful run
============================================================================ 

#!/bin/bash
#Author: Engr Christian
#Company: Etech Consulting, LLC
# This script will be used to test if a certain file has all read write and execution permissions
# Then assign the permission to the file
echo -n "Please enter the filename to check it's persionssion: "
read filename
if [ -f $filename ]&&[ -r $filename ]&&[ -w $filename ]&&[ -x $filename ]; then
	echo "The file exist and it has all the permissions required."
	ls -l $(pwd) | grep $filename
else
	echo "The file lacks some permissions, we are going to add those permissions as follows:"
	echo "see the permissions before we use the scriopt to change it for your clarity!!"
	ls -l $(pwd) | grep $filename
	sleep 3
	echo "Permissions change starting..."
	sleep 3
	sudo chmod ugo=rwx $filename
	echo "see details below"
	ls -l $(pwd) | grep $filename
	sleep 5
fi

#sucessful
========================================================================================================

#!/bin/bash
#Author:Engr Christian
#Company: Etech Consulting llc
#Script will be use to test if nginx website is up and running and take actions
if curl -s http://ec2-52-87-163-123.compute-1.amazonaws.com/; then
  echo "nginx is up and running"
  exit 0
else
  echo "nginx is down"
  exit 1
  echo "The exit status was captured to be `echo $?`"
  #api call connection to azure function to trigger email notifications
fi

#successful
======================================================================================================

#!/bin/bash
# Checking if a user and their home directory exist in the system
echo -n "Please enter the username to check: "
read username
echo "Search Engine Activated!!!...Searching.."

if grep $username /etc/passwd; then 
	echo "The user account for $username exits in the system.. "
	echo " The user $username is part of Etech Consulting Devops Group"
elif ls -d /home/$username; then
	echo "The directory for $username exist in the system "
	echo "Even though the $username account does not exist "
else
	echo "The user home direcory does not exist in the system"
	echo "The user account for $username does not exist"
fi

#successful
========================================================================================

#!/bin/bash
#Author: Christian
#Etech Consulting, LLC
#using CLI parameters to pass the argument at during execution time

bucket_name=$1
prefix=$2

files=$( sudo find . -type f -name "*.sh" )
for file in ${files[@]}; do
	aws s3 cp "$file" "s3://$bucket_name/$prefix/"
done

#sucessful

=========================================================================================

#!/bin/bash
# hostname testa and testb have been mapped to private_ip for 2 separate users 
#which will be passed as a CLI parameter (user1=john user2=etech)

user=$1
hosts=("testa" "testb")

files=$(sudo find "/home/ubuntu/scripts" -type f -name "*.sh")

for server in "${hosts[@]}"; do
    for file in "${files[@]}"; do
        scp "$file" "$user@$server:/tmp/cpfiles/"
    done
done

# above script is not successful d/t corrected bellow 
==========	=============	=============	==========	=========	===========

#!/bin/bash
# hostname testa and testb have been mapped to private_ip for 2 separate users 
#which will be passed as a CLI parameter (user1=john user2=etech)

user=$1
hosts=("testa" "testb")

# Correct way to store find results in an array
mapfile -t files < <(sudo find "/home/ubuntu/scripts" -type f -name "*.sh")

for server in "${hosts[@]}"; do
    for file in "${files[@]}"; do
        scp "$file" "$user@$server:/tmp/cpfiles/"
    done
done

#works without error-proof, spaces handling, and minimizing with short-circuit logic
=========	==========	=============	===========	=============	================

#!/bin/bash

# Ensure a username is provided
[ -z "$1" ] && { echo "Error: Username is required"; exit 1; }

# Store script files in an array
mapfile -t files < <(sudo find "/home/ubuntu/scripts" -type f -name "*.sh" 2>/dev/null)
[ ${#files[@]} -eq 0 ] && { echo "Error: No files found"; exit 1; }

hosts=("testa" "testb")

# Copy files to each server
for server in "${hosts[@]}"; do
    echo "Copying files to $server..."
    for file in "${files[@]}"; do
        scp "$file" "$1@$server:/tmp/cpfiles/" 2>/dev/null || echo "Error copying $file to $server"
    done
    echo "Finished copying files to $server"
done
 
#best compilation of copying files
=====================================================================================
for day in ! mon Tue Wed Thurs Fri Sat Sun ; do 
	echo $day
done

for file in $(ls /tmp); do
	cp $file /opt 
	scp -i key $file ubuntu@$location
done

file_name=$(touch logs{1..10})
i=0
for file in ${file_name[@]}; do
	echo "We are Etech Engineers, $file" >> name.txt
	i=((i++))
done



#!/bin/bash

mkdir -p logtest # Ensure the directory exists

counter=1 # initialize counter 

for i in {1..10}; do
	file="logtest/logs$i"
	echo "This was generated from file creation test" > "logtest/logs$i"
	echo "Created: $file (File $counter of 10)"
	((counter++)) # Increment counter
done

=================================================================================
while loop: use to loop over a process unless the condition changes
# for loop is finite based on the number of items in the list while "while loop" can be finite or infinite

example:

#!/bin/bash
while true; do # used to stress test a system
	echo "ok"
done

=================================================================================
until loop: used to iterate over a set of process until condition changes

example:

#!/bin/bash

a=10

until [ a -lt 10 ]; do 
	echo $a
	a=$(($a + 1))
done

example: some CICD application

#!/bin/bash
codecoverage=85
until [ "$codecoverage" -gt 90 ]; do
	echo "Build Failure"
done

==========================================================
Function demo:

#!/bin/bash
# script to demo functions and their applications

name=$1   #universal or global variable because it's defined outside all functions and can be called by any of the functions. if it were defined inside the function, it will be a local variable
user_create(){
  env=$2
  sudo mkdir $env
  sudo adduser $name
  echo "User with name $name has been created"
}

sudo_add(){
  echo " $name ALL=(ALL:ALL) ALL " | sudo tee -a "/etc/sudoers"
  sudo cat /etc/sudoers | grep $name
}

group_add(){
  sudo usermod -aG ubuntu $name
  cat /etc/passwd | grep $name
}

user_create
sudo_add
group_add

# back up with ~$cat /etc/sudoers > sudoersbackup #file recovery in case of damage to sudoers file. Also with sshd_config file
=================================================================================
Pass parameters to a Function:

You can define a function that will accept command line parameters while calling the functions
These parameters would be represented by $1 $2 and so on...

example

#!/bin/bash
# Define your function here
Hello () {
	echo "Hello World $1 $2"
}

$ Invoke your function
Hello $1 $2
========================================
Returning values from function:

notes: 
If you execute an exit command from inside a function, its effect is not only to termiate execution of the function but also of the shell program that called the function
If you instead just want to terminate execution of the function, then there is a way to come out of a defined function.
Based on the situation you can return any value from your function using the return command whose syntax is as follows -

return code

example:
#!/bin/bash

# Define your function here
Hello () {
	echo "Hello World $1 $2"
	# return 10 	
	exit 5 	#used to alter (mask) a successful function execution by the operator. E.g, standard: echo $? =0, here, echo $? =5
}

# Invoke your function
Hello $1 $2

# Capture value returned by last command
ret=$?

echo "Return value is $ret"

===============================================
Nested Functions: 

Nested functions are functions that can call themselves and also other functions. 

1. One function calling antoher function
2. Recursive function: A fxn that calls itself 

Following examples are used to demonstrate 2 nested functions

example 1
#!/bin/bash

# calling one function from another
number_one () {
	echo "This is the first function speaking..."
	number_two
}

number_two () {
	echo "This is the second function speaking..."
}

# Calling function one
number_one

==== ===== === == === == == == == ==
example 2

#!/bin/bash

# Recursive function: function that calls itself
number_one () {
        echo "This is recursive function calling itself..."
        number_one
}
number_one

# enters "Segmented fault" after a few runs as decided by the system
================================================================
Switch Case:

Used to compress code to reduce writing many lines

syntax
case "VAR" in 
	Result1){
		process1
	};;
	Result2){
		process2
	};;
	Result3){
	process3
	}
esac

# switch case
CARS="$1"
#CARS1="2"

# Pass the variable in string

#!/bin/bash
#building a test switch case function: use 

#Enable case-insensitivity matching
shopt -s nocasematch

Days_of_week="$1"

case $Days_of_week in 
	#case 1
	"Mon") echo "first workday of the week" ;;
	"Tues") echo "Second workday of the week" ;;
	"Wed") echo "Third workday of the week" ;;
	"Thurs") echo "Fourth workday of the week" ;;
	"Fri") echo "5th and Last workday of the week" ;;
	"Sat") echo "first weekend day of the week" ;;
	"Sun")echo "second weekend day of the week, meant for resting" ;;
esac
==========================================================

#!/bin/bash
echo "testing crontasks"

=================================
end
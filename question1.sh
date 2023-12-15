#!/bin/bash

# Check if there is exactly one command line argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <positive_integer>"
    exit 1
fi

# Check if the command line argument is a positive integer
if ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Please provide a positive integer."
    exit 1
fi

number=$1

# Function to calculate the sum of digits
get_digit_sum() {
    local n=$1
    local sum=0
    while [ "$n" -gt 0 ]; do
        sum=$((sum + n % 10))
        n=$((n / 10))
    done
    echo "$sum"
}

# Function to calculate the product of digits
get_digit_product() {
    local n=$1
    local product=1
    while [ "$n" -gt 0 ]; do
        product=$((product * (n % 10)))
        n=$((n / 10))
    done
    echo "$product"
}

# Function to check if a number is palindrome
is_palindrome() {
    local reverse=$(echo "$1" | rev)
    [ "$1" == "$reverse" ]
}

# Function to check if a number is prime
is_prime() {
    local num=$1
    if [ "$num" -lt 2 ]; then
        return 1
    fi
    for ((i = 2; i <= num / 2; i++)); do
        if [ "$((num % i))" -eq 0 ]; then
            return 1
        fi
    done
    return 0
}

# Main logic based on user choice
echo "Choose an option:"
echo "1. Display the sum and the product of the digits of the number"
echo "2. Display whether the number is a palindrome or not"
echo "3. Display whether the number is prime or not"

read -p "Enter your choice (1/2/3): " choice

case $choice in
    1)
        sum=$(get_digit_sum "$number")
        product=$(get_digit_product "$number")
        echo "Sum of digits: $sum"
        echo "Product of digits: $product"
        ;;
    2)
        if is_palindrome "$number"; then
            echo "$number is a palindrome."
        else
            echo "$number is not a palindrome."
        fi
        ;;
    3)
        if is_prime "$number"; then
            echo "$number is a prime number."
        else
            echo "$number is not a prime number."
        fi
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac

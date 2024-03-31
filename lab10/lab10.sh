#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

printf "${GREEN}1. Starts or ends with Jose${NC}\n"
grep -E "(^Jose|Jose$)" phonebook.dat

printf "${GREEN}2. Start with at least 27 upper-case or lower-case characters [a-z]${NC}\n"
grep -E "[A-Za-z]{27}" phonebook.dat

printf "${GREEN}3. Contains more 18 characters${NC}\n"
grep -E ".{19,}" phonebook.dat

printf "${GREEN}5. Contains exactly 10 characters${NC}\n"
grep -E "^.{10}$" phonebook.dat

printf "&{GREEN}6. Contains a sequence of 6 or 8 characters${NC}\n"
grep -E '(^|[\t ])[a-zA-Z]{6,8}([\t ]|$)' phonebook.dat

printf "${GREEN}7. Contains a local phone number${NC}\n"
grep -E '^[0-9]{3}-[0-9]{4}$' phonebook.dat

printf "${GREEN}8. Contains a valid URL on a line by itself.${NC}\n"
grep -E '^http[s]?://[a-zA-Z0-9./-]*$' phonebook.dat

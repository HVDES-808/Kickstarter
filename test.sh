filename="test.txt"
sed -i.bak -e '/^[[:blank:]]*#/d' -e 's/[[:blank:]]*#.*$//' "$filename"

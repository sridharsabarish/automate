#!/bin/bash


## 

checkout_downloads()
{
    cd ~/Downloads
}


find_different_extensions_using_awk_and_clean()
{
echo "Finding different extensions in Downloads folder"
out=($(find *.* | awk -F "." '{print $NF}' | sort | uniq)) 

for i in "${out[@]}"
do
   :

  echo Arranging $i
  cleanup_logic $i
done

}


cleanup_logic()

{
mkdir -p  $1
echo "Creating the directory $1"
mv *.$1 $1/
echo " Moved the extension to the folder $1"

}


main()
{
    checkout_downloads
    find_different_extensions_using_awk_and_clean
}

main

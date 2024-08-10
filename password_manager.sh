#!/bin/bash

list="passwordlist.txt"
encodelist="${list}.gpg"

while true
do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)"
    read choices

    case $choices in
            "Add Password")
                echo "サービス名を入力してください："
                read service

                echo "ユーザー名を入力してください："
                read username

                echo "パスワードを入力してください："
                read password

                echo "$service:$username:$password" >> "$list"
                gpg --batch --yes -c "$list"
                rm -f "$list"
                echo "パスワードの追加は成功しました。" 
                
                ;;

            "Get Password")

                read -p "サービス名を入力してください:" service 
            
                newlist=$(gpg --batch --yes -d "$encodelist" | grep "$service")

                if [ -n "$newlist" ]; then
                IFS=":" read service username password <<< "$newlist" 
                
                    echo "サービス名："$service
                    echo "ユーザー名："$username
                    echo "パスワード："$password

                else
                    echo "そのサービスは登録されていません。"
                fi
                ;;

            "Exit")
                echo "Thank you!"
                break 
		        ;;
            
            *)
                echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。" 
                ;;
    esac
done

#!/bin/bash

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

                echo " $service:$username:$password " >> passwordlist.txt
                echo "パスワードの追加は成功しました。" 
		;;

            "Get Password")
                echo "サービス名を入力してください:"
                read service 
                
                if ! grep -q "$service" passwordlist.txt;then
                    echo "そのサービス登録されていません。"
                else
                    echo "サービス名: $service"
		    echo "ユーザー名: $username"
		    echo "パスワード: $password"
                fi
                ;;

            "Exit")
                echo "Thank you!"
                break 
		;;
            
            *)
                echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。" ;;
    esac
done

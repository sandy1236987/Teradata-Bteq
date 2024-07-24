#!/bin/bash

# 定義查詢的參數
query_td () {
bteq << EOBTQ | grep '^>' | sed -e "s/^>//"
.LOGON dsn/user_id,password;
DATABASE your_database;
SELECT '>' || COALESCE(sales_amount, 0) FROM sales ;
.LOGOFF;
.QUIT;
EOBTQ
}

var=$(query_td)
# 去掉結果中空白的字串
var=$(echo $var | xargs)

echo "查詢结果: '$var'"

# 檢查查詢結果是否為 0
if [ "$var" == 0 ]; then
    echo "查詢結果是 0"
    exit 99
elif [ "$var" == NULL ]; then
    echo "查詢結果是 NULL"
    exit 99
else
    echo "查詢結果不是 0 或 NULL，結果為: $var"
fi
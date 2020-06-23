echo please enter the project name
read project

mkdir $project

cd $project
mkdir -p public public/js public/css public/images views routes models config
npm init -y

echo "Do you want install mysql (y/n)"
read yorn

if  [ "$yorn" == "y" ]
then
    npm i express body-parser ejs dotenv mysql
    echo "const mysql = require('mysql')
    const mysqlCon=mysql.createConnection({
    host     : 'localhost',
    user     : 'user',
    password : 'password',
    database : 'database'
    })
    mysqlCon.connect();
    module.exports=mysqlCon
    " > config/db.js
else
    npm i express body-parser ejs dotenv
fi

touch server.js

touch views/index.ejs

echo "PORT=3000" > .env

echo "const express = require('express')
require('dotenv').config()
const app = express()
const bodyParser = require('body-parser')
app.use(bodyParser.json())
const PORT = process.env.PORT|3000
app.use(bodyParser.urlencoded({extended: false}))
app.set('view engine','ejs')
app.set('views','./views')
app.get('/',(req,res)=>{
    res.render('index.ejs')
})
app.listen(PORT,()=>{
    console.log('Server is running port '+PORT)
})" > server.js

echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Hello World</h1>
</body>
</html>" > views/index.ejs

echo "node_modules/
package-lock.json
.gitignore
.env
" > .gitignore

echo "NodeJS MVC Project is completed do you want to install frontend (y/n)"

read yorn2

if  [ "$yorn2" == "y" ]
then
    echo "Which Framework do you want to use:"
    echo "1.React"
    echo "2.Angular"
    echo "3.Vue"
    echo "4.Svelte"
    read framework
    echo "Please enter the project name"
    read project
    if  [ "$framework" == "4" ]
    then
        npx degit sveltejs/template $project
    elif [ "$framework" == "3" ]
    then
        vue create $project
        if [ $? -gt 0 ]
        then
            echo "Please install the Vue CLI"
            exit
        fi
    elif [ "$framework" == "1" ]
    then
        npx create-react-app $project
    elif [ "$framework" == "2" ]
    then
        ng new $project
        if [ $? -gt 0 ]
        then
            echo "Please install the Angular CLI"
            exit
        fi
    fi
fi

node server.js | open http://localhost:3000
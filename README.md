# Scripts on Rails
SoR is made for people, who write scripts and want to give users the possibility to run it easily on a server. For example it is usefull if you work with people, who has no IT-knowledge and they had to do everyday-annoying-work. So you can write some scripts and upload it to SoR and the people can execute them (with parameters) and are happy ;)

SoR supports now **git**. So you can write your files offline and push it to your git-server. After this SoR can pull it from there. 

# Basic Setup

1. Install git, ruby and rails on the server

2. Setup SoR: 

```bash
git clone git@github.com:azapps/scripts_on_rails.git 
bundle # Install needed gems
bundle exec rake db:migrate # Migrate the database
```

# Demo Application

Here you can test it:

* http://sor.azapps.de
* User: test@example.com
* Password: test1234

(Please do not change the password)



# License

(MIT License)

Copyright (c) 2013 Anatolij Zelenin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


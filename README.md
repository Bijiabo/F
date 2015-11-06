#README

## install packages

```
$ sudo apt-get update
$ sudo apt-get install imagemagick --fix-missing
```

## applicaiton.yml

config/applcaition.yml
```
# 系统信息
System_version: 0.0.2
Secret_key: your key # must same as application client value

# 基础设置
Base_title: yourdomain.com
Logo_text: your site name

# 图片尺寸设置
image_maxium_width: 400
image_maxium_height: 400

# 邮件服务器设置
# 邮件服务器地址
SENDGRID_ADDRESS: smtp.domain.com
# 邮件服务器端口
SENDGRID_PORT: '25'
# Domain
SENDGRID_DOMAIN: domain.com
# 邮件服务器用户名
SENDGRID_USERNAME: account@yourdomain.com
# 邮件服务器密码
SENDGRID_PASSWORD: your password
# 发送邮件的账户地址
SENDGRID_FORM: account@yourdomain.com
```

# Open Hunt


## Setting up Twitter App

1) Create a dev app with your twitter account: https://apps.twitter.com/app/new

  * set the name to something unique (something like "Open Hunt dev - [your github username]")

  * set description / website to anything

  * set the callback url to http://127.0.0.1:3000/auth/twitter/callback

  * example: ![](http://cl.ly/1O002o2X3v0L/content)


2) Change the permissions to "Read Only"

  * in "Application Settings -> Access Level", click "modify app permissions"

    ![](http://cl.ly/2I0D0e1R0c0d/content)

  * http://cl.ly/1o2J203N3l3M

3) Click on the tab "Keys and Access Tokens". Then create a new file at `config/settings.local.yml` with the content:

```
# pull the value for "Consumer Key (API Key)"
twitter_key: "PASTE_REAL_KEY_HERE"

# pull the value for "Consumer Secret (API Secret)"
twitter_secret: "PASTE_REAL_SECRET_HERE"
```



## License

Open Hunt is released under the MIT License.

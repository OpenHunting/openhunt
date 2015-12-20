# Open Hunt

Open Hunt is a brand new community for fans and builders of early stage technology products. We aim to be completely open and transparent, without insiders or gatekeepers who control who gets listed and who gets left out.

## Development

Firstly, fork the repo on the master branch and clone your repo

`git clone https://github.com/<your username>/openhunt`

Install the required gems with bundler

`bundle install`

Create a new branch for your feature

`git checkout -b feature/your-feature`

Run the application using

`rails server`

When you have finished your feature and added your tests, [submit a pull request](https://github.com/OpenHunting/openhunt/compare) using your feature branch.


## Setting up Twitter App

1) Create a dev app with your twitter account: https://apps.twitter.com/app/new

  * set the name to something unique (something like "Open Hunt dev - [your github username]")

  * set description / website to anything

  * set the callback url to http://goo.gl/QVYCy (a shortlink that points to http://localhost:3000/auth/twitter/callback)

  * example: ![](http://cl.ly/3W3P0u0j3q1A/content)


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

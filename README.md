# Open Hunt

Open Hunt is a brand new community for fans and builders of early stage technology products. We aim to be completely open and transparent, without insiders or gatekeepers who control who gets listed and who gets left out.

## Development

Firstly, fork the repo on the master branch and clone your repo

`git clone https://github.com/<your username>/openhunt`

Install the required gems with bundler

`bundle install`

Create a new branch for your feature

`git checkout -b feature/your-feature`

[Register](https://apps.twitter.com/) an application with Twitter and add the keys to config/settings.local.yml (create if necessary)

```
twitter_key: "CONSUMER_KEY"
twitter_secret: "CONSUMER_SECRET"
```

Run the application using

`rails server`

When you have finished your feature and added your tests, [submit a pull request](https://github.com/OpenHunting/openhunt/compare) using your feature branch.

## License

Open Hunt is released under the MIT License.

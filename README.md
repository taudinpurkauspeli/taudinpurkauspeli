# Taudinpurkauspeli

## Sovelluksen asentaminen Herokuun

Sovellus asentuu sulavasti Herokuun luomalla uusi Heroku-app Git-repositorion juuressa.

Sovellus käyttää kuvien säilömiseen AWS S3 -palvelua, jota varten käyttäjällä tulee olla valmiina AWS-tili ja S3 bucket s3-eu-central-1 -palvelimella. Mikäli kuvien hostaamiseen käytetään jotakin muuta palvelinta, tämän voi muuttaa paperclip.rb-tiedostossa.

Paperclip tarvitsee käyttäjän AWS-tiedot, jotka haetaan sovelluksen käyttöön Herokun config-muuttujista. Ne asetetaan seuraavasti:

```
heroku config:set S3_BUCKET_NAME=foo AWS_ACCESS_KEY_ID=bar AWS_SECRET_ACCESS_KEY=baz AWS_REGION=qux
```

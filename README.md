# Taudinpurkauspeli

Taudinpurkauspeli on eläinlääketieteen opiskelijoille tarkoitettu web-sovellus, jolla luodaan pelinomainen oppimisympäristö opiskelijoiden käyttöön. Pelissä ratkotaan erilaisia tautitapauksia ja pyritään määrittämään niiden diagnoosi pelaamisen aikana kerättävien lisätietojen avulla.

Opetusmateriaalin avulla opiskelijat voivat ratkaista aitoja ammatillisia ongelmia, joita he eivät Suomen hyvän eläintautitilanteen vuoksi pääse käytännössä harjoittelemaan, mutta joiden vastustamiseksi heillä täytyy olla valmiuksia.

## Sovelluksen asentaminen Herokuun

Sovellus asentuu sulavasti [Herokuun](http://www.heroku.com) luomalla uusi Heroku-app Git-repositorion juuressa.

Sovellus käyttää kuvien säilömiseen [AWS S3](http://aws.amazon.com) -palvelua, jota varten käyttäjällä tulee olla valmiina AWS-tili ja S3 bucket s3-eu-central-1 -palvelimella. Mikäli kuvien hostaamiseen käytetään jotakin muuta palvelinta, tämän voi muuttaa paperclip.rb-tiedostossa.

Paperclip tarvitsee käyttäjän AWS-tiedot, jotka haetaan sovelluksen käyttöön Herokun config-muuttujista. Ne asetetaan seuraavasti:

```
heroku config:set S3_BUCKET_NAME=foo AWS_ACCESS_KEY_ID=bar AWS_SECRET_ACCESS_KEY=baz AWS_REGION=qux
```

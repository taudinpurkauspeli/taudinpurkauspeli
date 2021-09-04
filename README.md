# Taudinpurkauspeli

Taudinpurkauspeli on eläinlääketieteen opiskelijoille tarkoitettu web-sovellus, jolla luodaan pelinomainen oppimisympäristö opiskelijoiden käyttöön. Pelissä ratkotaan erilaisia tautitapauksia ja pyritään määrittämään niiden diagnoosi pelaamisen aikana kerättävien lisätietojen avulla.

Pelin avulla opiskelijat voivat ratkaista aitoja ammatillisia ongelmia, joita he eivät Suomen hyvän eläintautitilanteen vuoksi pääse käytännössä harjoittelemaan, mutta joiden vastustamiseksi heillä täytyy olla valmiuksia.

# Esivaatimukset

Kehitysympäristön asennusohjeet on tehty `Ubuntu 20.04 LTS`:lle

Sinulla tulee olla asennettuna seuraavat:
- NVM (Node version manager)
  - Node version manager saattaa helpottaa Node.js:n asentamisessa
  - [https://github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)
- Node.js versio `v14.17.6`
  - Node.js kannattaa asentaa NVM:n avulla, sillä silloin version vaihtaminen on helpompaa
  - `$ nvm install --lts` asentaa viimeisimmän lts-version 
  - `$ nvm install 14.17.6` asentaa tietyn version
- RVM (Ruby version manager)
  - Ruby kannattaa asentaa NVM:n avulla, sillä silloin version vaihtaminen on helpompaa
  - [https://rvm.io/](https://rvm.io/)
- Ruby versio `2.5.1`
  - Ruby kannattaa asentaa RVM:n avulla 
  - `$ rvm install "ruby-2.5.1"`
  - Uudempikin versio saattaa toimia, mutta sitä ei ole testattu
- Kirjasto `libpq-dev`
  - `$ sudo apt-get install libpq-dev`


# Kehitysympäristön asentaminen

1. Asentaaksesi Ruby on Rails -projektin (backend) riippuvuudet, suorita seuraava komento: 

   ```
   $ bundle install
   ```

2. AngularJS-projektin (frontend) riippuvuuksia ei tarvitse asentaa, sillä `vendor`-kansio sisältää vanhat riippuvuudet.

3. Jos haluat asentaa Bower:lla riippuvuuksia tulee sinun asentaa Bower ja ajaa seuraavat komennot:
   ```
   # Asennetaan bower-paketti
   $ npm install bower -g
   
   # Asennetaan projektin riippuvuudet 
   # HUOM! Jos olet kloonannut repositorion ja et ole tehnyt muutoksia Bowerfile-tiedostoon, tämä komento ei tee mitään
   $ bundle exec rake bower:install
   ```

4. Tämän jälkeen voit suorittaa tietokantamigraatiot
   ```
   $ bundle exec rake db:migrate
   ```

   Jos haluat alustaa tietokannan lokaalisti uudestaan ja tyhjentää kaiken datan voit käyttää komentoja:
   ```
   # Kannan poistaminen
   $ bundle exec rake db:drop
   
   # Kannan luominen
   $ bundle exec rake db:create
   
   # Kannan alustus migraatioilla
   $ bundle exec rake db:migrate
   ```
   
   Voit myös alustaa kantaan esimerkkidataa komennolla:
   ```
   $ bundle exec rake db:seed
   ```
   Tämä komento alustaa kannan tiedostosta `db/seeds.rb` löytyvällä datalla.

# Oman käyttäjän luominen ja tietokantaan yhdistäminen Rails konsolissa

Voit käynnistää Rails konsolin komennolla:

```
$ bundle exec rails c
```

Konsolin kautta voit tehdä kyselyjä kehitysympäristön tietokantaan. 

Voit luoda paikallisen käyttäjätunnuksen itsellesi seuraavilla komennoilla. 
Korvaa `<my_own_password>` kohdat haluamallasi salasanalla. Voit muuttaa myös muiden kenttien arvoja haluamallasi tavalla.

```
# Opettajatunnus
User.create(username: "omaOpettajaTunnus", email: "omaOpettajaTunnus@tunnus.tunnus", password: "<my_own_password>", password_confirmation: "<my_own_password>", student_number: "111111111", starting_year: 2018, admin: true, first_name: "OmaOpettaja", last_name: "Opettajatunnus")

# Opiskelijatunnus
User.create(username: "omaOpiskelijatunnus", email: "omaOpiskelijatunnus@tunnus.tunnus", password: "<my_own_password>", password_confirmation: "<my_own_password>", student_number: "222222222", starting_year: 2018, admin: false, first_name: "OmaOpiskelija", last_name: "Opiskelijatunnus")
```

Lisää ohjeita tietokannan tietojen tarkastelusta konsolin kautta löydät [Active Record Query Interface -ohjeesta](https://guides.rubyonrails.org/active_record_querying.html).
   
# Kehitysympäristön käynnistäminen 

1. Käynnistääksesi kehitysympäristön suorita seuraava komento: 
   ```
   $ bundle exec rails s
   ```

2. Voit nyt navigoida selaimella osoitteeseen
   ```
   http://localhost:3000
   ```
   ja kirjautua sisään sovellukseen sopivalla tunnuksella.




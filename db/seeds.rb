Exercise.create!([
  {name: "Taudinpurkaus lihanautakasvattamossa", anamnesis: "Ison lihakarjatilan emäntä soittaa sinulle iltapäivällä 11. elokuuta, koska tilan eläinkuolleisuus on noussut. Tilalla on noin 300 nautaa jaettuna useampaan kasvattamorakennukseen. Keskimääräinen kuolleisuus tilalla on ollut korkeintaan 1 nauta/kuukausi. Tänä aamuna, 11. elokuuta oli kuollut kuitenkin 12 nautaa, ja aamupäivän aikana ennen sinulle soittamista on kuollut 15 nautaa lisää. \r\n\r\nSinun tehtävänäsi on selvittää nautojen kuolinsyy mahdollisimman nopeasti ja estää toimenpiteilläsi uudet kuolintapaukset ja muut tappiot tilalla. Mitä teet ja missä järjestyksessä?"}
])
ExerciseHypothesis.create!([
  {exercise_id: 1, hypothesis_id: 5, explanation: "BSE:n tapauksessa kuolemat ovat yksittäistapauksia, toisin kun nyt. Eläinten käytöksessä ei ole ilmennyt pidemmällä aikavälillä mitään poikkeavaa (epänormaalia kiihtymystä tai poikkeavaa reagoimista ärsykkeisiin) ennen niiden kuolemaa.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 13, explanation: "Laidunkouristus on tyypillinen alkukesästä, kun naudat saavat nuorta, tuoretta ruohoa. Sairautta esiintyy eniten lypsylehmillä, joskin se on mahdollista myös lihakarjalla. Niukka magnesiumpitoisuus ja väärä Ca/Mg -suhde altistavat. Tässä tapauksessa kivennäisruokinta on kuitenkin kunnossa. Lisäksi päivystävän eläinlääkärin antama magnesium ei ollut auttanut yhtään.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 16, explanation: "Liika väkirehun syöminen ei yleensä koske näin isoa joukkoa eläimiä, vaan yleensä joitakin yksilöitä, jotka ovat päässeet karkaamaan väkirehuvarastoon tai viljapeltoon ja se tulisi yleensä esiin jo puhelussa. Jos väkirehun syöttölaitteisto on rikkoontunut, omistaja olisi myös yleensä huomannut sen. Lisäksi liian väkirehun syömisen oireet ovat erilaiset: ensimmäisenä päivänä ylensyömisen jälkeen lehmä on syömätön (saattaa puhaltua), toisena jalaton ja kolmantena hengetön - siis ilman hoitoa.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 18, explanation: "Sähköisku tappaa heti. Näillä naudoilla oli edeltäviä oireita. Rakenteisiin päässyttä sähköä voisi mitata jännitemittareilla, mutta nyt ei ole edes siihen syytä.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 1, explanation: "Aujeszkyntauti on herpesviruksiin kuuluvan pseudorabiesviruksen aiheuttama virustauti, jota ei ole tavattu Suomessa. Se on ensisijaisesti sikojen tauti ja muilla eläimillä harvinainen, mutta johtaa kuolemaan. Naudalla oireisiin kuuluvat ihon kutina (ulserat ja sekundaariset infektiot raapimisen seurauksena), paralyysi ja suhteellisen nopea kuolema. Näillä naudoilla ei ollut kutinaoireita eikä paralyysiä, eikä kontakteja ulkomaisiin sikoihin.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 6, explanation: "Kinokuumeessa voi olla akuutti taudinkulku, mutta yleensä kuolema ei ole yhtä akuutti kuin tässä tapauksessa. Tapauksen eläimillä ei ole kuumetta, turvotusta silmien alueella, valonarkuutta ja ennen kaikkea niillä ei ole ollut läheistä kontaktia lampaiden kanssa. Kinokuume ei tartu naudasta toiseen, vaan ainoastaan lampaasta nautaan. Tartunnat ovat yleensä yksittäistapauksia.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 11, explanation: "eläimillä ei havaittu syviä haavoja, joiden kautta tartunta olisi voinut tapahtua. Eläimiä ei ole kastroitu tai niille ei ole tehty muita kirurgisia toimenpiteitä. Eivätkä oireetkaan sovi tetanukseen. - Tetanuksen inkubaatioaika on 2-3 päivästä useampaan viikkoon. Lihansyöjät (koira) eivät ole herkkiä tetanukselle. Myöskään oireet eivät sovi jäykkäkouristukseen, jossa oireet puhkeavat 2 viikon -1 kuukauden kuluttua inokulaatiosta: puhaltuminen  (tyypilliset ratisevat pötsiäänet, kuin herneitä tiputeltaisiin, tai kaikuvia ääniä), jäykkyys, sahapukkiasento ja vatsalihasten jännittyminen (ampiaisvyötärö). Häntä on jäykkä ja vähän koholla, ilme hätääntynyt, korvat sojottavat, kolmas silmäluomi on esillä (ei aina naudalla), syljeneritys on lisääntynyt ja eläin on ärtyvä. Sairastunut eläin vetää helposti ruokaa henkitorveen. Leukalukko on patognomoninen oire, joka havaitaan usein vasta, kun sairasta ja syömätöntä eläintä ruvetaan letkuttamaan. Tetanus on tässä luokiteltu infektiotaudiksi, koska vaikka bakteeri on saatu maaperästä jonkun ympäristössä olleen pistävän asian takia, bakteeri lisääntyy haavassa tuottaen toksiinia. Ihmisillä tetanus on aiheutunut mm. koiran puremasta tai ruusunpiikin pistosta, joten aina haavan ei tarvitse olla syväkään.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 23, explanation: "Botulismin aiheuttaa ruokamyrkytystä aiheuttava Clostridium botulinum -bakteeri. Eläin saa taudin syötyään valmista myrkkyä. Bakteeri kasvaa neutraalissa tai alkaalisessa ympäristössä. Sairastumisen aiheuttaa yleensä saastunut rehu, eläinten raadot tai mätänevä kasvusto. Jättipaalit ovat selkeä riski, varsinkin jos rehu on puitu läheltä maanpintaa eikä happoa ole käytetty. Taudin inkubaatioaika on vuorokaudesta viikkoon. Oireena on heikkous, kraniaalisesti etenevä horjuvaa kävely, lisääntynyt syljeneritys, puremalihasten ja kielen halvaus sekä puhaltuminen. Myrkytys ei yleensä koskisi näin suurta joukkoa. Diagnoosi tehdään anamneesin ja kliinisten oireiden perusteella. Raadonavauksessa pitäisi näkyä patognomonisia muutoksia. Hoito olisi oireiden mukaista, mutta käytännössä todennäköisesti botulismia sairastava nauta olisi lopetettava heti. On kuvattu tapauksia, jotka olisivat hyvällä yleishoidolla saatu paranemaan. Ruho ei kelpaa elintarvikkeeksi. - Tämän tilan rehu oli lisäksi hyvälaatuista. Jos oikeasti epäilisi botulismia, verinäyte, mahansisältöä ja epäiltyä rehua pitäisi pakastaa ja toimittaa Eviraan, joka toimittaa ne edelleen ulkomaille tutkittavaksi.", task_id: nil},
  {exercise_id: 1, hypothesis_id: 21, explanation: "Osastoissaan lehmät eivät ole päässeet nuolemaan akkuja, pattereita, lyijymaalipintoja tai moottoriöljyjä, joista ne voisivat nuolemalla saada lyijyä. Lisäksi niillä ei ole seuraavia lyijymyrkytyksen oireita: lihasväristykset, hikoilu,, hampaiden kirskutus, jäykkä leuka, hoipertelu, sokeus, laajentunut pupilla, työntyminen aitaa vasten, mania ja  kollapsi. Letaaliannos on nuorilla 200-400 mg/kg ja aikuisilla 600-800 mg/kg ja lyijystä imeytyy noin 2 %, ja loppu tulee ulosteen mukana pois. Lyijymyrkytys voisi tuskin koskaan aiheuttaa näin suurta kuolleisuutta isolla joukolla nautoja, vaan pikemminkin joillakin uteliailla yksilöillä ja enemmän epämääräisissä laidunolosuhteissa.", task_id: nil}
])
Hypothesis.create!([
  {name: "Aujeszkyn tauti", count: nil, hypothesis_group_id: 1},
  {name: "B-vitamiinin puutos", count: nil, hypothesis_group_id: 3},
  {name: "BSE", count: nil, hypothesis_group_id: 1},
  {name: "BVD (naudan virusripuli)", count: nil, hypothesis_group_id: 1},
  {name: "Botulismi-rehumyrkytys", count: nil, hypothesis_group_id: 5},
  {name: "Enteriitti", count: nil, hypothesis_group_id: 2},
  {name: "Hypertermia", count: nil, hypothesis_group_id: 4},
  {name: "IBR (naudan tarttuva rinotrakeiitti)", count: nil, hypothesis_group_id: 1},
  {name: "Kinokuume", count: nil, hypothesis_group_id: 1},
  {name: "Laidunkouristus (hypomagnesemia)", count: nil, hypothesis_group_id: 3},
  {name: "Lantakaasumyrkytys", count: nil, hypothesis_group_id: 5},
  {name: "Liika väkirehu", count: nil, hypothesis_group_id: 3},
  {name: "Lyijymyrkytys", count: nil, hypothesis_group_id: 5},
  {name: "Muu rehumyrkytys", count: nil, hypothesis_group_id: 5},
  {name: "Muu tarttuva tauti", count: nil, hypothesis_group_id: 2},
  {name: "Pernarutto", count: nil, hypothesis_group_id: 1},
  {name: "Pilaantunut rehu", count: nil, hypothesis_group_id: 3},
  {name: "Pneumonia", count: nil, hypothesis_group_id: 2},
  {name: "Poikimahalvaus (hypokalsemia)", count: nil, hypothesis_group_id: 3},
  {name: "Salamanisku tai muu odottamaton luonnonilmiö", count: nil, hypothesis_group_id: 6},
  {name: "Sinilevämyrkytys", count: nil, hypothesis_group_id: 5},
  {name: "Suu- ja sorkkatauti", count: nil, hypothesis_group_id: 1},
  {name: "Sähkölaitehäiriö (sähkö virtaa putkirakenteisiin) ja siitä johtuvat sähköiskut", count: nil, hypothesis_group_id: 4},
  {name: "Tetanus", count: nil, hypothesis_group_id: 2},
  {name: "Vierasesine rehussa", count: nil, hypothesis_group_id: 6}
])
HypothesisGroup.create!([
  {name: "Infektiivinen tauti - vastustettava"},
  {name: "Infektiivinen tauti – muu kuin vastustettava"},
  {name: "Myrkytys"},
  {name: "Olosuhdeongelma"},
  {name: "Onnettomuus"},
  {name: "Ruokintahäiriö"}
])
Multichoice.create!([
  {question: "Tapausmääritelmä", subtask_id: 2}
])
Option.create!([
  {multichoice_id: 1, content: "Tapaus on äkillisesti kuollut eläin", explanation: "Oikein. Tässä tapauksessa kannattaa lukea tähän kaikki kuolleet. Tapausmääritelmään luetellaan kaikki ne oireet, jotka oleellisia ja sitä voi tarkentaa vielä laboratoriotutkimusten jälkeen, mutta tässä pelissä näin ei tehdä. ", value: true},
  {multichoice_id: 1, content: "Tapaus on tiettyjen oireiden jälkeen akuutisti kuollut eläin", explanation: "Oikein. Tässä tapauksessa kannattaa lukea tähän kuitenkin kaikki kuolleet. Tapausmääritelmään luetellaan kaikki ne oireet, jotka oleellisia ja sitä voi tarkentaa vielä laboratoriotutkimusten jälkeen, mutta tässä pelissä näin ei tehdä.", value: true},
  {multichoice_id: 1, content: "Tapaus on tiettyjen pitkittyneiden oireiden jälkeen kuollut eläin", explanation: "väärin", value: false},
  {multichoice_id: 1, content: "Tapaus on tietyillä oireilla sairastunut eläin", explanation: "vääärin", value: false},
  {multichoice_id: 1, content: "Tapaus on tietyillä oireilla sairastunut, mutta itsestään toipunut eläin ", explanation: "väärin", value: false},
  {multichoice_id: 1, content: "Tapaus on tietyillä oireilla sairastunut hoidolla toipunut eläin", explanation: "väärin", value: false},
  {multichoice_id: 1, content: "Ei mikään edellisistä", explanation: "väärin", value: false}
])
Subtask.create!([
  {task_id: 2, task_text_id: nil},
  {task_id: 14, task_text_id: nil},
  {task_id: 3, task_text_id: nil}
])
Task.create!([
  {name: "Epidemia vai ei", exercise_id: 1, level: 1},
  {name: "Lisätietoa puhelimessa", exercise_id: 1, level: 2},
  {name: "Yhteydenotto läänineläinlääkäriin", exercise_id: 1, level: 4},
  {name: "Lisätietoa kysymyksillä   kliinisen tutkimuksen yhteydessä ", exercise_id: 1, level: 5},
  {name: "Kliininen tutkimus", exercise_id: 1, level: 6},
  {name: "Tapausten kartoitus", exercise_id: 1, level: 7},
  {name: "Kenttäobduktio", exercise_id: 1, level: 8},
  {name: "Ehkäisevät ensitoimet", exercise_id: 1, level: 9},
  {name: "Hoito", exercise_id: 1, level: 10},
  {name: "Näytteenotto tutkimuksiin", exercise_id: 1, level: 11},
  {name: "Jatkoselvitys", exercise_id: 1, level: 12},
  {name: "Mikä on diagnoosisi", exercise_id: 1, level: 13},
  {name: "Jatkotoimet", exercise_id: 1, level: 14},
  {name: "Tapausmääritelmä", exercise_id: 1, level: 3}
])
TaskText.create!([
  {content: " Omistaja kertoo vielä puhelimessa, että eilen (10. elokuuta) illalla useilla eläimillä eri osastoissa oli seuraavia oireita: supistuneet pupillat, voimistunut syljeneritys, kyynelvuoto, lisääntynyt virtsaaminen, koliikki, horjuva kävely ja kouristukset. Ensimmäiset kuolleet todettiin 11. elokuuta. Päivystävä eläinlääkäri kävi silloin hoitamassa oireilevia. Hän oli epäillyt hypomagnesemiaa ja B-vitamiinin puutosta sekä antanut näiden mukaisen hoidon (Parevet-liuosta ja Sedamania koon mukaan annostellen, B-vitamiinia). Oireilleiden määrää omistaja ei puhelimessa muistanut, mutta lääkityksellä ei kuitenkaan ollut vaikutusta eläimiin, koska nyt niitä on kuollut.", subtask_id: 1},
  {content: "Kaikista taudinpurkaustapauksista ei automaattisesti ilmoiteta läänineläinlääkärille, mutta koska tässä tapauksessa on näin korkea kuolleisuus, kannattaa asiasta neuvotella läänineläinlääkärin kanssa", subtask_id: 3}
])
User.create!([
  {username: "Opettaja", admin: true, email: "olli@opettaja.fi", realname: "Olli Opettaja", password_digest: "$2a$10$pZqHqBmkdODnYefBwBQ7euDHObifSp10sQ3Df0VLwZFFtr7XILBiG"},
  {username: "Oppilas", admin: false, email: "olli@oppilas.fi", realname: "Olli Oppilas", password_digest: "$2a$10$DjqwIIdns5oigOieda.KN.vln/csSJp/H0W/8ExNofYrAJ4W7jIR6"},
  {username: "Opiskelija", admin: false, email: "ellu@eläin.fi", realname: "Ellu Eläinlääkeopiskelija", password_digest: "$2a$10$O6S6LohLxPYcT3vTUkA7pOvrrI15VyDux9zhL7h2YxEcjQO.tslEC"}
])

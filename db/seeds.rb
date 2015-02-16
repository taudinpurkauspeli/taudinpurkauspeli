Exercise.create!([
  {name: "Lihanautakuolemat", anamnesis: "Nautoja on kuollut"}
])
ExerciseHypothesis.create!([
  {exercise_id: 2, hypothesis_id: 6, explanation: "Sorkka on infektoitunut."},
  {exercise_id: 2, hypothesis_id: 8, explanation: "Sarvi on vinoutunut."},
  {exercise_id: 2, hypothesis_id: 15, explanation: "Salama osui nautaan."},
  {exercise_id: 1, hypothesis_id: 14, explanation: "puheripuli"},
  {exercise_id: 1, hypothesis_id: 3, explanation: nil},
  {exercise_id: 1, hypothesis_id: 4, explanation: nil},
  {exercise_id: 1, hypothesis_id: 2, explanation: nil}
])
Hypothesis.create!([
  {name: "Koira", count: nil, hypothesis_group_id: nil},
  {name: "Suu- ja sorkkatauti", count: nil, hypothesis_group_id: 3},
  {name: "Liikautare", count: nil, hypothesis_group_id: 3},
  {name: "Vino sarvi", count: nil, hypothesis_group_id: 3},
  {name: "Häntä solmussa", count: nil, hypothesis_group_id: 4},
  {name: "Ylikostea kuono", count: nil, hypothesis_group_id: 4},
  {name: "Huono kuulo", count: nil, hypothesis_group_id: 4},
  {name: "Rasvapatti rasvaevässä", count: nil, hypothesis_group_id: nil},
  {name: "Irronnut rasvaevä", count: nil, hypothesis_group_id: 5},
  {name: "Uimarakko peukalossa", count: nil, hypothesis_group_id: 5},
  {name: "Salamanisku", count: nil, hypothesis_group_id: 6},
  {name: "Silmänisku", count: nil, hypothesis_group_id: 6},
  {name: "Koiran raivotauti", count: nil, hypothesis_group_id: 2},
  {name: "blaablaa", count: nil, hypothesis_group_id: 1}
])
HypothesisGroup.create!([
  {name: "Nautataudit"},
  {name: "Koirataudit"},
  {name: "Kalataudit"},
  {name: "Onnettomuudet"}
])
Task.create!([
  {name: "Mittaa kuume", exercise_id: nil},
  {name: "Mittaa häntä", exercise_id: nil},
  {name: "Soita lääkärille", exercise_id: nil}
])
User.create!([
  {username: "Opiskelija", admin: false, email: "opiskelija@eläin.fi", realname: "Ellu Eläinlääketietelijä", password_digest: "$2a$10$y6w8oDECUJQY0Hv5.UuEN.WMjWSraK67k6LBWs3Lfb2Z7kMd.lc7K"},
  {username: "Opettaja", admin: true, email: "opettaja@eläin.fi", realname: "Olli Opettaja", password_digest: "$2a$10$.XMfy39wwO73McrGe5hGEOoYNpF9Z1zPXxoQ8tr0JmfzjE1cc0a8."}
])

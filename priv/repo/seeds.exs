alias CookingQuest.{Repo, User, Stats}

Repo.insert!(%User{name: "jm", email: "jm", stats: %Stats{level: 1, exp: 0}})

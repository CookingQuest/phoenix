alias CookingQuest.{Repo, User, Stats}

Repo.insert!(%User{name: "jm", email: "jm", stats: %Stats{exp: 3000}})

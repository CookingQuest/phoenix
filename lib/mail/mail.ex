defmodule CookingQuest.Mailer do
  use Bamboo.Mailer, otp_app: :cooking_quest
end

# Define your emails
defmodule CookingQuest.Mails do
  import Bamboo.Email

  def registration(mail) do
    new_email(
      to: mail,
      from: {"CookingQuest.com", "support@cookingQuest.com"},
      subject: "Vielen Dank fürs Registrieren bei CookingQuest!",
      html_body: "Klicken sie auf diesen Link um ihre Email Adresse zu verifizieren. Viel Spaß beim Kochen!",
      text_body: "Not one bit."
    )
  end
end

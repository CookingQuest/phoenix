defmodule CookingQuest.Mails do
  import Bamboo.{Email}
  alias CookingQuest.{Endpoint}
  use Bamboo.Phoenix, view: CookingQuest.EmailView

  def registration(mail) do
    new_email(
      to: mail,
      from: {"CookingQuest.com", "support@cookingQuest.com"},
      subject: "Vielen Dank fürs Registrieren bei CookingQuest!",
      html_body: "Klicken sie auf diesen Link um ihre Email Adresse zu verifizieren. Viel Spaß beim Kochen!",
      text_body: "Not one bit."
    )
  end

  def login(token_value, user) do
    new_email(
      to: user.email,
      from: {"CookingQuest.com", "support@cookingQuest.com"},
      subject: "Vielen Dank fürs Registrieren bei CookingQuest!")
      |> assign(:link, login_link(token_value))
      |> render(:login)
  end

  def login_link(token_value) do
    "#{Endpoint.url()}/login/#{token_value}"
  end
end

defmodule CookingQuest.Mailer do
  use Bamboo.Mailer, otp_app: :cooking_quest
end

defmodule CookingQuest.EmailView do
  use Phoenix.View, root: "lib/mail/templates", path: ""
end

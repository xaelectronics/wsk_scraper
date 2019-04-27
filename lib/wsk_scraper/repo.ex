defmodule WskScraper.Repo do
  use Ecto.Repo,
    otp_app: :wsk_scraper,
    adapter: Ecto.Adapters.Postgres
end

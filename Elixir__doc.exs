iex -S mix

# Elixir PostgreSQL Ecto Test Project

This is a complete step-by-step setup for using **Elixir** with **PostgreSQL** and **Ecto**, including migrations, schema, and CRUD operations.

---

## 1️⃣ Install PostgreSQL
- Install **PostgreSQL 18.0 x64** (Windows).
- Create database: `elixir_test`.
- Remember your PostgreSQL password for the `postgres` user.

---

## 2️⃣ Create Elixir Project
```bash
mix new elixir_pg_test --sup
cd elixir_pg_test

--------------------------------------------------------------
#Add Dependencies
defp deps do
  [
    {:ecto_sql, "~> 3.11"},
    {:postgrex, ">= 0.0.0"}
  ]
end
mix deps.get  1️⃣ 
Generate Repo
#mix ecto.gen.repo -r ElixirPgTest.Repo

config/config.exs
import Config

config :elixir_pg_test,
  ecto_repos: [ElixirPgTest.Repo]

config :elixir_pg_test, ElixirPgTest.Repo,
  username: "postgres",
  password: "mypassword123",
  database: "elixir_test",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
lib/elixir_pg_test/application.ex

children = [
  ElixirPgTest.Repo
]
Create Migration
mix ecto.gen.migration create_users
priv/repo/migrations/<timestamp>_create_users.exs
defmodule ElixirPgTest.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :integer
      timestamps()
    end
  end
end
6️⃣ Create Database
mix ecto.create

Run Migration

mix ecto.migrate

Create Schema
lib/elixir_pg_test/user.ex
defmodule ElixirPgTest.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :age, :integer
    timestamps()
  end
end

cmd /c "iex -S mix"
alias ElixirPgTest.{Repo, User}
import Ecto.Query

# Insert data
Repo.insert!(%User{name: "Ghaith", age: 19})
Repo.insert!(%User{name: "Ali", age: 17})

# Query users older than 18
Repo.all(from u in User, where: u.age > 18)

# Update user
user = Repo.get_by(User, name: "Ali")
Repo.update!(Ecto.Changeset.change(user, age: 18))

# Delete user
user = Repo.get_by(User, name: "Ali")
Repo.delete!(user)

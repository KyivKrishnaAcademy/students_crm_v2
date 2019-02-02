# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StudentsCrmV2.Repo.insert!(%StudentsCrmV2.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias StudentsCrmV2.Repo

alias StudentsCrmV2.Models.{
  AcademicGroup,
  Contact,
  Tenant,
  TenantUser,
  User
}

{:ok, tenant} = Repo.insert(%Tenant{name: "kyiv"})

Enum.each(1..75, fn n ->
  {:ok, user} =
    Repo.insert(%User{
      name: "Name_#{n}",
      surname: "Surname_#{n}",
      complex_name: "Surname_#{n} Name_#{n}",
      contacts: [%Contact{kind: "email", value: "student_#{n}@example.com"}]
    })

  Repo.insert(%TenantUser{tenant: tenant, user: user})

  {:ok, group} = Repo.insert(%AcademicGroup{name: "ШБ19-#{n}", tenant: tenant})
end)

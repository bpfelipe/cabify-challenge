defmodule CarPooling.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias CarPooling.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import CarPooling.Factory
      import CarPooling.DataCase
    end
  end

  setup _tags do
    CarPooling.Storage.reset!()
    :ok
  end
end

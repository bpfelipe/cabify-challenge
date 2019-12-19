defmodule Env.Config do
  def get_str(env, default \\ "") when is_binary(default) or is_nil(default) do
    case System.get_env(env) do
      nil -> default
      s -> s
    end
  end

  def get_list(env, default \\ []) when is_list(default) do
    env = System.get_env(env)

    if env do
      String.split(env, ",", trim: true)
    else
      default
    end
  end

  def get_bool(env, default \\ false) when is_boolean(default) do
    case get_str(env, to_string(default)) do
      "true" -> true
      _ -> false
    end
  end

  def get_int(env, default \\ 0) when is_number(default) do
    {n, ""} = Integer.parse(get_str(env, to_string(default)))
    n
  end

  def ensure_defined_str(app, config, keyword) do
    case Application.get_env(app, config)[keyword] do
      "" ->
        raise "ERROR: configuration Application.get_env(#{app}" <>
                ", #{config})[#{keyword}] is required"

      # be happy
      _otherwise ->
        nil
    end
  end

  def get_atom(env, default) when is_atom(default) do
    atom = get_str(env, Atom.to_string(default))
    String.to_atom(atom)
  end

  def get_file_content(env, default \\ []) when is_list(default) do
    with file_path <- get_str(env),
         {:ok, file_content} <- File.read(file_path) do
      file_content
    else
      _ -> default
    end
  end
end

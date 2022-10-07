defmodule HackerNews do
  import Story

  @moduledoc """
  Documentation for `HackerNews`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> HackerNews.hello()
      :world

  """
  def hello do
    :world
  end

  def fetch_news do
    do_fetch()
  end

end

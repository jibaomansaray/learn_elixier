defmodule Story do
  use HTTPoison.Base

  def get_stories_ids do
    Jason.decode(get!("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty").body)
  end

  def get_full_story(story_id) do
    Jason.decode(get_raw_full_story(story_id))
  end

  def get_raw_full_story(story_id) do
    get!("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json?print=pretty").body
  end

  def write_file(content, id) when is_bitstring(content) and is_number(id) do
    File.write(Path.relative("./stories/story_#{id}.json"), content)
  end

  def add_to_10(number) when number + 1 <= 10 do
    number + 1
  end

  defp setup() do
    path = Path.relative("./stories")
    if !File.exists?(path) do
      File.mkdir(path)
    end
    path
  end

  def do_fetch() do
    setup()
    {:ok, ids} = get_stories_ids()

    foo = fn x -> get_raw_full_story(x) |> write_file(x) end
    Enum.each(ids, foo)
  end
end

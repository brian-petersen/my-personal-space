alias Picoquotes.Contexts.{AuthorContext, QuoteContext, UserContext}

{:ok, _user} = UserContext.create_user(%{username: "username", password: "password"})

{:ok, saint_augustine} = AuthorContext.create_author(%{name: "Saint Augustine"})
{:ok, john_lennon} = AuthorContext.create_author(%{name: "John Lennon"})

{:ok, _} =
  QuoteContext.create_quote(%{
    text:
      "Right is right even if no one is doing it; wrong is wrong even if everyone is doing it.",
    author_id: saint_augustine.id
  })

{:ok, _} =
  QuoteContext.create_quote(%{
    text:
      "Right is right even if no one is doing it; wrong is wrong even if everyone is doing it.",
    author_id: saint_augustine.id
  })

{:ok, _} =
  QuoteContext.create_quote(%{
    text:
      "Right is right even if no one is doing it; wrong is wrong even if everyone is doing it.",
    author_id: saint_augustine.id,
    source: "mother's tombstone"
  })

{:ok, _} =
  QuoteContext.create_quote(%{
    text:
      "When I was 5 years old, my mother always told me that happiness was the key to life. When I went to school, they asked me what I wanted to be when I grew up. I wrote down 'happy'. They told me I didn't understand the assignment; I told them they didn't understand life.",
    author_id: john_lennon.id,
    source: "https://google.com"
  })

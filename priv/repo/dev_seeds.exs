alias MyPersonalSpace.Contexts.{AuthorContext, QuoteContext, UserContext}

Faker.start()

# Create a user
{:ok, _user} = UserContext.create_user(%{username: "username", password: "password"})

# Some hardcoded authors and quotes to ensure features are tested
{:ok, _} = AuthorContext.create_author(%{name: "Mr. Nobody"})
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

# Now randomly generated data
Enum.each(1..100, fn _ ->
  {:ok, author} = AuthorContext.create_author(%{name: Faker.Person.name()})

  quote_count = Enum.random(1..3)

  Enum.each(1..quote_count, fn _ -> 
    {:ok, _} =
      QuoteContext.create_quote(%{
        text: Enum.join(Faker.Lorem.sentences(1..5), "\n"),
        author_id: author.id,
      })
  end)

  {:ok, _} =
    QuoteContext.create_quote(%{
      text: Faker.Markdown.markdown(),
      author_id: author.id,
    })
end)

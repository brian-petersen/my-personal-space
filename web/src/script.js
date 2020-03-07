import Vue from 'vue'

const AUTHOR_PATH = /author\/(?<slug>[\w-]+)/

new Vue({
  el: '#app',
  data: {
    quotes: [],
  },
  methods: {
    fetchQuotes () {
      const fetchFunction = fetchQuotesFunction(window.location.pathname)
      
      if (fetchFunction) {
        fetchFunction().then(quotes => this.quotes = quotes)
      }
    }
  },
  created () {
    this.fetchQuotes()
  }
})

function fetchQuotesFunction(path) {
  if (path == '/') {
    return allQuotes
  }
  else if (AUTHOR_PATH.test(path)) {
    return () => {
      const { groups: { slug: slug }} = path.match(AUTHOR_PATH)

      return quotesByAuthor(slug)
    }
  }

  return null
}

function request(body) {
  return fetch('/graphql', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: body
  })
  .then(res => res.json())
}

function allQuotes() {
  const body = JSON.stringify({
    query: `
      {
        quotes {
          text
          author {
            name
            slug
          }
        }
      }
    `
  })

  return request(body)
    .then(({ data: { quotes: quotes }}) => quotes)
}

function quotesByAuthor(slug) {
  const body = JSON.stringify({
    query: `
      {
        authorBySlug(slug: "${slug}") {
          quotes {
            text
            author {
              name
              slug
            }
          }
        }
      }
    `
  })

  return request(body)
    .then(({ data: { authorBySlug: { quotes: quotes }}}) => quotes)
}

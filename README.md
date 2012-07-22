# Super Upload...

## ...and the world of file uploads will probably never be the same again.

- Use [superupload.5v3n.com](http://superupload.5v3n.com) to click though
  - just a heroku app - the uploads are not stored (consequently).
- Use `foreman start` to run the server locally on port 5000 
  - requires local [redis](http://redis.io) db
- Use `rspec spec` to run the specs
  - requires local [redis](http://redis.io) db
  - uses [poltergeist](https://github.com/jonleighton/poltergeist) for headless integration specs
- Use sven@makingthingshappen.de for any questions ;-)
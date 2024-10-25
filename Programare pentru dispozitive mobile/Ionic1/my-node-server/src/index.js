const Koa = require('koa');
const app = new Koa();
const server = require('http').createServer(app.callback());
const WebSocket = require('ws');
const wss = new WebSocket.Server({ server });
const Router = require('koa-router');
const cors = require('koa-cors');
const bodyparser = require('koa-bodyparser');

app.use(bodyparser());
app.use(cors());
app.use(async (ctx, next) => {
  const start = new Date();
  await next();
  const ms = new Date() - start;
  console.log(`${ctx.method} ${ctx.url} ${ctx.response.status} - ${ms}ms`);
});

app.use(async (ctx, next) => {
  try {
    await next();
  } catch (err) {
    ctx.response.body = { message: err.message || 'Unexpected error' };
    ctx.response.status = 500;
  }
});

class Book {
  constructor({ id, title, author, code, releaseDate, liked }) {
    this.id = id;
    this.title = title;
    this.author = author;
    this.code = code;
    this.releaseDate = releaseDate;
    this.liked = liked;
  }
}

const books = [
  new Book({
    id: 1,
    title: "Harry Potter and The Philosopher's Stone",
    author: 'J.K. Rowling',
    code: 1234,
    releaseDate: '1997-06-30',
    liked: true,
  }),
  new Book({
    id: 2,
    title: 'Harry Potter and The Chamber of Secrets',
    author: 'J.K. Rowling',
    code: 5678,
    releaseDate: '1998-07-02',
    liked: false,
  }),
];
//let lastId = 0;
let lastId = books.length > 0 ? Math.max(...books.map(book => book.id)) : 0;

const broadcast = (data) =>
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(JSON.stringify(data));
      }
    });

const router = new Router();


router.get('/books', (ctx) => {
  ctx.response.body = books;
  ctx.response.status = 200;
});


router.get('/books/:id', (ctx) => {
  const bookId = parseInt(ctx.params.id);
  const book = books.find((d) => d.id === bookId);
  if (book) {
    ctx.response.body = book;
    ctx.response.status = 200; // OK
  } else {
    ctx.response.body = { message: `Book with id ${bookId} not found` };
    ctx.response.status = 404; // NOT FOUND
  }
});


router.post('/books', (ctx) => {
  const book = ctx.request.body;
  if (!book.title || !book.author) {
    ctx.response.body = { message: 'Title and author are required' };
    ctx.response.status = 400; // BAD REQUEST
    return;
  }
  lastId++;
  const newBook = new Book({
    id: lastId,
    title: book.title,
    author: book.author,
    code: book.code,
    releaseDate: book.releaseDate,
    liked: book.liked || false,
  });
  books.push(newBook);
  ctx.response.body = newBook;
  ctx.response.status = 201; // CREATED
  broadcast({ event: 'created', payload: newBook });
});


router.put('/books/:id', (ctx) => {
  const bookId = parseInt(ctx.params.id);
  const book = ctx.request.body;
  const index = books.findIndex((b) => b.id === bookId);
  if (index === -1) {
    ctx.response.body = { message: `Book with id ${bookId} not found` };
    ctx.response.status = 404; // NOT FOUND
    return;
  }
  books[index] = { ...books[index], ...book }; // Actualizam cartea
  ctx.response.body = books[index];
  ctx.response.status = 200; // OK
  broadcast({ event: 'updated', payload: books[index] });
});


router.del('/books/:id', (ctx) => {
  const bookId = parseInt(ctx.params.id);
  const index = books.findIndex((b) => b.id === bookId);
  if (index === -1) {
    ctx.response.body = { message: `Book with id ${bookId} not found` };
    ctx.response.status = 404; // NOT FOUND
    return;
  }
  const deletedBook = books.splice(index, 1);
  ctx.response.status = 204; // NO CONTENT
  broadcast({ event: 'deleted', payload: deletedBook });
});

app.use(router.routes());
app.use(router.allowedMethods());
let currentId = 100;
setInterval(() => {
  const book = new Book({
    id: currentId,
    title: "Title",
    author: "Author",
    code: 52,
    releaseDate:"2003/01/20",
    liked: true
  })
  currentId += 1;
  console.log("New book: ", book)
  broadcast({event: 'created', payload: {item: book}});
}, 10000);

server.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});

<!-- 
.. title: Using Parcel JS with Tailwind CSS, Elm Lang and Elm Spa
.. slug: 2021-09-21-parcel-tailwind-css-elm-lang-elm-spa
.. date: 2021-09-21 09:36:00+00:00
.. tags: elm, tailwind, elm-spa, parcel
.. category: 
.. link: 
.. description: 
.. type: text
-->

As I have been struggling to make [Parcel JS](https://v2.parceljs.org/), [Tailwind CSS](https://tailwindcss.com/), [PostCSS](https://postcss.org/), _whatever-the-hell-you-call-it_-CSS, [Elm Lang](https://elm-lang.org/) and [Elm SPA](https://www.elm-spa.dev/) work together I thought that sharing my journey could help some of you. Here it is!

<!-- TEASER_END -->

## Why?

My initial need was: using __Taiwind CSS__ with __Elm Lang__ and __Elm Spa__. It quickly turned into a journey through the classical [Javascript fatigue](https://medium.com/@ericclemmons/javascript-fatigue-48d4011b6fc4) tools and my new need was: find something that just get the job done. Spoiler: it's the case with __Parcel JS__.

## Parcel JS

This bundler just works. We will be using the v2 here (as I had a lot of problems to make the v1 work) so be sure to check the v2 documentation: [https://v2.parceljs.org/](https://v2.parceljs.org/) (note the v2 in the URL).

> Parcel is a compiler for all your code, regardless of the language or toolchain.

> Parcel takes all of your files and dependencies, transforms them, and merges them together into a smaller set of output files that can be used to run your code.

__package.json__
```json
{
  "name": "my-program",
  "version": "1.0.0",
  "devDependencies": {
    "parcel": "latest"
  }
}
```

Then just `npm install`.

Then let's create directories for every type of file we're going to have.

```
.
├── css
├── elm
├── html
└── js
```

Put an example `index.html` file in your `html` folder:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>My First Parcel App</title>
    <link rel="stylesheet" href="../css/styles.css" />
    <script type="module" src="../js/app.js"></script>
  </head>
  <body>
    <h1>Hello, World!</h1>
  </body>
</html>
```

Then a `styles.css` file in your `css` folder:

```css
h1 {
  color: hotpink;
  font-family: cursive;
}
```

And an `app.js` file in your `js` folder:

```javascript
console.log('Hello world!');
```

Then modify your `package.json` to include some parcel scripts:

```json
{
  "name": "my-program",
  "version": "1.0.0",
  "scripts": {
    "start": "parcel html/index.html",
    "build": "parcel build html/index.html"
  },
  "devDependencies": {
    "parcel": "latest"
  }
}
```

Run `npm start` and visit [http://localhost:1234](http://localhost:1234) in your browser, you should get something like that:

![Parcel Hello World](/images/parcel_hello_world.png)

Let's add [Tailwind CSS](https://tailwindcss.com/)

## Tailwind CSS

Install [Tailwind CSS](https://tailwindcss.com/docs/installation) and its dependencies:


```
npm install -D tailwindcss@latest postcss@latest autoprefixer@latest
```

Add `tailwindcss` and `autoprefixer` as plugins in a `.postcssrc.json` file that you should create.

__.postcssrc.json__

```json
{
  "plugins": {
    "tailwindcss": {},
    "autoprefixer": {}
  }
}
```

Then, the next step is to create the configuration file for Tailwind with the following command:

```
npx tailwindcss init
```

This should create a `tailwind.config.js` file with the following content:

```javascript
module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
```

Finally, incude Tailwind in your `styles.css` file:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

h1 {
  color: hotpink;
  font-family: cursive;
}
```

Now you can modify your `index.html` page by adding some Tailwind CSS classes in it.

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>My First Parcel App</title>
    <link rel="stylesheet" href="../css/styles.css" />
    <script type="module" src="../js/app.js"></script>
  </head>
  <body class="bg-gray-200">
    <h1 class="text-4xl">Hello, World!</h1>
    <p class="text-green-500">Testing Tailwind</p>
  </body>
</html>
```

This should display something like that:

![Parcel Hello World Tailwind](/images/parcel_hello_world_tailwind.png)

Ok now, let's add some Elm!

## Elm

First, install the latest Elm version with npm:

```
npm install -D elm@latest-0.19.1
```

Then create an `elm.json` file yourself or let the init script do it for you using `npx elm init`. The most important thing to do is to change the default `source-directories` entry from `src` to `elm` (the directory where we will be putting our elm files). Or if you prefer to use the defaults, rename your `elm` directory to `src` and you will be good to go. Here is my `elm.json` file:

```json
{
    "type": "application",
    "source-directories": [
        "elm"
    ],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
            "elm/browser": "1.0.2",
            "elm/core": "1.0.5",
            "elm/html": "1.0.0"
        },
        "indirect": {
            "elm/json": "1.1.3",
            "elm/time": "1.0.0",
            "elm/url": "1.0.0",
            "elm/virtual-dom": "1.0.2"
        }
    },
    "test-dependencies": {
        "direct": {},
        "indirect": {}
    }
}

```

Then create a `Main.elm` file in your `elm` directory with the following content:

```elm
module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


view : Model -> Html Msg
view model =
    div [ class "m-10 text-4xl" ]
        [ button [ onClick Decrement ] [ text "-" ]
        , div [ class "text-green-400" ] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
```

Modify your `index.html`:

__html/index.html__

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>My First Parcel App</title>
    <link rel="stylesheet" href="../css/styles.css" />
    <script type="module" src="../js/app.js"></script>
  </head>
  <body>
    <div id="myapp"></div>
  </body>
</html>
```

And include your Elm program inside your javascript.

__js/app.js__

```javascript
import { Elm } from '../elm/Main.elm';

Elm.Main.init({ node: document.getElementById('myapp') });
```

Run `npm start` and go to [http://localhost:1234/](http://localhost:1234/) you should see the Elm counter demo with some Tailwind styles:

![Parcel Hello World Tailwind Elm](/images/parcel_hello_world_tailwind_elm.png)


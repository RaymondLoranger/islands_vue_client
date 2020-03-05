# Islands Vue Client - Vue Components + Vuex

Web interface for the _Game of Islands_
featuring **_Vue Components_** and **_Vuex_**.


##### Based on the book [Functional Web Development](https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix) by Lance Halvorsen.

## Installation

1. Install Elixir dependencies:

    ```sh
    mix deps.get
    ```

2. Install Node.js dependencies:

    ```sh
    cd assets && npm install
    ```

    You may see some warnings, but they can be safely ignored.

3. Make sure the assets build:

    ```sh
    cd assets && node node_modules/.bin/brunch build
    ```

4. Make sure all the tests pass:

    ```sh
    mix test
    ```

5. Fire up the Phoenix endpoint:

    ```sh
    mix phx.server
    ```

6. Visit [`localhost:4000`](http://localhost:4000) to play the game!

<br />

<p align="center">
  <img alt="Logo" src="./.github/logo.png" width="120px" />
</p>

<h1 align="center" style="text-align: center;">Flightex</h1>

<p align="center">
	<a href="https://github.com/LuizFerK">
		<img alt="Author" src="https://img.shields.io/badge/author-Luiz%20Fernando-2474E4?style=flat" />
	</a>
	<a href="#">
		<img alt="Languages" src="https://img.shields.io/github/languages/count/LuizFerK/Flightex?color=2474E4&style=flat" />
	</a>
	<a href="hhttps://github.com/LuizFerK/Flightex/stargazers">
		<img alt="Stars" src="https://img.shields.io/github/stars/LuizFerK/Flightex?color=2474E4&style=flat" />
	</a>
	<a href="https://github.com/LuizFerK/Flightex/network/members">
		<img alt="Forks" src="https://img.shields.io/github/forks/LuizFerK/Flightex?color=2474E4&style=flat" />
	</a>
	<a href="https://github.com/LuizFerK/Flightex/graphs/contributors">
		<img alt="Contributors" src="https://img.shields.io/github/contributors/LuizFerK/Flightex?color=2474E4&style=flat" />
	</a>
</p>

<p align="center">
	<b>Buy your flight bookings in a snap!</b><br />
	<span>Created with Elixir.</span><br />
	<sub>Made with ❤️</sub>
</p>

<br />

# :pushpin: Contents

- [Features](#rocket-features)
- [Installation](#wrench-installation)
- [Getting started](#bulb-getting-started)
- [Actions](#triangular_flag_on_post-actions)
- [Techs](#fire-techs)
- [Issues](#bug-issues)
- [License](#book-license)

# :rocket: Features

- Create users
- Create and see your flight bookings
- Generate reports for all the bookings on the platform

# :wrench: Installation

### Required :warning:
- Elixir
- Erlang

### SSH

SSH URLs provide access to a Git repository via SSH, a secure protocol. If you have an SSH key registered in your GitHub account, clone the project using this command:

```git clone git@github.com:LuizFerK/Flightex.git```

### HTTPS

In case you don't have an SSH key on your GitHub account, you can clone the project using the HTTPS URL, run this command:

```git clone https://github.com/LuizFerK/Flightex.git```

**Both of these commands will generate a folder called Flightex, with all the project**

# :bulb: Getting started

1. Run ```mix deps.get``` to install the dependencies
2. This project does not have a server, in this case, the mode of use is through IEx (Elixir's interactive shell), which can be accessed using the command ```iex -S mix``` in the project folder
3. Instead of using a database, this project uses agents to store data as states (only for studying). To start the agent, on the IEx, run `Flightex.start_agents()`

# :triangular_flag_on_post: Actions

* Create user

  ```elixir
  iex(2)> {:ok, user_id} = Flightex.create_user(%{name: "John Doe", email: "johndoe@example.com", cpf: "12345678900"})
  {:ok, "408d3709-9d78-42cc-8a19-33c351ad334a"}
  ```

* Create booking

  ```elixir
  iex(3)> {:ok, booking_id} = Flightex.create_booking(user_id, %{date: "2020-05-22", from_city: "city1", to_city: "city2"})
  {:ok, "9e7b19d3-4147-45ee-85da-549ed59f72e1"}
  ```

* Get booking

  ```elixir
  iex(4)> Flightex.get_booking(booking_id)
  {:ok,
    %Flightex.Bookings.Booking{
      date: ~N[2020-05-22 00:00:00],
      from_city: "city1",
      id: "9e7b19d3-4147-45ee-85da-549ed59f72e1",
      to_city: "city2",
      user_id: "408d3709-9d78-42cc-8a19-33c351ad334a"
    }}
  ```

* Generate Report

  ```elixir
  iex(5)> Flightex.generate_report("2020-05-21", "2020-05-22")
  {:ok, "Report generated successfully"}
  ```

  The result of this action is on `report.csv`:
  ```
  408d3709-9d78-42cc-8a19-33c351ad334a,city1,city2,2020-05-22 00:00:00
  ```

# :fire: Techs

### Elixir
- Agent
- Elixir UUID

# :bug: Issues

Find a bug or error on the project? Please, feel free to send me the issue on the [Flightex issues area](https://github.com/LuizFerK/Flightex/issues), with a title and a description of your found!

If you know the origin of the error and know how to resolve it, please, send me a pull request, I will love to review it!

# :book: License

Released in 2020.

This project is under the [MIT license](https://github.com/LuizFerK/Flightex/blob/main/LICENSE).

<p align="center">
	< keep coding /> :rocket: :heart:
</p>

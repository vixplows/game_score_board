DROP TABLE players_sessions;
DROP TABLE sessions;
DROP TABLE players;
DROP TABLE results;
DROP TABLE games;
DROP TABLE types;


CREATE TABLE types
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null
);

CREATE TABLE games
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  type_id INT8 references types(id),
  image TEXT
);

CREATE TABLE results 
(
  id SERIAL8 primary key,
  tag VARCHAR(255) not null
);

CREATE TABLE players
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  image TEXT
);

CREATE TABLE sessions
(
  id SERIAL8 primary key,
  game_id INT8 references games(id) ON DELETE CASCADE,
  date DATE,
  start_time TIME,
  end_time TIME
);


CREATE TABLE players_sessions
(
  id SERIAL8 primary key,
  player_id INT8 references players(id) ON DELETE CASCADE,
  session_id INT8 references sessions(id) ON DELETE CASCADE,
  result_id INT8 references results(id) ON DELETE CASCADE,
  points INT8
);
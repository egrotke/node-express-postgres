CREATE TABLE album (
  id serial primary key,
  description varchar(255)
);

CREATE TABLE photo (
  id serial primary key,
  album_id integer,
  description varchar(255),
  filepath varchar(255)
);

CREATE TABLE accounts (
  id serial primary key,
  acct_no varchar(31),
  acct_type varchar(31),
  created_at timestamp,
  updated_at timestamp,
  balance decimal,
  name varchar(255),
  is_internal boolean
);
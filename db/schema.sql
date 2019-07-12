CREATE TABLE IF NOT EXISTS cohorts (
  id SERIAL PRIMARY KEY,
  cohort_name text NOT NULL UNIQUE,
  phase text,
  status text
);

CREATE TABLE IF NOT EXISTS students (
  id SERIAL PRIMARY KEY,
  first_name text NOT NULL,
  last_name text NOT NULL,
  github text UNIQUE NOT NULL,
  status text NOT NULL,
  cohort_id integer REFERENCES cohorts ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS teams (
  id SERIAL PRIMARY KEY,
  team_name text NOT NULL,
  team_type text NOT NULL,
  github text NOT NULL UNIQUE,
  cohort_id integer REFERENCES cohorts ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS team_student (
  id SERIAL PRIMARY KEY,
  team_id integer REFERENCES teams ON DELETE CASCADE,
  student_id integer REFERENCES students ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS sprints (
  id SERIAL PRIMARY KEY,
  sprint_name text NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS messages (
  id SERIAL PRIMARY KEY,
  message_text text NOT NULL,
  sprint_id integer REFERENCES sprints ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS student_sprints (
  id SERIAL PRIMARY KEY,
  student_id integer REFERENCES students ON DELETE CASCADE,
  sprint_id integer REFERENCES sprints ON DELETE CASCADE,
  fork boolean NOT NULL,
  bmr boolean NOT NULL,
  percent_complete integer
);

CREATE TABLE IF NOT EXISTS student_sprints_commits (
  id SERIAL PRIMARY KEY,
  commit_text text NOT NULL,
  is_master boolean,
  is_milestone boolean,
  branch_name text,
  student_sprints_id integer REFERENCES student_sprints ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS team_student_weekly_contributions (
  id SERIAL PRIMARY KEY,
  team_student_id integer REFERENCES team_student,
  date_checked date NOT NULL,
  num_changes integer NOT NULL,
  num_commits integer NOT NULL
);









create table content_types (
  id text primary key,
  label text not null,
  created_at timestamp with time zone default now() not null,
  updated_at timestamp with time zone default now() not null
);

alter table public.content_types enable row level security;


INSERT INTO content_types (id, label) VALUES ('note', 'Note');
INSERT INTO content_types (id, label) VALUES ('task', 'Task');
INSERT INTO content_types (id, label) VALUES ('mcq', 'MCQ');


create table content_blocks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title text not null,
    url text null,
    body text not null,
    content_type text references content_types(id) default 'task',
    
    media JSONB[], -- media[] - {media_type, url, title, description, duration, uploader}
    attributes JSONB, -- attributes - for mcq {options, correct_option }

    hide boolean default false not null,

    creator_id uuid references profiles(id) not null,
    created_at timestamp with time zone default now() not null,
    updated_at timestamp with time zone default now() not null
);
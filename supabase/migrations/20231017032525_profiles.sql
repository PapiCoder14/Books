insert into storage.buckets
  (id, name)
values
  ('bookysh', 'bookysh');

create policy "Public Access to bookysh bucket"
  on storage.objects for select
  using ( bucket_id = 'bookysh' );

insert into storage.buckets
  (id, name)
values
  ('users', 'users');

create policy "Public Access to users bucket"
  on storage.objects for select
  using ( bucket_id = 'users' );

CREATE POLICY "user manages folder actions 1ufimg_0" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id = 'users' and (storage.foldername(name))[1]=auth.uid()::text);

CREATE POLICY "user manages folder actions 1ufimg_1" ON storage.objects FOR UPDATE TO authenticated USING (bucket_id = 'users' and (storage.foldername(name))[1]=auth.uid()::text);


create table subscription_type (
  id text primary key,
  label text not null,
  created_at timestamp with time zone default now() not null,
  updated_at timestamp with time zone default now() not null
);

alter table public.subscription_type enable row level security;


INSERT INTO subscription_type (id, label) VALUES ('free', 'Free');
INSERT INTO subscription_type (id, label) VALUES ('premium', 'Premium');

create table site_roles (
  id text primary key,
  label text not null,
  created_at timestamp with time zone default now() not null,
  updated_at timestamp with time zone default now() not null
);

alter table public.site_roles enable row level security;

INSERT INTO site_roles (id, label) VALUES ('admin', 'Admin');
INSERT INTO site_roles (id, label) VALUES ('user', 'User');


create table public.user_accounts(
  id uuid unique references auth.users on delete cascade,
  email text unique,
  username text unique,
  display_name text,
  avatar_url text DEFAULT 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
--   onboarded boolean default false not null,
  
  subscription_id text references subscription_type(id) default 'free',
  role_id text references site_roles(id),

  updated_at timestamp with time zone default now() not null,
  created_at timestamp with time zone default now() not null,
  primary key (id)
);

alter table public.user_accounts enable row level security;

create policy "Users can view own profile" on public.user_accounts
  for select to authenticated
    using (auth.uid() = id);


create table public.profiles(
  id uuid unique references auth.users on delete cascade,
  username text unique,
  display_name text,
  avatar_url text DEFAULT 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
  about_me text default '',
  
  updated_at timestamp with time zone default now() not null,
  created_at timestamp with time zone default now() not null,
  primary key (id)
);

alter table public.profiles enable row level security;

create policy "Users can view own profile" on profiles
  for select
    using (true);

create policy "Users can update own profile" on profiles
  for update to authenticated
    using (auth.uid() = id);


create or replace function public.handle_new_user()
returns trigger as $$
declare
  temp_username TEXT;
  prefix_email TEXT;
  var_provider TEXT;
  var_name TEXT;
  var_img_url TEXT;
  user_exists INTEGER;
begin
  -- Safely handle the email being NULL
  IF new.email IS NULL THEN
    RAISE EXCEPTION 'Email cannot be NULL';
  END IF;

  prefix_email = regexp_replace(split_part(new.email,'@',1),'[^\w]+|_','','g');
  temp_username = concat(prefix_email,floor(random()*1000000)::text, 6, '0');

  var_provider := new.raw_app_meta_data->>'provider';
  
  if var_provider like 'google' then
    -- Safely extract name and picture, setting them to empty strings if they don't exist
    var_name := COALESCE(new.raw_user_meta_data->>'name', '');
    var_img_url := COALESCE(new.raw_user_meta_data->>'picture', '');
  else 
    var_name:=COALESCE(new.raw_user_meta_data ->> 'full_name', '');
    var_img_url:='https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
  end if;

  BEGIN
    insert into public.profiles 
    (id, display_name, username, avatar_url)
    values (new.id, var_name, temp_username, var_img_url);
  EXCEPTION WHEN OTHERS THEN
    RAISE EXCEPTION 'Failed to insert into users: %', SQLERRM;
  END;

  BEGIN
    insert into public.user_accounts 
    (id, display_name, username, email, avatar_url)
    values (new.id, var_name, temp_username, new.email, var_img_url);
  EXCEPTION WHEN OTHERS THEN
    RAISE EXCEPTION 'Failed to insert into users: %', SQLERRM;
  END;

  
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users for each row
  execute procedure public.handle_new_user();
-- Professor Online — modelo inicial PostgreSQL
-- IDs UUID; timestamps em UTC.

CREATE TABLE users (
  id UUID PRIMARY KEY,
  role TEXT NOT NULL CHECK (role IN ('TEACHER','STUDENT','ASSISTANT')),
  google_subject_id TEXT,
  email TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE classes (
  id UUID PRIMARY KEY,
  teacher_id UUID NOT NULL REFERENCES users(id),
  name TEXT NOT NULL,
  description TEXT,
  timezone TEXT NOT NULL DEFAULT 'America/Sao_Paulo',
  drive_folder_id TEXT,
  calendar_id TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE class_members (
  class_id UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'ACTIVE',
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (class_id, student_id)
);

CREATE TABLE subjects (
  id UUID PRIMARY KEY,
  class_id UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE lessons (
  id UUID PRIMARY KEY,
  class_id UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  subject_id UUID REFERENCES subjects(id),
  starts_at TIMESTAMPTZ NOT NULL,
  ends_at TIMESTAMPTZ,
  title TEXT NOT NULL,
  topic TEXT,
  calendar_event_id TEXT,
  meeting_uri TEXT,
  status TEXT NOT NULL DEFAULT 'SCHEDULED'
);

CREATE TABLE materials (
  id UUID PRIMARY KEY,
  owner_id UUID NOT NULL REFERENCES users(id),
  lesson_id UUID REFERENCES lessons(id),
  title TEXT NOT NULL,
  category TEXT NOT NULL,
  mime_type TEXT,
  drive_file_id TEXT,
  drive_web_url TEXT,
  status TEXT NOT NULL DEFAULT 'PRIVATE',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE evaluations (
  id UUID PRIMARY KEY,
  class_id UUID NOT NULL REFERENCES classes(id),
  subject_id UUID REFERENCES subjects(id),
  title TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'DRAFT',
  total_points NUMERIC(8,2) NOT NULL DEFAULT 10,
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE grades (
  id UUID PRIMARY KEY,
  evaluation_id UUID NOT NULL REFERENCES evaluations(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES users(id),
  score NUMERIC(8,2),
  feedback TEXT,
  correction_source TEXT NOT NULL DEFAULT 'HUMAN',
  status TEXT NOT NULL DEFAULT 'DRAFT',
  approved_by UUID REFERENCES users(id),
  approved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (evaluation_id, student_id)
);

CREATE TABLE timeline_events (
  id UUID PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL,
  title TEXT NOT NULL,
  payload JSONB NOT NULL DEFAULT '{}',
  occurred_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE domain_events (
  id UUID PRIMARY KEY,
  type TEXT NOT NULL,
  aggregate_type TEXT NOT NULL,
  aggregate_id UUID NOT NULL,
  actor_user_id UUID REFERENCES users(id),
  payload JSONB NOT NULL DEFAULT '{}',
  schema_version INTEGER NOT NULL DEFAULT 1,
  occurred_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE audit_logs (
  id UUID PRIMARY KEY,
  actor_user_id UUID REFERENCES users(id),
  action TEXT NOT NULL,
  resource_type TEXT NOT NULL,
  resource_id UUID,
  before_data JSONB,
  after_data JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_classes_teacher ON classes(teacher_id);
CREATE INDEX idx_members_student ON class_members(student_id);
CREATE INDEX idx_lessons_class_date ON lessons(class_id, starts_at);
CREATE INDEX idx_materials_owner ON materials(owner_id);
CREATE INDEX idx_grades_student ON grades(student_id);
CREATE INDEX idx_timeline_student_date ON timeline_events(student_id, occurred_at DESC);
CREATE INDEX idx_domain_events_aggregate ON domain_events(aggregate_type, aggregate_id);
CREATE INDEX idx_audit_resource ON audit_logs(resource_type, resource_id);

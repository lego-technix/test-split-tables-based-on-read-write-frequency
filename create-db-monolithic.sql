create table users (
  "id" serial primary key,
  "firstName" character varying(255) not null,
  "lastName" character varying(255) not null,
  "email" character varying(255),
  "createdAt" timestamp with time zone not null default ('now'::text)::timestamp with time zone,
  "updatedAt" timestamp with time zone not null default ('now'::text)::timestamp with time zone,
  "cgu" boolean,
  "pixOrgaTermsOfServiceAccepted" boolean default false,
  "pixCertifTermsOfServiceAccepted" boolean default false,
  "hasSeenAssessmentInstructions" boolean default false,
  "username" character varying(255),
  "mustValidateTermsOfService" boolean not null default false,
  "lastTermsOfServiceValidatedAt" timestamp with time zone,
  "lang" character varying(255) not null default 'fr'::character varying,
  "hasSeenNewDashboardInfo" boolean default false,
  "isAnonymous" boolean default false,
  "emailConfirmedAt" timestamp with time zone,
  "hasSeenFocusedChallengeTooltip" boolean default false,
  "lastLoggedAt" timestamp with time zone,
  "hasSeenOtherChallengesTooltip" boolean default false,
  "lastPixOrgaTermsOfServiceValidatedAt" timestamp with time zone,
  "lastPixCertifTermsOfServiceValidatedAt" timestamp with time zone,
  unique (email),
  unique (username)
);

create index "users_email_lower" on "users"(LOWER("email"));

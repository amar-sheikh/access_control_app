# Access Control App with Parental Consent

A Ruby on Rails application for managing age-restricted content access within organizations. It includes Devise authentication, user role management, permission control, an invitation system, and a parental consent workflow for underage users.


## How application works

https://github.com/user-attachments/assets/9a2563c5-2c07-47d2-9a42-c1c81d037cf1

## Features

- Devise-based authentication for OrgUsers
- Multi-organization architecture
- Role and permission system
- User invitation & registration flow
- Content access restrictions by age
- Parental consent via email with expiration
- Expiring tokens (consent valid for 24 hours)
- Mailer integration with Mailcatcher (for local testing)


## Getting Started

### Prerequisites

- Ruby 3.2+
- Rails 7.2+
- PostgreSQL
- Mailcatcher (for development emails)

### Installation
  ```bash
  git clone https://github.com/your-org/access-control-app.git
  cd access-control-app
  bundle install
  rails db:create db:migrate
  rails permissions:load
  rails serve
  ```

### Authentication & Role Management
The app uses Devise for authentication.
- On Sign-Up:
  - A new Organization is created.
  - A Admin role is created
  - A OrgUser is created and assigned the default Admin role.
  - All permissions got assigned to Admin role.
- Admin can view and manage all the things as all permissions are assigned to it.


### Organization Membership through Invitation
- User role having permission to manage users can invites a user.
- The system sends an email with a registration link.
- Invited user completes sign-up and joins the organization with their assigned role.
- User can become member through invitation only.

### Permissions System
- Admin can add other roles.
- Each permission maps to a feature and user can access that feature if he have permission of that feature.
- Uses can? or authorize! to check in controllers/views.
- rails permission:load, to load to permissions to databse.

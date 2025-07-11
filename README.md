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

The application uses **Devise** for authentication and implements role-based access control.

- **During Sign-Up:**
  - A new **Organization** is created.
  - A default **Admin Role** is generated.
  - An **OrgUser** is created and assigned the Admin role.
  - All available permissions are automatically assigned to the Admin role.

- **Admin Capabilities:**
  - The Admin has full access and can manage users, roles, permissions, and content across the organization.

### Organization Membership via Invitation

- Users with the `manage_users` permission can invite others to join the organization.
- The system sends an invitation email containing a secure registration link.
- The invited user completes the sign-up process and automatically joins the organization with the assigned role.
- Membership is invitation-based — users **cannot** join an organization without being invited.

### Permissions System

- The **Admin** role can create and manage additional **user roles**.
- Each **permission** maps to a specific feature or action in the application.
- A user can access a feature **only if** their assigned role includes the required permission.
- Use `can?` or `authorize!` helpers in **controllers** and **views** to enforce permissions.
- Run `rails permissions:load` to populate the database with all defined permissions from `config/permissions.yml`.


### Parental Consent Access Control

- User tries to access **age-restricted content**.
- The system checks if the user meets the **minimum age requirement**.
- If the user is **underage**, a warning is displayed along with a **“Request Parental Consent”** button.
- The user submits their **parent's email** (must belong to the same organization).
- The system sends an **email to the parent** with a **unique tokenized approval link**.
- The **approval link is valid for 5 minutes**. Once approved, the **consent remains valid for 24 hours**.
- After approval, the user is marked as having **temporary parental consent**.
- Once the 24-hour period ends, the **consent automatically expires**.
- The user must **request consent again** to access restricted content after expiration.


variable "prefix" {
  description = "The prefix used for all resources"
}

variable "psqlserver_administrator_login" {
  description = "The administrator login for the PostgreSQL Server"
}

variable "psqlserver_administrator_login_password" {
  description = "The administrator login password for the PostgreSQL Server"
}

variable "jwt_secret" {
  description = "The secret used to sign JWT tokens"
}

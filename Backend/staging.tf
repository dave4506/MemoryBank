variable "MONGO_USER" {}
variable "MONGO_PASSWORD" {}
variable "AWS_ACCESSKEYID" {}
variable "AWS_SECRETACCESSKEY" {}

provider "heroku" {}

resource "heroku_app" "default" {
  name   = "memorybank-staging"
  region = "us"
  stack  = "container"

  config_vars = {
    MONGO_USER = "${var.MONGO_USER}"
  }

  sensitive_config_vars = {
    MONGO_PASSWORD = "${var.MONGO_PASSWORD}"
    AWS_ACCESSKEYID = "${var.AWS_ACCESSKEYID}"
    AWS_SECRETACCESSKEY = "${var.AWS_SECRETACCESSKEY}"
  }
}

resource "heroku_build" "default" {
  app        = "${heroku_app.default.id}"

  source = {
    # A local directory, changing its contents will
    # force a new build during `terraform apply`
    path = "../Backend"
  }
}
